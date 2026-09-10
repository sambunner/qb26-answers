#!/usr/bin/env python3

import sys
import fasta

#the first argument as filename and use fasta.Reader
file = open (sys.argv[1])
genomes= fasta.FASTAReader(file)

loops = 0
total_length=0
for indent, sequence in genomes:
        #Count number of loops
    loops +=1
    #count the length of sequence
    total_length += int(len(sequence))
    
#calculate average length
average_length = total_length/loops

#print result as a single line
print('number of loops:', loops, 'total_lenght:', total_length, 'average length', average_length )
