# PdfFraud.jl
Pdf fraud detection with Julia and neural networks.

## Reading pdf data from ProtoBuffer file.

```julia
using PdfFraud

fs = "/path/to/protos/file.pb"
data = PdfFraud.read_pb(fs)
visual_rep = PdfFraud.reshape_representation(PdfFraud.visual_representation(data))
```

The last line produces an 3D tensor of size given by the representation resolution.