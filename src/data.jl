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


function read_pb(fs::String)
	open(fs) do f
		readproto(f, PdfSampleRaw())
	end
end

fs = "/home/vit/vyzkum/bulleproof/pdf_experiment/data/uloz_to_2019_11_05/protos/ff953f62f5739a910f96465c34367e31f6f4fdc112b8a27f66a7d88dd519ec91.pb"

visual_representation(pdf::PdfSampleRaw, pageid::Int) = pdf.pages[pageid].visual_representation.letter_representation
