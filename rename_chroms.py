import os
import re

#create dictionary to change chromosome names
chrom_key = list(('ref|NC_001133|','ref|NC_001134|','ref|NC_001135|','ref|NC_001136|','ref|NC_001137|','ref|NC_001138|','ref|NC_001139|','ref|NC_001140|','ref|NC_001141|','ref|NC_001142|','ref|NC_001143|','ref|NC_001144|','ref|NC_001145|','ref|NC_001146|','ref|NC_001147|','ref|NC_001148|','ref|NC_001224|'))
chrom_num = list(['I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','MITO'])
chrom_dict = dict(zip(chrom_key,chrom_num))

#define function to replace regex match
def rename_chrom(match):
	key = match.string[match.start(0):match.end(0)]
	return('chr'+chrom_dict[key])


files = os.listdir('/Users/chrisgraves/Documents/Yeast_data/Sequencing/alignments/vcf/merged')

for f in files:
	if f.endswith('.vcf'):
		file = open(f)
		strain = f.split('.')[0]
		lines = file.readlines()
		file.close()
		out_file = open(strain+'renamed.vcf','w')
		for line in lines:
			new_line = re.sub('ref\|NC_00[0-9]{4}\|',rename_chrom,line)
			out_file.write(new_line) 
		out_file.close()

