import pandas as pd
import numpy as np 
import os
import re 


key = pd.read_csv('barcode_key.csv')
file_list = os.listdir('/users/cgraves/data-dweinrei/Graves/alignments/bam_sorted')


for f in file_list:
    
    match1 = re.search('YHS[1,2]',f)
    if match1 is not None: 
        lib = match1.group(0)
        match2 = re.search('N5[0-9][0-9]N7[0-9][0-9]',f)
        
        if match2 is not None:
            N5 = re.search('N5[0-9][0-9]',f)
            N7 = re.search('N7[0-9][0-9]',f)
            N5 = N5.group(0)
            N7 = N7.group(0)
            row = key[(key['Lib']==lib)&(key['N5']==N5)&(key['N7']==N7)]
            if row.shape[0] != 0:
            	strain = row.iloc[0]['Strain']
            	time = str(row.iloc[0]['Time'])
            	match3 = re.search('.bai',f)
            
            	if match3 is not None :
                	os.rename(f,strain+'-'+time+'.bam.bai')
            	else:
                	os.rename(f,strain+'-'+time+'.bam')
