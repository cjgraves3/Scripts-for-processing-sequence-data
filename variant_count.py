import pandas as pd
import numpy as np
import re

#function to identify sequence repeats
def find_repeats(ref):
    r = re.compile(r"(.+?)\1+")
    for match in r.finditer(ref):
        yield (match.group(1), len(match.group(0))/len(match.group(1)))

#function to assign assess whether sequence is a repeat
def is_repetitive(ref):
    if len(ref) >=4:
        repeat_list = list(find_repeats(ref))
        max_rep=0
        for repeat in repeat_list:
            if repeat[1] > max_rep:
                max_rep = repeat[1]
        if (max_rep >=4):
            return(1)
        else:
            return(0)
    else:
        return(0)
#function to extract tabular data from vcf
def vcf2tsv(vcf):
    
    file = open(vcf)
    lines = file.readlines()
    file.close()
    out_file = open('temp.tsv','w')
    
    for line in lines:
        if line[0:2] != '##':
            out_file.write(line)
    
    out_file.close()
    
    
times = [1,3,5,7,9,12]
time_pts = ['t1','t3','t5','t7','t9','t12'] #colnames for time points in experiment

strains = ['H1','H2','H3','H4','H5','H6','H7','H8','H9','H10','C1','C2','C3','C4','C5','C6','C7','C8','C9','C10']

for strain in strains:
	vcf = strain+'_merged.vcf'


	vcf2tsv(vcf)
	tab = pd.read_csv('temp.tsv',sep='\t')
	tab.columns = ['CHROM','POS','ID','REF','ALT','QUAL','FILTER','INFO','FORMAT',]+time_pts


	#create dict containing chromosome IDs
	chrom_key = list(tab['CHROM'].unique())
	chrom_num = list(['I','II','III','IV','V','VI','VII','VIII','IX','X','XI','XII','XIII','XIV','XV','XVI','MITO'])
	chrom_dict = dict(zip(chrom_key,chrom_num))



out_df = pd.DataFrame(columns = ['Chromosome','Position','Time','Ref','Alt','Read_depth','Num_alleles','Ref_count','Alt_count','Ref_qual','Alt_qual','Is_repeat'])
ind=0

	for index, row in tab.iterrows(): #loop over each row of the dataframe
    	chrom = chrom_dict[row['CHROM']] #change from ref # to chromosome # using dict
    	pos = row['POS'] 
    	ref = row['REF']
    	repeat = is_repetitive(ref)
    	alt_list = row['ALT'].split(',') #split into alternate alleles
    	num_alleles = len(alt_list) #determine number of alternate alleles
    	merged_list = row['FORMAT'].split(':') #determine how string of merged data is formatted
    
    
  	  for time in times:
  
    	    for allele in range(num_alleles):
        	    data = row['t'+str(time)]
            
           	 if data != '.':   #allele is present at time point
            	    data_dict = dict(zip(merged_list,data.split(':')))
                	depth = data_dict['DP']
               		ref_count = int(data_dict['RO'])
                
                	alt_count = data_dict['AO'].split(',')[allele]  
                	if alt_count == '.':
                    	alt_count = 0
                	else:
                    	alt_count = int(alt_count)
                
                	ref_qual = float(data_dict['QR']) #sum of quality scores for reads with ref allele
    
                	alt_qual = data_dict['QA'].split(',')[allele] #sum of quality scores for reads with alt allele
                	if alt_qual == '.':
                    	alt_qual = 0
                	else:
                    	alt_qual = float(alt_qual)
            
            
                	out_df.loc[ind] =(chrom,pos,time,ref,alt_list[allele],depth,num_alleles,ref_count,alt_count,ref_qual,alt_qual,repeat)
                	ind=ind+1
            
        
    
    
            
        
	out_df.to_csv(strain+'allele_counts.csv',index=False)    
    
