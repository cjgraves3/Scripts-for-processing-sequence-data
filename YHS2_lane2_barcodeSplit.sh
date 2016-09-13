#!/bin/bash
#SBATCH -J barcode_splitter
#SBATCH -n 1
#SBATCH -t 3-00:00:00
#SBATCH --mem=100G

#splits read1 (the sample read) on read3 (the N7 index read) then on read2 (the N5 index read) allowing 1 mismatch

DATA_PATH="/users/cgraves/data-dweinrei/Graves/raw/"
OUT_PATH="/users/cgraves/data-dweinrei/Graves/scratch/"
SCRIPT_PATH="/users/cgraves/scripts/barcode_splitter.py"
N5_BARCODE="/users/cgraves/scripts/N5barcodes.txt"
N7_BARCODE="/users/cgraves/scripts/N7barcodes.txt"


#Example file name YHS2_lane1_read2_N7index.fastq.gz
LIB='YHS2'
LANE='lane2'
EXT='.fastq.gz'
READ1=$LIB'_'$LANE'_read1'$EXT
READ2=$LIB'_'$LANE'_read2_N7index'$EXT
READ3=$LIB'_'$LANE'_read3_N5index'$EXT
OUT_SUFFIX='splitreads-read-1'$EXT
#split read1 (the sample read) by barcode N5
PREFIX1=$LIB'_'$LANE'_read1_'
$SCRIPT_PATH --bcfile $N5_BARCODE $DATA_PATH$READ1 $DATA_PATH$READ3 --idxread 2 --prefix $OUT_PATH$PREFIX1 --suffix $EXT --mismatches 1
echo 'Completed N5 split on read 1'
#split read2 (the N7 index read) by barcode N5
PREFIX2=$LIB'_'$LANE'_read2_'
$SCRIPT_PATH --bcfile $N5_BARCODE $DATA_PATH$READ2 $DATA_PATH$READ3 --idxread 2 --prefix $OUT_PATH$PREFIX2 --suffix $EXT --mismatches 1
echo 'Completed N5 split on read 2'


#split barcode N517 by N7
$SCRIPT_PATH --bcfile $N7_BARCODE $OUT_PATH$PREFIX1'N517'$OUT_SUFFIX $OUT_PATH$PREFIX2'N517'$OUT_SUFFIX --idxread 2 --prefix $OUT_PATH$LIB'_'$LANE'_N517' --suffix $EXT --mismatches 1
echo 'Completed N7 split on N517 barcodes'
#split barcode N502 by N7
$SCRIPT_PATH --bcfile $N7_BARCODE $OUT_PATH$PREFIX1'N502'$OUT_SUFFIX $OUT_PATH$PREFIX2'N502'$OUT_SUFFIX --idxread 2 --prefix $OUT_PATH$LIB'_'$LANE'_N502' --suffix $EXT --mismatches 1
echo 'Completed N7 split on N502 barcodes'
#split barcode N503 by N7
$SCRIPT_PATH --bcfile $N7_BARCODE $OUT_PATH$PREFIX1'N503'$OUT_SUFFIX $OUT_PATH$PREFIX2'N503'$OUT_SUFFIX --idxread 2 --prefix $OUT_PATH$LIB'_'$LANE'_N503' --suffix $EXT --mismatches 1
echo 'Completed N7 split on N503 barcodes'
#split barcode N504 by N7
$SCRIPT_PATH --bcfile $N7_BARCODE $OUT_PATH$PREFIX1'N504'$OUT_SUFFIX $OUT_PATH$PREFIX2'N504'$OUT_SUFFIX --idxread 2 --prefix $OUT_PATH$LIB'_'$LANE'_N504' --suffix $EXT --mismatches 1
echo 'Completed N7 split on N504 barcodes'
#split barcode N505 by N7
$SCRIPT_PATH --bcfile $N7_BARCODE $OUT_PATH$PREFIX1'N505'$OUT_SUFFIX $OUT_PATH$PREFIX2'N505'$OUT_SUFFIX --idxread 2 --prefix $OUT_PATH$LIB'_'$LANE'_N505' --suffix $EXT --mismatches 1
echo 'Completed N7 split on N505 barcodes'
#split barcode N506 by N7
$SCRIPT_PATH --bcfile $N7_BARCODE $OUT_PATH$PREFIX1'N506'$OUT_SUFFIX $OUT_PATH$PREFIX2'N506'$OUT_SUFFIX --idxread 2 --prefix $OUT_PATH$LIB'_'$LANE'_N506' --suffix $EXT --mismatches 1
echo 'Completed N7 split on N506 barcodes'
#split barcode N507 by N7
$SCRIPT_PATH --bcfile $N7_BARCODE $OUT_PATH$PREFIX1'N507'$OUT_SUFFIX $OUT_PATH$PREFIX2'N507'$OUT_SUFFIX --idxread 2 --prefix $OUT_PATH$LIB'_'$LANE'_N507' --suffix $EXT --mismatches 1
echo 'Completed N7 split on N507 barcodes'
#split barcode N508 by N7
$SCRIPT_PATH --bcfile $N7_BARCODE $OUT_PATH$PREFIX1'N508'$OUT_SUFFIX $OUT_PATH$PREFIX2'N508'$OUT_SUFFIX --idxread 2 --prefix $OUT_PATH$LIB'_'$LANE'_N508' --suffix $EXT --mismatches 1
echo 'Completed N7 split on N508 barcodes'
