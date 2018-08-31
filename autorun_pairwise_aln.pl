#! /usr/perl/bin -w
use strict;

my $folderin="/home/mnguyen/Research/Lysozyme/Fungi_28Aug2018_goodmodels_producedprots/fasta";
my $folderout="/home/mnguyen/Research/Lysozyme/Fungi_28Aug2018_goodmodels_producedprots/fasta_ALN";
mkdir $folderout;

opendir(DIR,"$folderin") || die "Cannot open $folderin";
my @files=readdir(DIR);
foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		my $cmd="perl run_pairwise_aln.pl --in $folderin/$file --out $folderout/$file --temp $file";
		system $cmd;
	}
}
closedir(DIR);