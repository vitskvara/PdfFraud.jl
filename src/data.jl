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

