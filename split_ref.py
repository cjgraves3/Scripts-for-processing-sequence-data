file = open('S288C_reference_sequence_R64-2-1_20150113.fsa')

for line in file:
    if (line[0] == '>'):
        header = line.split(' ')[0]
        chrom = header.split('>')[1]
        outfile = open(chrom+'.fa','w')
        outfile.write(line)
    else:
        outfile.write(line)

		