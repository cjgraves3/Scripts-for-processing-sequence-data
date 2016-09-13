#!/bin/bash
#SBATCH -J coverage_calculator
#SBATCH -n 1
#SBATCH -t 1:00:00
#SBATCH --mem=4G

DIR=/users/cgraves/data-dweinrei/Graves/alignments/bam_sorted/
FILES=*.bam


echo "Strain,Average_cov,Stdev_cov" >> coverage.csv

for f in $FILES
do

strain=$(echo $f | grep -oh '[C,H][0-9]*-[0-9]*')

stats=$(samtools depth H1-9.bam  |  awk '{sum+=$3; sumsq+=$3*$3} END { print sum/NR","sqrt(sumsq/NR - (sum/NR)**2)}')

echo $strain','$stats >> coverage.csv
done