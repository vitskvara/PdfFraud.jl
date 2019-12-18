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
using Dates
using ValueHistories
using ProgressMeter
using ArgParse 
using MLDataPattern

# this is for running the script from REPL - default values
if length(ARGS) == 0
	push!(ARGS, "2")
	push!(ARGS, "2")
	push!(ARGS, "4")
end

# parse arguments
s = ArgParseSettings()
@add_arg_table s begin
    "ldimsize"
    	required = true
    	arg_type = Int
    	help = "size of latent dimension"
   "channels"
    	required = true
    	arg_type = Int
    	help = "a list of channel numbers"
    	nargs = '+'
    "--scaling"
    	default = [2]
    	help = "a scalar or a vector of scaling factors"
    	arg_type = Int
    	nargs = '+'
    "--kernelsize"
    	default = [5]
    	help = "a scalar or a vector of kernelsizes"
    	arg_type = Int
    	nargs = '+'
    "--eta"
    	default = 0.001f0
    	arg_type = Float32
    	help = "learning rate"
    "--nepochs"
    	default = 10
    	arg_type = Int
    	help = "number of training epochs"
    "--batchsize"
    	default = 64
    	arg_type = Int
    	help = "batch size"
    "--beta"
    	default = 1.0f0
    	arg_type = Float32
    	help = "elbo β"
    "--savepath"
    	default = ""
    	arg_type = String
    	help = "where should the model be saved"
end
parsed_args = parse_args(ARGS, s)

# extract settings from the parsed arguments
vectorize(x) = (length(x) == 1) ? repeat(x, nconv) : x
ldim = parsed_args["ldimsize"]
channels = parsed_args["channels"]
nconv = length(channels)
scalings = vectorize(parsed_args["scaling"])
kernelsizes = vectorize(parsed_args["kernelsize"])
η = parsed_args["eta"]
nepochs = parsed_args["nepochs"]
batchsize = parsed_args["batchsize"]
β = parsed_args["beta"]
savepath = parsed_args["savepath"]

# get data
X, sha256, page_nums = PdfFraud.load_pdf_data()
X = X |> gpu

# construct the convolutional VAE model
(h, w, c) = size(X)[1:3]
densedims = [256]
vecdim = reduce(*, (h,w,c))
T = Float32

encoder = GMExtensions.conv_encoder((h, w, c), ldim*2, kernelsizes, channels, scalings; 
	densedims = densedims) |> gpu
enc_dist = CMeanVarGaussian{DiagVar}(encoder)

decoder = GMExtensions.conv_decoder((h, w, c), ldim, reverse(kernelsizes), 
	reverse(channels), reverse(scalings); densedims = densedims, vec_output = true,
	vec_output_dim = vecdim + 1) |> gpu
dec_dist = CMeanVarGaussian{ScalarVar}(decoder)

model = VAE(ldim, enc_dist, dec_dist)

# create stuff for training
loss(x) = PdfFraud.elbo(model, x, β=β)
opt = ADAM(η)
data = RandomBatches(X, batchsize, ceil(Int, size(X,4)/batchsize))
h = MVHistory()
prog = Progress(nepochs*length(data))
cb = PdfFraud.history_progress_cb(prog, model, x, h, loss)
mkpath(savepath)
filename = joinpath(savepath, "$(now()).bson")

# train
Flux.@epochs nepochs Flux.train!(loss, params(model), data, opt, cb = cb)

# and save the model
save_checkpoint(filename, model, h)