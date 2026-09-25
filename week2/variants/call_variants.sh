#!/bin/bash

#Call and filter variants
   
# run FreeBayes to discover variants
freebayes -f ../genomes/sacCer3.fa -L "bamListFile.txt" --genotype-qualities -p 1 > unfiltered.vcf

# the resulting VCF file is unfiltered, meaning that it contains low-confidence calls and also has
# some quirky formatting, so the following steps use a software suite called vcflib to clean it up

# filter the variants based on their quality score and remove sites where any sample had missing data
vcffilter -f "QUAL > 20" -f "AN > 9" unfiltered.vcf > filtered.vcf

echo "filtered variants"

# FreeBayes has a quirk where it sometimes records haplotypes rather than individual variants;
# we want to override this behavior
vcfallelicprimitives -kg filtered.vcf > decomposed.vcf

echo "recorded individual variants"

# in very rare cases, a single site may have more than two alleles detected in your sample; while
# these cases may be interesting, they may also reflect technical errors and pose a challenge for
# parsing the data, so we remove them
vcfbreakmulti decomposed.vcf > biallelic.vcf

echo "removed multi-allele sites"



