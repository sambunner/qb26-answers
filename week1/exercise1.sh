#makewindows
bedtools makewindows -g hg19-main.chrom.sizes -w 1000000 > hg19-1mb.bed

#intersect

#count the number of lines
bedtools intersect -c -a hg19-1mb.bed -b hg19-kc.bed | wc -l

#save bed file

bedtools intersect -c -a hg19-1mb.bed -b hg19-kc.bed > hg19-kc-count.bed
