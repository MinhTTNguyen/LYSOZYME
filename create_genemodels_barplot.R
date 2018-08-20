setwd("//fs1.fungalgenomics.ca/mnguyen/Research/Lysozyme/GH23_all_11Dec2017/Fungi/12Jul2018/Branch_no_good_models_3_produced_Rinput_part2")

color_table_file_name="protids_branch_no_good_model_with_3_produced_all_protid_CDs_part2_color.txt"
plot_value_file_name="protids_branch_no_good_model_with_3_produced_all_protid_CDs_part2_coordinates.txt"
segment_value_file_name="protids_branch_no_good_model_with_3_produced_all_protid_CDs_part2_segment.txt"
text_value_file_name="protids_branch_no_good_model_with_3_produced_all_protid_CDs_part2_text.txt"
model_ids="protids_branch_no_good_model_with_3_produced_all_protid_CDs_part2_text_modelids.txt"
#jpeg("Plot4.jpeg", width = 4, height = 3, units = 'in', res = 300)
pdf("protids_branch_no_good_model_with_3_produced_all_protid_CDs_part2.pdf")

col_table <- read.table(file=color_table_file_name, header=TRUE, as.is=1)
genemodel_table <- read.table (file=plot_value_file_name,header=TRUE, sep="\t")
segment_table <- read.table (file=segment_value_file_name, header=TRUE, sep="\t")
text_table <- read.table (file=text_value_file_name, header=TRUE, sep="\t" )
modelid_table <- read.table (file=model_ids, header=TRUE, sep="\t" )

x_limit=2300
y_limit=25

all_cols <- col_table$Color

x <- genemodel_table$x
y <- genemodel_table$y


number_of_text <- length(text_table$x)
number_of_segment <- length(segment_table$Start_x)
number_of_proteins <- length(modelid_table$x)

plot(x, y, col=all_cols,pch="|", cex=0.3, axes=FALSE, xlab=NA, ylab=NA, ylim=range(0:y_limit), xlim=range(0:x_limit)) #frame.plot=TRUE
axis(1,labels=TRUE,cex=0.3)

for (i in 1:number_of_segment)
{
  segments(segment_table$Start_x[i],segment_table$Start_y[i], segment_table$End_x[i], segment_table$End_y[i],col="red")
}

position=3
for (j in 1:number_of_text)
{
  if (position>1){position=1}
  else{position=3}
  text(text_table$x[j],text_table$y[j],pos=position,text_table$x[j],cex=0.3)
}

for (k in 1:number_of_proteins)
{
  text(modelid_table$x[k],modelid_table$y[k],pos=4,modelid_table$id[k],cex=0.5,col="grey50")
}

dev.off()
