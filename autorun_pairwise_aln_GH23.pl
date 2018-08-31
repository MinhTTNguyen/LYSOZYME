#! /usr/perl/bin -w
use strict;

my $folderin="/home/mnguyen/Research/Lysozyme/Fungi_21Aug2018_nogoodmodelbranch/No_good_model_branches_GH23";
my $folderout="/home/mnguyen/Research/Lysozyme/Fungi_21Aug2018_nogoodmodelbranch/No_good_model_branches_GH23_ALN";
mkdir $folderout;

opendir(DIR,"$folderin") || die "Cannot open $folderin";
my @files=readdir(DIR);
foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		my $cmd="perl run_pairwise_aln_GH23.pl --in $folderin/$file --out $folderout/$file --temp $file";
		system $cmd;
	}
}
closedir(DIR);