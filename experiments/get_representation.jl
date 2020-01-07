using PdfFraud
using GenerativeModels
using Flux
using ValueHistories
using ArgParse
using BSON
using GMExtensions
using CuArrays
using DelimitedFiles, DataFrames, CSV

# this is for running the script from REPL - default values
if length(ARGS) == 0
	push!(ARGS, "test")
end
# parse arguments
s = ArgParseSettings()
@add_arg_table s begin
    "modelpath"
    	default = ""
    	arg_type = String
    	help = "a master dir of where the models are saved"
    "--imodels"
    	default = [0]
    	help = "only compute models given by indices"
    	arg_type = Int
    	nargs = '+'
end
parsed_args = parse_args(ARGS, s)

# extract settings from the parsed arguments
modelpath = parsed_args["modelpath"]
modelpath = (length(modelpath) > 0 && modelpath[1] == "/") ? modelpath : 
	joinpath(PdfFraud.experiment_path, modelpath, "models")
reprpath = joinpath(dirname(modelpath), "representations") 
mkpath(reprpath)
imodels = parsed_args["imodels"]

# get labeled data
data, labels, sha256, page_nums = PdfFraud.load_pdf_data()
data = data |> gpu;

# save the page info
lf = joinpath(reprpath, "index.csv")
index = DataFrame()
index[!,:sha256] = vcat(map(x->repeat([x[1]], x[2]), zip(sha256, page_nums))...)
index[!,:page] = vcat(map(x->1:x, page_nums)...)
CSV.write(lf, index)

# load model(s)
model_files = joinpath.(modelpath, readdir(modelpath))
@info "Found $(length(model_files)) saved models."
if imodels[1] != 0
	model_files = model_files[imodels]
end
@info "Continuing with $(length(model_files)) models."

# now get the representations
for mf in model_files
	model, history, exp_params = PdfFraud.load_model(mf)
	model = model |> gpu
	Z = PdfFraud.encode(model, data, 32, mean) |> cpu;

	# and save them so they can be easily read back
	zf = joinpath(reprpath, replace(basename(mf), ".bson"=>"_encodings.csv"))
	DelimitedFiles.writedlm(zf, Z', ',')
	@info "Succesfuly written $zf"
end

# now lets check the encodings
zfs = joinpath.(reprpath, filter(x->x!="index.csv", readdir(reprpath)))
Zs = map(zf -> readdlm(zf, ',') ,zfs)

# now lets check out the encodings
linds = map(x->x!=nothing,labels)
Y = labels[linds];

figure()
for iz in 1:length(Zs)
	subplot(5,2,iz)
	Z = Zs[iz][linds,:];
	for y in unique(Y)
		inds = Y .== y
		scatter(Z[inds,1], Z[inds,2])
	end
	title(iz)
end
tight_layout()
