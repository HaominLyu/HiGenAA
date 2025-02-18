#!/bin/bash
#SBATCH --job-name=YAHS
#SBATCH --partition=cu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=100
#SBATCH --mem=500G
#SBATCH --output=work.YAHS.%J.o
#SBATCH --error=work.YAHS.%J.e


hic1=../../Data/HiC_1.fq.gz
hic2=../../Data/HiC_2.fq.gz

source activate assembler

cp ../4.PurgeDup/purged.fa ./
#cp ../T2T.HiFiAsm.hic.fa ./
fasta=purged.fa
samtools faidx $fasta
bwa index $fasta
fai=$fasta.fai


#chromap -i -r $fasta -o $fasta.index
#chromap --preset hic -r $fasta -x $fasta.index --remove-pcr-duplicates -1 $hic1 -2 $hic2 --SAM -o aligned.sam -t 64
#sed 's/\/[12]\t/\t/' aligned.sam > alignedchanged.sam
#samtools view -bh alignedchanged.sam | samtools sort -@ 30 -n > aligned.bam
#rm aligned.sam alignedchanged.sam


bwa mem -SP5M -t 100 $fasta $hic1 $hic2 -o aligned.sam
samtools view -bh aligned.sam | samtools sort -@ 50 -o aligned.bam -T tmp.ali
rm aligned.sam


yahs $fasta aligned.bam
juicer pre -a -o out_JBAT yahs.out.bin yahs.out_scaffolds_final.agp $fai
asm_size=$(awk '{s+=$2} END{print s}' $fai)
java -Xms204800M -Xmx204800M -jar /home/lvhm/Software/juicer-1.6/scripts/juicer_tools_1.22.01.jar pre out_JBAT.txt out_JBAT.hic <(echo "assembly ${asm_size}")


#juicer post -o out_JBAT out_JBAT.review.assembly out_JBAT.liftover.agp $fasta
