import pandas as pd
import numpy as np

#Load data from csv
strains = ['C1','C2','C3','C4','C5','C6','C7','C8','C9','C10','H1','H2','H3','H4','H5','H6','H7','H8','H9','H10']
time_points = [1,3,5,7,9,12]

for strain in strains:
	allele_counts = pd.read_csv(strain+'_allele_counts.csv')
	#group mutations on chromosome, position, and allele (identifies a unique mutation in the time-series)
	by_allele = allele_counts.groupby(['Chromosome','Position','Alt'])

	#group mutations on chromosome, position, and time (identifies a unique site in the sequencing library)
	by_site = allele_counts.groupby(['Chromosome','Position','Time'])

	out_df = pd.DataFrame(columns = ['Chromosome','Position','Alt','Time','Ref','Is_repeat','Read_depth','Num_ref','Num_alt','Freq_ref','Freq_alt','Qual_ref','Qual_alt'])
	ind=0
	
	for allele_name, allele_group in by_allele:
		chrom = allele_name[0]
		position = allele_name[1]
		alt = allele_name[2]
		ref = allele_group.iloc[0]['Ref']
		is_repeat = allele_group.iloc[0]['Is_repeat']
		times_in_group = allele_group['Time'].unique()
    
    
		for time in time_points:
			if time in times_in_group:
				site = by_site.get_group((chrom,position,time))
				total_call = site['Alt_count'].sum() + site['Ref_count'].iloc[0] #determine total number of haplotype calls for all alleles 
				allele_row = allele_group[allele_group['Time']==time]
				depth = allele_row.iloc[0]['Read_depth']
				ref_freq = allele_row.iloc[0]['Ref_count']/total_call
				alt_freq = allele_row.iloc[0]['Alt_count']/total_call
            
				ref_count = allele_row.iloc[0]['Ref_count']
				ref_num = ref_count
				if ref_count != 0:
					ref_qual = allele_row.iloc[0]['Ref_qual']/ref_count
				else:
					ref_qual = 0	
			
				alt_count = allele_row.iloc[0]['Alt_count']
				alt_num = alt_count
				if alt_count != 0:
					alt_qual = allele_row.iloc[0]['Alt_qual']/alt_count
				else:
					ref_qual=0
            
				out_df.loc[ind] = (chrom,position,alt,time,ref,is_repeat,depth,ref_num,alt_num,ref_freq,alt_freq,ref_qual,alt_qual)
				ind = ind+1
			else:
				out_df.loc[ind] = (chrom,position,alt,time,ref,is_repeat,np.nan,np.nan,0,np.nan,0,np.nan,np.nan)
				ind = ind+1
    	
	out_df.to_csv(strain+'_freq.csv',index=False)