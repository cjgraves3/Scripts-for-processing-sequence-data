#!/bin/bash
#SBATCH -J adapter_clipper
#SBATCH -n 1
#SBATCH -t 96:00:00
#SBATCH --mem=16G

module load fastx-toolkit

ADAPTER='CTGTCTCTTATACACATCT'
SUFFIX='_read1_adapter_removed.fastq'
FILES=~/data-dweinrei/Graves/barcode_split/final/*.fastq

for f in $FILES
do
echo "Processing $f file"
BARCODES=$(echo $f | grep -oh "N5[0-9][0-9]N7[0-9][0-9]")
LIB=$(echo $f | grep -oh 'YHS[1-2]')
fastx_clipper -a $ADAPTER -i $f -o $LIB'_'$BARCODES$SUFFIX -Q33 -n -M 18
echo "Compressing $f"
gzip $f
done
