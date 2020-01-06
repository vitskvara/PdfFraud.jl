using PdfFraud
using JSON
using CSV

# get representations and their sha256 codes
X, sha256, page_nums = PdfFraud.load_pdf_data()

# files
indexf = joinpath(PdfFraud.proto_path, "index.json")
labelf = "/home/vit/vyzkum/bulletproof/pdf_experiment/gt-clustering-pdfs.txt"

# get the labels
labels, labeled_sha256, filenames = PdfFraud.get_labels(sha256, indexf, labelf);
labels_x = vcat(map(x -> repeat([x[1]], x[2]), zip(labels, page_nums))...)

######### there are some pdfs that share sha256 ##########
sum(map(x -> x != nothing, labels)) # some labeled data is not present in the dataset
shas = Array{Any,1}()
for fn in labeldata[!,:file]
	sha = sha256[map(x -> x == fn, filenames)] 
	if length(sha) > 0
		push!(shas, sha[1])
	else
		println(fn)
		push!(shas, nothing)
	end
end

fn = "2016_06_14_Faktura.pdf"
filenames .== fn
is = index["original_name"] .== fn
index["original_name"][is]
sha = "0836db253a5b6cf36737a1e98806377f32b798e6e2d6d44fc99718fa65116cda"
labeldata[!,:file] .== fn
filenames[filenames .== fn]
fname = index["original_name"][map(y -> sha == y, index["sha256"])] 