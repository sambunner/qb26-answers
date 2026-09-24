#Week2_exercise2

#Load hg16 files
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg16/bigZips/hg16.chrom.sizes

#Only include secondary contigs
grep -v _ hg16.chrom.sizes > hg16-main.chrom.sizes

#I loaded the knownCanonical TSV from UCSC Table Browser in file called hg16.tsv
#Convert to bed format
cut -f1-3,5 hg16-kc.tsv > hg16-kc.bed

#Make windows
bedtools makewindows -g hg16-main.chrom.sizes -w 1000000 > hg16-1mb.bed

#Calculate counts per 1mb for new file
bedtools intersect -c -a hg16-1mb.bed -b hg16-kc.bed > hg16-kc-count.bed

#How many genes are in hg19?
wc -l hg19-kc.bed
#   80309 hg19-kc.tsv
#Answer: there are (80309-1)= 80308 unique transcripts(genes).

#How many genes are in hg19 but not in hg16? using intersect with 1-letter option to find genes with no overlaps

bedtools intersect -a hg19-kc.bed -b hg16-kc.bed -v > unique_hg19-kc.bed
wc -l unique_hg19-kc.bed
#   42737 unique_hg19-kc.bed
#Answer: there are 42,737 genes in the hg19 that do not overlap at all with hg-16.

#Why are some genes in hg19 but not in hg16?
#Answer: The newer released version has more known transcripts 

#How many genes are in hg16?
wc -l hg16-kc.bed
#   21365 hg16-kc.bed
#Answer: there are 21,364 genes in hg16 (minus one for header)

#How many genes are in hg16 but not hg19?
bedtools intersect -a hg16-kc.bed -b hg19-kc.bed -v > unique_hg16-kc.bed
#    3458 unique_hg16-kc.bed
#Answer:There are 3,458 transcripts in hg16 that do not overlap at all with hg19

#Why are some genes in hg16 but not hg19?
#Answer: those genes were probably mis-mapped in hg16 and are now better aligned in the newer assembly

#end :)
