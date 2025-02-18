#!/bin/bash
#SBATCH --job-name=HiFiAsm
#SBATCH --partition=fat
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=100
#SBATCH --mem=800G
#SBATCH --output=work0001.sh.%J.o
#SBATCH --error=work0001.sh.%J.e


hic1=../../Data/HiC_1.fq.gz
hic2=../../Data/HiC_2.fq.gz
hifi=../../Data/HiFi.fq.gz
ont=../../Data/ONT.fq.gz

hifiasm -o T2T.HiFiAsm -t100 --h1 $hic1 --h2 $hic2 --ul $ont $hifi

hifiasm -o T2T.HiFiAsm -t 100 --write-paf --write-ec /dev/null

