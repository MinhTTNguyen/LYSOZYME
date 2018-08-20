path="//fs1.fungalgenomics.ca/mnguyen/Research/Lysozyme/GH24_all_15Dec2017/Fungi/CLAN_fullseq_BLASTP"
filein_coordinates="GH24_fungi_coordinates_just_for_presentation.txt"
setwd(path)

table_coordinates <- read.table(file=filein_coordinates, header=TRUE,sep = "\t",comment.char = "")
#genemodel_table <- read.table (file=plot_value_file_name,header=TRUE, sep="\t")

protein_names <- table_coordinates$Name_first_ID;
x <- table_coordinates$X;
y <- table_coordinates$Y;
z <- table_coordinates$Z;
color <- table_coordinates$Color;
#pch <- table_coordinates$pch;

library(scatterplot3d)

scatterplot3d(x,y,z, angle=-35, pch = 17, cex.symbols= 2,color=color, cex.axis=1, scale.y=1)
