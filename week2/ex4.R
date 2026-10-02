#Load libraries
library(ggplot2)
#Load data
gt_long <- read.delim("/Users/cmdb/qb26-answers/week2/variants/gt_long.txt", header=FALSE, sep= "\t")
AF <- read.delim("/Users/cmdb/qb26-answers/week2/variants/AF.txt", header=FALSE, sep ="\t")

#Label header
colnames(AF) <- c("Chromosome", "Position", "Frequency")

#I made a plot 
ggplot(AF) +
  geom_histogram(aes(x = Frequency), bins = 11) +
  xlab("Allele Frequency") +
  ylab("Count")+
  theme_classic()

#Save as png
setwd("/Users/cmdb/qb26-answers/week2")
ggsave("AF.png")

#For chrII of sample A01_62, create a figure where the x axis is position and color indicates whether the genotype was a 0 or a 1. Make sure to convert the genotype to a factor variable.

colnames(gt_long) <- c("chromosome", "position", "sample", "genotype")

A01_62_ii <- gt_long %>%
  filter(chromosome == "chrII", sample == "A01_62")

ggplot(A01_62_ii, aes(x = position, y = genotype, color = genotype)) +
  geom_point() +
  xlab("Position") +
  ylab("Genotype")

#Facet wrap to all chromosomes
A01_62 <- gt_long %>%
  filter(sample == "A01_62")

ggplot(A01_62, aes(x = position, y = genotype, color = genotype)) +
  geom_point() +
  facet_grid("chromosome")
  xlab("Position") +
  ylab("Genotype")+
  theme_classic()
  
ggplot(gt_long, aes(x = position, y = genotype, color = genotype)) +
    geom_point() +
    facet_grid(chromosome ~ sample) +
    xlab("Position") +
    ylab("Genotype") +
    theme_classic()
  
  
ggsave("ancestry.png", width=30, height=15 )
       