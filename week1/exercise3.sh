#Week 1, Exercise 3



#Make bed files
grep 1_Active nhek.bed > nhek-active.bed
grep 1_Active nhlf.bed > nhlf-active.bed
grep 12_Repressed nhek.bed > nhek-repressed.bed
grep 12_Repressed  nhlf.bed > nhlf-repressed.bed

#Confirm your files have correct lines
#yes these are correct:

	wc -l nhek-active.bed
	wc -l nhlf-active.bed
	wc -l nhek-repressed.bed
	wc -l nhlf-repressed.bed

#Test overlap between 1_Active and 12_Repressed

#There is no overlap between the active and inactive regions
#0
bedtools intersect -a nhek-active.bed  -b nhek-repressed.bed | wc -l
bedtools intersect -a nhlf-active.bed -b nhlf-repressed.bed | wc -l 

#Find regions that are active in NHEK and NHLF 

bedtools intersect -a nhek-active.bed -b nhlf-active.bed | wc -l
#  12174
#  Answer: there are 12,174 overlapped active regions between NHEK and NHLF. 
#

#Find regions that are active in NHEK but not active in NHLF

bedtools intersect -a nhek-active.bed -b nhlf-active.bed -v | wc -l
#2405
#Answer: There are 2,405 active regions in NHEK that do not overlap with NHLF

#How many features are output by the first command? by the second command?
#12,174- command 1
# 2,405 - command 2

#Do these two numbers add up to the original number of lines in nhek-active.bed?
#no they do not

#If not, how can you adjust your first command to only report one feature per overlap?
bedtools intersect -a nhek-active.bed -b nhlf-active.bed -u | wc -l
#11608

#Constuct three bedtools intersect commands to see the effect of using the arguments when comparing -a nkek-active.bed 0b nhlf-active.bed 

bedtools intersect -a nhek-active.bed -b nhlf-active.bed -f 1 > 1_overlap_A.bed
bedtools intersect -a nhek-active.bed -b nhlf-active.bed -F 1 > 1_overlap_B.bed
bedtools intersect -a nhek-active.bed -b nhlf-active.bed -f 1 -F 1 > overlapA-andB.bed


#(qb26) cmdb@QUANTBIO-26 week1 % wc -l 1_overlap_A.bed
   # 4821 1_overlap_A.bed
#(qb26) cmdb@QUANTBIO-26 week1 % wc -l 1_overlap_B.bed
   # 6731 1_overlap_B.bed
#(qb26) cmdb@QUANTBIO-26 week1 % wc -l overlapA-andB.bed
   # 1409 overlapA-andB.bed

#How does the relationship between NHEK and NHLF chromatin state change as you alter the overlap parameter?

#using -f 1 flag extracts all regions of a (NHEK) that are 100% overlapped by regions in B (NHLF). This happens 4,821 times. 
#using -F 1 flag extracts all regions of a (NHEK) that fully overlaps the entire region in b (NHLF), this happens 6,731 times
# using both -f 1 -F 1 extracts all regions of a (NHEK) that is identical coordinates in b (NHLF). This happens 1,409 times.


#Construct commands to identify following regions and describe the chromatin state

#Active in NHEK, Active in NHLF
bedtools intersect -a nhek-active.bed -b nhlf-active.bed -f 1 -F 1 > overlapA-andB.bed

#answer: This overlaps with genes expressed in both cell lines, with the example image being a ubiquitously expressed gene C1orf159. 

#Active in NHEK, Repressed in NHLF
bedtools intersect -a nhek-active.bed -b nhlf-repressed.bed > active_a_repressed_b.bed
#This is a less stringent overlap between active regions of a overlaped with repressed regions of b. this would be genes specifically expressed in NHEK and repressed in NHLF.I checked chr1	27285413	27286213, which is KDF1, a keratinocyte differentition factor, which makes a lot of sense for this cell type.

#Repressed in NHEK, Repressed in NHLF
bedtools intersect -a nhek-repressed.bed -b nhlf-repressed.bed -f 1 -F 1 > repressed_a_repressed_b.bed
#This is genes silenced in both cell types like NT5C1a, which is primarily expressed in muscle tissue,and not expressed in either cell line. 

#end :)
