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

"""
	load_pdf_data()

Returns a 4D array of pdf representations together with codes of original files and a vector containing
the number of pages.
"""
function load_pdf_data()
	extracted_data = load(PdfFraud.extracted_data)
	representations = extracted_data["representations"]
	sha256 = extracted_data["sha256"]

	# this has to be sone in this way, otherwise stack overflow errs
	lens = map(x->size(x,3), representations)
	inds = cumsum(lens)
	X = zeros(Float32, 64,48,1,sum(lens))
	for (i,representation) in enumerate(representations)
		X[:,:,:,(inds[i]-lens[i]+1):inds[i]] = reshape(representation, 64, 48, 1, :)
	end
	X, sha256, lens
end