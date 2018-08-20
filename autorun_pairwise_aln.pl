#! /usr/perl/bin -w
use strict;

my $folderin="/home/mnguyen/Research/Lysozyme/Fungi/Added_JGI_fungi_26Feb2018/Domain_seqs_with_batch1_to_9";
my $folderout="/home/mnguyen/Research/Lysozyme/Fungi/Added_JGI_fungi_26Feb2018/Domain_seqs_with_batch1_to_9_ALN";
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