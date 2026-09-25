#######QUESTION1
#Align short sequencing reads using bowtie2
cd genomes
cp ~/Data/References/sacCer3/sacCer3.fa.gz .
gunzip sacCer3.fa.gz
bwa index sacCer3.fa
#######THIS IS DONE

#Map one sample
cd ../variants
bwa mem -t 4 -R "@RG\tID:A01_09\tSM:A01_09" ../genomes/sacCer3.fa ~/Data/BYxRM/fastq/A01_09.fq.gz > A01_09.sam
#Sort, convert, and index
samtools sort -@ 4 -O bam -o A01_09.bam A01_09.sam
samtools index A01_09.bam

######Q1.1
####Why is the SAM file so much larger than the FASTQ file it came from? Why is the BAM file so much smaller than the SAM file?
#The Sam file is larger than the fastq becasuse it is not only the fastq information but also the mapping quality score and coordinates. 
#The .bam file is much smaller than the .sam file because it is in a non-human readable (binary) format


######Q1.2.${my_sample} appears four times in the bwa mem command. 
#Write out that command exactly as bash would run it on the third trip through the loop, with every variable replaced by its value.

##Answer: Third loop: bwa mem -t 4 -R "@RG\tID:$A01_23\tSM:$A01_23" ../genomes/sacCer3.fa ~/Data/BYxRM/fastq/$A01_23.fq.gz > $A01_23.sam

##########QUESTION2
samtools view -H A01_09.bam
samtools view A01_09.bam | head -n 3
#####Q2.1: What do the @SQ lines tell you, and how many are there?

#Answer: @SQ is the reference sequence contigs of the reference genome, one for each chromosome. There are 17 lines that start with @SQ.

#####Q2.2: Pick one alignment from the output above. What chromosome and position did it align to, and what is its CIGAR string? What does that CIGAR string mean?

#Answer: I picked the second line of A01_09.bam file: HWI-ST387_0114:5:23:10710:84112#0	0	chrI	47	60	76M	*0	0	CACCCACACACACACATCCTAACACTACCCTAACACAGCCCTAATCTAACCCTGGCCAACCTGTCTCTCAACTTAC	BE8E=EGGFGFEEFEFGGGFCFFFFD?BDDDDFEBD:A?A:ED=BDA?ADD28..8:>6>;6>??BFDED.DAEBE	NM:i:0	MD:Z:76	AS:i:76	XS:i:0	RG:Z:A01_09

#This read aligned to chrI, start:46, end:122. the CIGAR STRING is 76M means that all 76bp of the string maps with no insertion or deletion.


####Q2.3: Your read group appears twice: once in the @RG header line, and once as an RG:Z: tag among the optional tags at the end of each alignment. Find both. Where did those values come from, and why does every single read need to carry one?

#Answer: these values are important to keep track of where the sequence came from and its metadata. Every read needs to carry one because otherwise you wouldn't be able to identify where that read came or its metadata.

####Q2.4: What fraction of reads mapped to the reference genome? Is that a reasonable number for a yeast sample aligned to the yeast reference?
samtools flagstat A01_09.bam > A01_09.flagstat
cat A01_09.flagstat

<!-- 669548 + 0 in total (QC-passed reads + QC-failed reads)
669548 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
669520 + 0 mapped (100.00% : N/A)
669520 + 0 primary mapped (100.00% : N/A)
0 + 0 paired in sequencing
0 + 0 read1
0 + 0 read2
0 + 0 properly paired (N/A : N/A)
0 + 0 with itself and mate mapped
0 + 0 singletons (N/A : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5) -->

#Answer: 100% of reads passed, which may be expected if the genome is not very big (12.1 Mb) and maybe it had great coverage?


####Q2.5: Several lines of the output are exactly 0, including “properly paired” and “with mate mapped to a different chr”. Why? What does that tell you about how this library was sequenced?
#Answer: this is what they mean:
##0 secondary: this means that there was no second-best place that reads mapped to. This means that there is high confidence that the reads map to only one spot.
##0 supplementary: this means that there were no reads that failed to continuously map to the genome. the library that was sequenced aligns well to the reference genome. 
##0 duplicates means there are no reads that are flagged as exactly identical. If you asked samtools to look for duplicates, and there are flagged duplicate reads it could raise concern that there was an issue in the library preparation or sequencing (ex. PCR over-amplification)
##0 primary duplicates is just a subset of the duplicates that were classified as primary reads 
##0 + 0 paired in sequencing, 0 + 0 read1, 0 + 0 read2, all correspond to paired end reads which we did not run, which is why these fields are empty. the rest also related to finding either one, or another with paired end reads not aligning to the same spot. 


####Q2.6:Looking at your 10 samples in this region, which ones appear to carry BY ancestry and which appear to carry RM ancestry? Find the markers at chrI:27915, chrI:28323, chrI:28652, and chrI:29667 in ~/Data/BYxRM/BYxRM_GenoData.txt and check whether your visual call agrees with the published genotypes.

#All samples at each locus either matched all or all failed to match the reference:

#Samples that match BY (ref): A01_62, A01_39, A01_31, A01_63, A01_24, A01_09
#Samples that do not match BY (ref): A01_35, A01_23, A01_11, A01_27

#Does this match the published data?
#use grep to extract the regions we looked at:

#A01_62
grep -F -e 'chr01_27915' -e 'chr01_28323' -e 'chr01_28652' -e 'chr01_29667' | cut -f 63
#B for all

#I repeated this for the rest of the strains that by IGV matched ref, and for each locus each was B, and then for the ones that did not match ref, they all had Rs which means that the visual call agrees with the published genotypes, since the B stands for BY and the R stands for the other strain RM. 



##########QUESTION3



####




