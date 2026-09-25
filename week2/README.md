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


######Q.2.${my_sample} appears four times in the bwa mem command. 
#Write out that command exactly as bash would run it on the third trip through the loop, with every variable replaced by its value.

##Answer: Third loop: bwa mem -t 4 -R "@RG\tID:$A01_23\tSM:$A01_23" ../genomes/sacCer3.fa ~/Data/BYxRM/fastq/$A01_23.fq.gz > $A01_23.sam