# Experiments

A single experiment to train a model can be run via `julia run_experiment.jl 128 32 32 --savepath=experimental/path`, where the first integer argument is the latent dimension size and the other two are the number of channels also indicating how many convolutional layers are to be used. Run `julia run_experiment.jl --help` to obtain info on all command line arguments.
