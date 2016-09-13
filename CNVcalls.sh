#!/bin/bash
#SBATCH -J CNV_caller
#SBATCH -n 1
#SBATCH -t 12:00:00
#SBATCH --mem=16G

cd /users/cgraves/data-dweinrei/Graves/alignments/bam_sorted/

module load cnvnator
module load root/5.34.22

endpoints=*.bam
for f in $endpoints
do 

strain=$(echo $f | grep -oh "[C,H,P][0-9]*-[0-9]*")

cnvnator -root $strain'.root' -tree $f

cnvnator -root $strain'.root' -his 100 -d /users/cgraves/data-dweinrei/Graves/S288C/

cnvnator -root $strain'.root' -stat 100

cnvnator -root $strain'.root' -partition 100

cnvnator -root $strain'.root' -call 100 > $strain'_CNVcalls.tsv'

done

mv *.tsv ../CNV/
rm *.root
mv CNVcalls.sh ../CNV/