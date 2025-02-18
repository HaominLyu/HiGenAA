#!/bin/bash
#SBATCH --job-name=NextDenovo
#SBATCH --partition=cu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=500G
#SBATCH --output=workshop.NextDenovo.%J.o
#SBATCH --error=workshop.NextDenovo.%J.e


nextDenovo run.cfg

source activate assembler

nextPolish polish_l.cfg
nextPolish polish_s.cfg

