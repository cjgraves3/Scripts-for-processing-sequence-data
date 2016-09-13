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

strain=$(echo $f | grep -oh '[C,H][0-9]*-[0-9]*')

outfile=$strain'_coverage.tsv'

echo "Chrom	Pos	Depth" > $outfile

samtools depth -aa $f >> $outfile

done

mkdir /users/cgraves/data-dweinrei/Graves/alignments/coverage/
mv *.tsv /users/cgraves/data-dweinrei/Graves/alignments/coverage/