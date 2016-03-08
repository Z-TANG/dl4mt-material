#!/bin/bash
#PBS -l nodes=1:ppn=24
#PBS -l walltime=24:00:00
#PBS -N session2_default
#PBS -A course
#PBS -q ShortQ

export THEANO_FLAGS=device=cpu,floatX=float32

#cd $PBS_O_WORKDIR
python ./translate.py -n -p 8 \
	./model_hal.npz  \
	../../data/train.en.tok.pkl \
	../../data/train.de.tok.pkl \
	../../data/val.en.tok \
	./val.de.tok



