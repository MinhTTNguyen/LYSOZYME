#! /usr/perl/bin -w
use strict;

my $folderin="/home/mnguyen/Research/Lysozyme/No_good_model_branches_GH24";
my $folderout="/home/mnguyen/Research/Lysozyme/Fungi/No_good_model_branches_GH24_ALN";
mkdir $folderout;

opendir(DIR,"$folderin") || die "Cannot open $folderin";
my @files=readdir(DIR);
foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		my $cmd="perl run_pairwise_aln_GH24.pl --in $folderin/$file --out $folderout/$file --temp $file";
		system $cmd;
	}
}
closedir(DIR);