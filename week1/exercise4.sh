#Week 1, Q4

#Use bedtools intersect and hg19-kc.bed to determine which gene has the most SNPs

bedtools intersect -a hg19-kc.bed -b snps-chr1.bed -c > snp_count.bed
sort -k5,5nr snp_count.bed | head -n 1 
#chr1	245912648	246670581	ENST00000490107.6_7	5445
#Describe the gene:
###Systematic name: ENST00000490107.6_7
###Human_readable name:SMYD3
###Position: hg19 chr1:245,912,865-246,518,383
###Size of coding region:605,519
###Exon count of coding region: 11

#Why do you think this gene has the most SNPs?
#Maybe because of its large size? 

#Determine which SNPs lie within vs outside of a gene
#i made one line bed file of coding region of gene then i re-used it to check the transcript including UTRs

bedtools intersect -a tiny.bed -b snps-chr1.bed | wc -l
# 4557
##Answer: 4,557 lie within gene coding region, 4,932 lie within the transcript (including UTRs). that means 375 genes are in not in coding region but within UTR, and 513 must be outside the gene.


###Create a subset of SNPs using bedtools sample -n 20 seed 42
bedtools sample -n 20 -seed 42 -i snps-chr1.bed > subset_snps.bed

###Use bedtools sort ot sort the subset of SNPs

bedtools sort -i subset_snps.bed > sorted_subset_snps.bed
###Use bedtools sort to sort hg19-kc.bed
bedtools sort -i hg19-kc.bed > sorted_hg19-kc.bed

#Use bedtools closest -d on the two sorted files, with -t first to break ties

bedtools closest -a sorted_hg19-kc.bed -b sorted_subset_snps.bed -d -t first > out.bed
#How many SNPs are inside of a gene?
awk '$11 == 0' out.bed | wc -l
#  17
#  Answer: there are 17 genes in the sorted_hg19-kc.bed file that has at least 1 SNP within 0bp (inside) of the gene. 


#What is the range of distances for the ones outside a gene?
#Maximum 
sort -k11,11nr out.bed | head

#36227401
sort -k11,11r out.bed | head

#Minimum that is not zero, extract lines where column 11 is greater than zero and then sort by column 11 as a numeric number. 
awk '$11 > 0' out.bed | sort -k11,11n | head
#1664


#Answer: the output is either 1664 bp-1,592528 bp away from a gene. 
