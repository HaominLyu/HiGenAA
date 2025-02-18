#!/bin/bash
#SBATCH --job-name=Peregrine
#SBATCH --partition=cu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=450G
#SBATCH --output=work.Peregrine.%J.o
#SBATCH --error=work.Peregrine.%J.e


source activate assembler

pg_asm reads.lst asm_out 64 4
