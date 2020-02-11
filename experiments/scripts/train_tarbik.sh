#!/bin/sh
LDIM=$1
NEPOCHS=100
SVPTH=vae_runs/${LDIM}_3
SF=10
JULIA_DEPOT_PATH=/home/skvara/.julia /home/skvara/julia-1.3.1/bin/julia ../run_experiment.jl $LDIM 32 32 64 --savepath=$SVPTH --nepochs=$NEPOCHS --batchsize=128 --eta=0.0005 --save-frequency=$SF
