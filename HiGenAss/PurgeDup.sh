#!/bin/bash
#SBATCH --job-name=PurgeDup
#SBATCH --partition=cu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=50
#SBATCH --mem=300G
#SBATCH --output=workshop.PurgeDup.%J.o
#SBATCH --error=workshop.PurgeDup.%J.e


source activate assembler

asm=../T2T.HiFiAsm.hic.fa
read=../../Data/HiFi.fq.gz

minimap2 -t 50 -ax map-hifi $asm $read | gzip -c - > pb_aln.paf.gz

pbcstat pb_aln.paf.gz

calcuts PB.stat > cutoffs 2> calcults.log

split_fa $asm > asm.split
minimap2 -t 64 -xasm5 -DP asm.split asm.split | pigz -c > asm.split.self.paf.gz

purge_dups -2 -T cutoffs -c PB.base.cov asm.split.self.paf.gz > dups.bed 2> purge_dups.log
get_seqs dups.bed $asm
