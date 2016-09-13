import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from random import sample as random_sample

alleles = pd.read_csv('combined_alleles.csv')

#Filter out allele groups that have low coverage or are observed only once in time series
filtered_alleles = alleles.groupby(['Chromosome','Position','Alt','Treatment','Strain']).filter(lambda x: (x['Read_depth'].max() >= 20) & (x['Read_depth'].notnull().sum() > 2) & (x['Is_repeat'].iloc[0]==0))
print(filtered_alleles.shape)

allele_groups = filtered_alleles.groupby(['Chromosome','Position','Alt','Treatment','Strain'])

rand_key = random_sample(allele_groups.indices.keys(),1)
rand_group = allele_groups.get_group(rand_key[0])

N = np.array(rand_group['Num_alt'])+np.array(rand_group['Num_ref'])



x = list(rand_group['Time'])
y = list(rand_group['Freq_alt'])
err = 1.96*np.sqrt(np.divide((np.ones(6)-y)*y,N))
qual = list(rand_group['Qual_alt'])

ref = rand_group['Ref'].iloc[0]
alt = rand_group['Alt'].iloc[0]
treatment = rand_group['Treatment'].iloc[0]
strain = str(rand_group['Strain'].iloc[0])
chrom = rand_group['Chromosome'].iloc[0]
pos = str(int(rand_group['Position'].iloc[0]))

plt.ylabel('Frequency',fontsize=16,fontweight='bold')
plt.xlabel('Time',fontsize=16,fontweight='bold')
plt.ylim([-0.1,1.2])
plt.yticks([0.0,0.2,0.4,0.6,0.8,1.0],size=14,fontweight='bold')
plt.xlim([0,14])
plt.xticks([0,2,4,6,8,10,12,14],size=14,fontweight='bold')
plt.scatter(x,y,s=200,c=qual,cmap='YlOrRd')
plt.clim(0,40)
plt.style.use('bmh')
cb = plt.colorbar()
cb.set_label(label='Quality score',fontsize=16,weight='bold')
cb.set_ticks([0,5,10,15,20,25,30,35,40])
cb.ax.tick_params(labelsize=14)
(_, caps, _) = plt.errorbar(x,y,yerr=err,ls='None',color='k',capsize=5)

for cap in caps:
    cap.set_markeredgewidth(2)

for i in range(len(x)):
    if not np.isnan(N[i]):
        plt.text(x[i],1.1,int(N[i]),ha='center',fontsize = 13, fontweight='bold',bbox=dict(facecolor='none', edgecolor='black', boxstyle='round'))

plt.title('Strain: %s%s \n Chromosome %s, Position %s \n %s to %s' %(treatment,strain,chrom,pos,ref,alt), fontsize=18,fontweight='bold')

plt.show()