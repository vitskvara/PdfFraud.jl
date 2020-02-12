#!/bin/sh
if [ "$HOSTNAME" == "tarbik.utia.cas.cz" ]
then
	MODELPATH="/home/skvara/work/bulletproof/pdf_experiment/experiments/vae_runs"
else
	MODELPATH="/home/vit/vyzkum/bulletproof/pdf_experiment/experiments/vae_runs"
fi
for p in $MODELPATH/*
do
	JULIA_DEPOT_PATH=/home/skvara/.julia /home/skvara/julia-1.3.1/bin/julia ../create_encoding.jl $p/models
done