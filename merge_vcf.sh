#!/bin/bash
#SBATCH -J vcf_merge
#SBATCH -n 1
#SBATCH -t 4:00:00
#SBATCH --mem=8G


module load vcftools
module load perl

OUT_PATH='/users/cgraves/data-dweinrei/Graves/alignments/vcf/merged/' #path to directory where output will be written
FILE_PATH='/users/cgraves/data-dweinrei/Graves/alignments/vcf/' #Directory where reads to align are stored

for i in `seq 1 10`
do



vcf-merge $FILE_PATH'H'$i'-1' $FILE_PATH'H'$i'-3' $FILE_PATH'H'$i'-5' $FILE_PATH'H'$i'-7' $FILE_PATH'H'$i'-9' $FILE_PATH'H'$i'-12' > $OUT_PATH'H'$i'_merged.vcf'
vcf-merge $FILE_PATH'C'$i'-1' $FILE_PATH'C'$i'-3' $FILE_PATH'C'$i'-5' $FILE_PATH'C'$i'-7' $FILE_PATH'C'$i'-9' $FILE_PATH'C'$i'-12' > $OUT_PATH'C'$i'_merged.vcf'
done
 