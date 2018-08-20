#! /usr/perl/bin -w
use strict;

my $path="/home/mnguyen/Research/Lysozyme/GH73/CAZy/GB";
my $filein="summary.txt";
my $fileout="summary_files_removed_ids.txt";

open(In,"<$path/$filein") || die "Cannot open file $filein";
open(Out,">$path/$fileout") || die "Cannot open file $fileout";
my $flag=0;
while (<In>)
{
	$_=~s/\s*$//;
	if ($_=~/^Record\s+removed\./){$flag++;}
	if ($_=~/(.+)\s+GI\:\d+/)
	{
		if ($flag){print Out "$1\trecord removed\n";$flag=0;}
	}
}
close(In);
close(Out);