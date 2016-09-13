#!/bin/bash
#SBATCH -J aligner_vcf
#SBATCH -n 1
#SBATCH -t 6-00:00:00
#SBATCH --mem=16G


module load bwa
module load samtools
module load freebayes

S288C='/users/cgraves/data-dweinrei/Graves/S288C/S288C_reference_sequence_R64-2-1_20150113.fsa' #path to reference sequence
OUT_PATH='~/data-dweinrei/Graves/scratch/' #path to directory where output will be written
READ_PATH='/users/cgraves/data-dweinrei/Graves/adapter_trimmed/YHS1/' #Directory where reads to align are stored
FILES=$READ_PATH*.fastq
LIB_ID='YHS1'

for f in $FILES
do
BARCODE=$(echo $f | grep -oh "N5[0-9][0-9]N7[0-9][0-9]")

bwa index -p 'index' $S288C
echo $LIB_ID
echo 'Aligning '$f
bwa aln -n 0.04 -o 1 -e -1 -d 16 -i 0 -O 5 -E 4 $S288C $f > $LIB_ID'_'$BARCODE'.sai'
bwa samse -n 3 $S288C $LIB_ID'_'$BARCODE'.sai' $f > $LIB_ID'_'$BARCODE'.sam'
samtools view -bS $LIB_ID'_'$BARCODE'.sam' > $LIB_ID'_'$BARCODE'.bam'
samtools sort $LIB_ID'_'$BARCODE'.bam' -T $LIB_ID'_sorted_'$BARCODE -o $LIB_ID'_sorted_'$BARCODE'.bam'
samtools index $LIB_ID'_sorted_'$BARCODE'.bam'
freebayes -f $S288C --pooled-discrete $LIB_ID'_sorted_'$BARCODE'.bam' > $LIB_ID'_'$BARCODE'.vcf'
rm $LIB_ID'_'$BARCODE'.sam'
done
