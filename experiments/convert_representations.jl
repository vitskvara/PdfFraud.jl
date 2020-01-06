# this is a script to convert the representations to an easily readable format
using PdfFraud
using JLD2
using FileIO
using ProgressMeter

# first gather data and their labels
data_path = joinpath(PdfFraud.proto_path, "protos")
protos = joinpath.(data_path, readdir(data_path))

function load_representation(file::String)
	data = PdfFraud.read_pb(file)
	y = PdfFraud.visual_representation(data)
	(length(y) == 0) ? nothing : PdfFraud.reshape_representation(y)
end

outfile = joinpath(PdfFraud.proto_path, "extracted_representations/data.jld2")

sha256 = []
representations = []
N = length(protos)
p = Progress(N,1)
for (i, proto) in enumerate(protos)
	x = load_representation(proto)
	if x != nothing
		push!(representations, x)
		push!(sha256, split(basename(proto), ".")[1])
	end
	next!(p)
end

# also get labels
indexf = joinpath(PdfFraud.proto_path, "index.json")
labelf = "/home/vit/vyzkum/bulletproof/pdf_experiment/gt-clustering-pdfs.txt"
labels, labeled_sha256, filenames = PdfFraud.get_labels(sha256, indexf, labelf);

@save outfile sha256 representations labels
