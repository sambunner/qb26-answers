#!/usr/bin/env python3

import sys
import fasta


file = open (sys.argv[1])
genomes= fasta.FASTAReader(file)

loops = 0
total_length=0
for indent, sequence in genomes:
        #Count number of loops
    loops +=1
    total_length += int(len(sequence))
    

average_length = total_length/loops


print('number of loops:', loops, 'total_lenght:', total_length, 'average length', average_length )
