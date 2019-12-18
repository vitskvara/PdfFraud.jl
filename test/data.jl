@testset "data" begin
	fs = joinpath(PdfFraud.proto_path, "protos/ff953f62f5739a910f96465c34367e31f6f4fdc112b8a27f66a7d88dd519ec91.pb")

	pdf = PdfFraud.read_pb(fs);
	@test typeof(pdf) == PdfSampleRaw
 	vs = map(i -> PdfFraud.visual_representation(pdf,i), 1:length(pdf.pages))
	@test length(vs) == 8
	xs = map(x -> reshape(x, 64, 48), vs) 	
end
