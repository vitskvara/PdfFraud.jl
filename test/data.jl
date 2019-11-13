@testset "data" begin
	fs = "/home/vit/vyzkum/bulleproof/pdf_experiment/data/uloz_to_2019_11_05/protos/ff953f62f5739a910f96465c34367e31f6f4fdc112b8a27f66a7d88dd519ec91.pb"

	pdf = PdfFraud.read_pb(fs);
	@test typeof(pdf) == PdfSampleRaw
 	vs = map(i -> PdfFraud.visual_representation(pdf,i), 1:length(pdf.pages))
	@test length(vs) == 8
	xs = map(x -> reshape(x, 64, 48), vs) 	
end

"
using PyPlot

figure()
for i in 1:8
	subplot(8,1,i)
	pcolormesh(xs[i])
end
"