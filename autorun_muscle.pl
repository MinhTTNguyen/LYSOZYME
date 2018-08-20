# October 5th 2017
# autorun muscle

#! /usr/perl/bin -w
use strict;

my $folderin="/home/mnguyen/Research/Aspergillus_exoproteomes/Ronald/Ronald_seqs_Erin_edited_14Mar2018";
my $folderout="/home/mnguyen/Research/Aspergillus_exoproteomes/Ronald/Ronald_seqs_Erin_edited_14Mar2018_MUSCLE";

mkdir $folderout;
opendir(DIR,"$folderin") || die "Cannot open folder $folderin";
my @files=readdir(DIR);
foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		my $fileout=substr($file,0,-6);
		$fileout=$fileout."_muscle.fasta";
		my $cmd="muscle -in $folderin/$file -out $folderout/$fileout";
		system $cmd;
	}
}
closedir(DIR);