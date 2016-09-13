#!/bin/bash

FILES=*_mergedrenamed.vcf
mkdir /Users/chrisgraves/Documents/Yeast_data/Sequencing/alignments/composite_scores

cdate='2016_7_29' #Need to change to current date


for f in $FILES
do

strain=$(echo $f | grep -oh '[C,H][0-9]*')

perl allele_counts.pl $f

echo 6
echo 9

mv 'allele_counts'$cdate'.txt' $strain'_allele_counts.txt'  

perl composite_scores.pl $strain'_allele_counts.txt' 

chmod g+w 'freqs_'$cdate'.txt'
chmod g+w 'scores_'$cdate'.txt'

mv 'freqs_'$cdate'.txt' $strain'_freqs.txt'
mv 'scores_'$cdate'.txt' $strain'_scores.txt'

done

mkdir /Users/chrisgraves/Documents/Yeast_data/Sequencing/alignments/lang_scores/

mv *.txt /Users/chrisgraves/Documents/Yeast_data/Sequencing/alignments/lang_scores/
mv *.pl /Users/chrisgraves/Documents/Yeast_data/Sequencing/alignments/lang_scores/
mv composite_score_loop.sh /Users/chrisgraves/Documents/Yeast_data/Sequencing/alignments/lang_scores/
