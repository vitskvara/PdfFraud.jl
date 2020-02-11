#!/bin/sh
LDIM=256
NEPOCHS=100
SVPTH=vae_runs/${LDIM}_3
SF=10
for i in {1..5} 
do
	JULIA_DEPOT_PATH=/home/skvara/.julia /home/skvara/julia-1.3.1/bin/julia ../run_experiment.jl $LDIM 32 32 64 --savepath=$SVPTH --nepochs=$NEPOCHS --batchsize=128 --eta=0.0005 --save-frequency=$SF
done

LDIM=512
NEPOCHS=100
SVPTH=vae_runs/${LDIM}_3
SF=10
for i in {1..5} 
do
	JULIA_DEPOT_PATH=/home/skvara/.julia /home/skvara/julia-1.3.1/bin/julia ../run_experiment.jl $LDIM 32 32 64 --savepath=$SVPTH --nepochs=$NEPOCHS --batchsize=128 --eta=0.0005 --save-frequency=$SF
done

# no scaling
LDIM=16
NEPOCHS=100
SVPTH=vae_runs/${LDIM}_3_noscaling
SF=10
for i in {1..5} 
do
	JULIA_DEPOT_PATH=/home/skvara/.julia /home/skvara/julia-1.3.1/bin/julia ../run_experiment.jl $LDIM 32 32 64 --savepath=$SVPTH --nepochs=$NEPOCHS --batchsize=128 --eta=0.0005 --save-frequency=$SF --scaling=1
done

LDIM=256
NEPOCHS=100
SVPTH=vae_runs/${LDIM}_3_noscaling
SF=10
for i in {1..5} 
do
	JULIA_DEPOT_PATH=/home/skvara/.julia /home/skvara/julia-1.3.1/bin/julia ../run_experiment.jl $LDIM 32 32 64 --savepath=$SVPTH --nepochs=$NEPOCHS --batchsize=128 --eta=0.0005 --save-frequency=$SF --scaling=1
done

LDIM=512
NEPOCHS=100
SVPTH=vae_runs/${LDIM}_3_noscaling
SF=10
for i in {1..5} 
do
	JULIA_DEPOT_PATH=/home/skvara/.julia /home/skvara/julia-1.3.1/bin/julia ../run_experiment.jl $LDIM 32 32 64 --savepath=$SVPTH --nepochs=$NEPOCHS --batchsize=128 --eta=0.0005 --save-frequency=$SF --scaling=1
done