#!/bin/bash
#SBATCH -J coverage_calculator
#SBATCH -n 1
#SBATCH -t 3:00:00
#SBATCH --mem=8G

DIR=/users/cgraves/data-dweinrei/Graves/alignments/bam_sorted/
FILES=*.bam
module load samtools

for f in $FILES
do

strain=$(echo $f | grep -oh '[C,H,P][0-9]*-[0-9]*')

outfile=$strain'_reads_per_chrom.tsv'

echo "Chrom	Length	Num_reads	Unmapped" >> $outfile

samtools idxstats $f >> $outfile

done


mv *_reads_per_chrom.tsv /users/cgraves/data-dweinrei/Graves/alignments/coverage/