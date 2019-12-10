# this is a script to train a basic VAE on the protobuffer pdf data
using GenerativeModels
using PdfFraud
using JLD2
using PyPlot

# first gather data and their labels
data_path = joinpath(PdfFraud.proto_path, "protos")
protos = joinpath.(data_path, readdir(data_path))

N = 100
function load_representation(file::String)
	data = PdfFraud.read_pb(file)
	return PdfFraud.reshape_representation(PdfFraud.visual_representation(data))
end

x = load_representation(protos[1])

@time x = load_representation(protos[1])


load_representations(files::Vector,n) = cat([load_representation(fs) for fs in files[1:min(n,length(files))]]..., dims=3)


@time load_representations(protos, 100)

using FileIO

@save "test.jld2" x

X = load("test.jld2")
@time X = load("test.jld2")
