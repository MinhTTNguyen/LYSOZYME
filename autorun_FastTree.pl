# October 5th 2017
# autorun muscle

#! /usr/perl/bin -w
use strict;

my $folderin="filtered_fulseq_subs_intron150_nr_muscle";
my $folderout="filtered_fulseq_subs_intron150_nr_fastTree";

mkdir $folderout;
opendir(DIR,"$folderin") || die "Cannot open folder $folderin";
my @files=readdir(DIR);
foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		my $fileout=substr($file,0,-6);
		$fileout=$fileout."_FastTree.nwk";
		my $cmd="./FastTreeMP -pseudo $folderin/$file > $folderout/$fileout";
		system $cmd;
	}
}
closedir(DIR);