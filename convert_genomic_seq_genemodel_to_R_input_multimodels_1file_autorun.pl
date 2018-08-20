# 26 October 2017
# Convert genomic sequence of gene models into input file in R to create bar plot showing gene models

#! /usr/perl/bin -w
use strict;

my $folderin="/home/mnguyen/Research/Lysozyme/Fungi_GH23_24_25/filtered_intron150/Final_clusters/GH25_seqid_genemodel/sub1";
my $folderout="/home/mnguyen/Research/Lysozyme/Fungi_GH23_24_25/filtered_intron150/Final_clusters/GH25_seqid_genemodel/sub1_Rinput";
mkdir $folderout;
opendir(DIR,"$folderin") || die "Cannot open folder $folderin";
my @files=readdir(DIR);
closedir(DIR);
foreach my $filein (@files)
{
	if (($filein ne ".") and ($filein ne ".."))
	{
		my $cmd="perl convert_genomic_seq_genemodel_to_R_input_multimodels_1file.pl --folderin $folderin --filein $filein --folderout $folderout";
		system $cmd;
	}
}