# this is a script to train a basic VAE on the protobuffer pdf data
using GenerativeModels
using GMExtensions
using ConditionalDists
using PdfFraud
using JLD2
using PyPlot
using FileIO
using Flux
using CuArrays
import GenerativeModels: elbo
using Dates
using ValueHistories
using ProgressMeter


"""
	elbo(model, x[; β])

Elbo loss function for convolutional models and 4D inputs.
"""
function elbo(m::GenerativeModels.AbstractVAE, x::AbstractArray{T,4}; β=1) where T
    z = rand(m.encoder, x)
    vecdim = reduce(*, size(x)[1:3])
    llh = mean(-loglikelihood(m.decoder, reshape(x, vecdim, :), z))
    kld = mean(kl_divergence(m.encoder, m.prior, x))
    llh + β*kld
end

"""
	reconstruct(m,x)

Reconstructs a sample `x` through the model `m`.	
"""
reconstruct(m,x) = reshape(mean(m.decoder, rand(m.encoder, x)), size(x))
reconstruct(x) = reconstruct(model, x)

"""
	history_progress_cb(prog, model, test_data, history, elbo)

Returns a callback function that stores loss values in the history object and also
prints the current progress.
"""
function history_progress_cb(prog::Progress, model::GenerativeModels.AbstractVAE, test_data::AbstractArray,
							 h::MVHistory, elbox::Function)
	function cb()
		# get losses
		elbo = elbox(test_data) |> cpu
		mse = Flux.mse(test_data, reconstruct(model, test_data)) |> cpu

		# write them to history
		ntuple = GMExtensions.@ntuple elbo mse
		GMExtensions.push_ntuple!(h, ntuple)

		# update the progress bar
		next!(prog, showvalues = [(k, ntuple[k]) for k in keys(ntuple)])
	end
end

# first gather data and their labels
extracted_data = load(PdfFraud.extracted_data)
representations = extracted_data["representations"]
sha256 = extracted_data["sha256"]

# nope ... stack overflow errs
# X = cat(representations..., dims=3)
lens = map(x->size(x,3), representations)
inds = cumsum(lens)
X = zeros(64,48,1,sum(lens))
for (i,representation) in enumerate(representations)
	X[:,:,:,(inds[i]-lens[i]+1):inds[i]] = reshape(representation, 64, 48, 1, :)
end
X = X |> gpu

# for testing purposes, delete after
x = X[:,:,:,1:2]

(h, w, c) = size(X)[1:3]
ldim = 32
kernelsizes = (3, 5)
nchannels = (4, 8)
scalings = (2, 2)
densedims = [256]
vecdim = reduce(*, (h,w,c))
T = Float32

encoder = GMExtensions.conv_encoder((h, w, c), ldim*2, kernelsizes, nchannels, scalings; 
	densedims = densedims) |> gpu
enc_dist = CMeanVarGaussian{DiagVar}(encoder)

decoder = GMExtensions.conv_decoder((h, w, c), ldim, reverse(kernelsizes), 
	reverse(nchannels), reverse(scalings); densedims = densedims, vec_output = true,
	vec_output_dim = vecdim + 1) |> gpu
dec_dist = CMeanVarGaussian{ScalarVar}(decoder)

model = VAE(ldim, enc_dist, dec_dist)

z = rand(model.encoder, x)
y = mean(model.decoder, z)

β = 1.0
loss(x) = elbo(model, x, β=β)
opt = ADAM(0.0005)
GenerativeModels.update_params!(model, (x,), loss, opt)

_data = [(x,) for _ in 1:500]
h = MVHistory()
prog = Progress(20*length(_data))
cb = history_progress_cb(prog, model, x, h, loss)

Flux.@epochs 20 Flux.train!(loss, params(model), _data, opt, cb = cb)


rx = reconstruct(x)

figure(figsize=(10,5))
subplot(121)
pcolormesh(x[:,:,1,1])
subplot(122)
pcolormesh(rx[:,:,1,1])

figure(figsize=(10,5))
subplot(121)
pcolormesh(x[:,:,1,2])
subplot(122)
pcolormesh(rx[:,:,1,2])

#cmodel = model |> cpu

filename = "$(now()).bson"

save_checkpoint(filename, model, h)

# test loading of the model
filename = filter(x->occursin("bson", x), readdir("."))[1]
model, h = load_checkpoint(filename)
model = model |> gpu
rx = reconstruct(x)
