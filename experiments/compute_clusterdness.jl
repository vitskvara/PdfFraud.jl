using Distances
using Clustering
using DelimitedFiles
using PdfFraud

# set up the paths
reprpath = "vae_runs/2"
reprpath = joinpath(PdfFraud.experiment_path, reprpath, "representations")

# collect the files and encodings
encfs = filter(x->x!="index.csv",readdir(reprpath));
encodings = map(x->readdlm(x, ','), joinpath.(reprpath, encfs));

# get labels
_, labels, _, _ = PdfFraud.load_pdf_data();
linds = map(x->x!=nothing, labels)
Y = Int.(labels[linds]);

# compute distances for one encoding and use it to compute silhouttes
enc = encodings[11];
X = Array(enc[linds,:]');
silhouettes_encs(data, labels) = silhouettes(labels, pairwise(Euclidean(), data, dims=2))
silhs = silhouettes_encs(X, Y);
