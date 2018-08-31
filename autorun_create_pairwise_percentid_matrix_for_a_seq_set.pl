#! /usr/perl/bin -w
use strict;

my $folderin="/home/mnguyen/Research/Lysozyme/Fungi_28Aug2018_goodmodels_producedprots/fasta_ALN";
my $folderout="/home/mnguyen/Research/Lysozyme/Fungi_28Aug2018_goodmodels_producedprots/fasta_ALN_MATRICIES";
mkdir $folderout;

opendir(DIR,"$folderin") || die "Cannot open $folderin";
my @files=readdir(DIR);
foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		my $cmd="perl create_pairwise_percentid_matrix_for_a_seq_set.pl --in $folderin/$file --out $folderout/$file";
		system $cmd;
	}
}
closedir(DIR);