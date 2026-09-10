# Mini Project assembly metrics

Compare C remanei assemblies:

File 1 (2014):file size: 115M
-https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248909/caenorhabditis_remanei.PRJNA248909.WBPS19.genomic.fa.gz

File 2 (2015):file size: 121M
-https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA248911/caenorhabditis_remanei.PRJNA248911.WBPS19.genomic.fa.gz

File 3 (unknown release):file size: 141M
-https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA53967/caenorhabditis_remanei.PRJNA53967.WBPS19.genomic.fa.gz 

File 4 (2019):file size: 127M
-https://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS19/species/caenorhabditis_remanei/PRJNA577507/caenorhabditis_remanei.PRJNA577507.WBPS19.genomic.fa.gz

How to use the code
run the code with the first argument the unzipped fasta file you want. The output is the number of contigs(loops), the total_length, and average length. Output for each file is below:
- File 1:number of loops: 1591 total_lenght: 118549266 average length 74512.42363293526
- File 2:number of loops: 912 total_lenght: 124541912 average length 136559.11403508772
- File 3:number of loops: 3670 total_lenght: 145442736 average length 39630.17329700272
- File 4:number of loops: 187 total_lenght: 130480874 average length 697758.6844919786

File 4 is the newest file, the fewest configs. the average length is also larger so the genome is less fragmented and built with less gaps.






