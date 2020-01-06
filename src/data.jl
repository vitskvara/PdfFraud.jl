pkg_path = dirname(dirname(pathof(PdfFraud)))
data_path = joinpath(pkg_path, "data")

# first make sure that the proto source files are in place
plugin_path = joinpath(dirname(pathof(ProtoBuf)), "../plugin/protoc-gen-julia")
proto_path = joinpath(data_path, "proto")

"""
	build_proto_definition()

Builds the correct ProtoBuffer Julia definitions.
"""
function build_proto_definition()
	println("Building the protobuffer definitions.")
	cmd = `-I=$(data_path) --plugin=protoc-gen-julia=$(plugin_path) --julia_out=$(proto_path) $(data_path)/sample.proto`
	run(ProtoBuf.protoc(cmd))
	println("Done.")
end

mkpath(proto_path)
if length(readdir(proto_path)) == 0
	build_proto_definition()
end

include(joinpath(proto_path, "google.jl"))
include(joinpath(proto_path, "sample_pb.jl"))


"""
	read_pb(fs::String)

Reads the whole ProtoBuffer data object from file. 
"""
function read_pb(fs::String)
	open(fs) do f
		readproto(f, PdfSampleRaw())
	end
end

_hostname = gethostname()
proto_path = ""
extracted_data = ""
if _hostname == "vit-ThinkPad-E470"
	proto_path = "/home/vit/vyzkum/bulletproof/pdf_experiment/data/uloz_to_2019_11_05/"
elseif	_hostname in ["gpu-node", "gpu-titan"]
	proto_path = "/compass/home/skvara/vyzkum/bulletproof/pdf_experiment/data/uloz_to_2019_11_05/"
elseif	_hostname == "tarbik.utia.cas.cz"
	proto_path = "/home/skvara/work/bulletproof/pdf_experiment/data/uloz_to_2019_11_05/"
end
if proto_path != ""
	extracted_data = joinpath(proto_path, "extracted_representations/data.jld2")
else
	@warn "ProtoBuffer data path is not known on this system!"
end

"""
	visual_representation(pdf::PdfSampleRaw[, pageid])

Extracts the raw representation from the PdfSampleRaw object `pdf`.
"""
visual_representation(pdf::PdfSampleRaw, pageid::Int) = pdf.pages[pageid].visual_representation.letter_representation
function visual_representation(pdf::PdfSampleRaw) 
	x = []
	for i in 1:length(pdf.pages)
		# we have to do it this way because some pages have empty representations
		y = visual_representation(pdf, i)
		if length(y) != 0
			push!(x, y)
		end
	end
	hcat(x...)
end

"""
	reshape_representation(vector, shape=(48,64))
	reshape_representation(matrix, shape=(48,64))

Given a vector/matrix of floats, transforms this into the correct shape and orientation as a 3D tensor of
pdf representations.
"""
reshape_representation(vec::Vector, shape=(48,64)) = rotl90(reshape(vec, shape...))
reshape_representation(mat::Matrix, shape=(48,64)) = 
	cat([reshape_representation(mat[:,i], shape) for i in 1:size(mat,2)]..., dims = 3)

"""
	get_labels([sha256::Vector, ]index_file::String, label_file::String)

Get labels from 2 files. Possibly filter them with a given vector of sha256 strings. 
Returns a tuple of (labels, sha256, filenames).
"""
function get_labels(index_file::String, label_file::String)
	# get the index
	f = open(index_file);
	index_entries = map(JSON.parse, readlines(f));
	close(f)
	sha256 = map(x -> x["sha256"], index_entries);
	filenames = map(x -> x["original_name"], index_entries);
	
	# get the labels
	labeldata = CSV.read(label_file, header=[:label, :file]);

	# connect labels via filenames
	function filename2label(filename)
		label = (filter(row -> row[:file] == filename, labeldata))[!,:label]
		return (length(label) > 0) ? label[1] : nothing
	end 

	map(filename2label, filenames), sha256, filenames
end
function get_labels(sha256::Vector, index_file::String, label_file::String)
	# get the connected labelels and shas from the two files
	labels, labeled_sha256, labeled_filenames = get_labels(index_file, label_file)

	# connect labels via sha256
	function sha2label(sha)
		label = labels[labeled_sha256 .== sha]
		return length(label) > 0 ? label[1] : nothing
	end
	function sha2filename(sha)
		filename = labeled_filenames[labeled_sha256 .== sha]
		return length(filename) > 0 ? filename[1] : nothing
	end
	
	map(sha2label, sha256), sha256, map(sha2filename, sha256)
end
