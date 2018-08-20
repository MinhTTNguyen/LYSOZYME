#! /usr/perl/bin -w
use strict;

my $path="/home/mnguyen/Research/Lysozyme/Non_microorganisms/CAZy/Download_CAZy_eukaryota/GH22";
my $filein="GH22_GB_non_microorganisms.fasta";
my $fileout="GH22_GB_non_microorganisms_short.fasta";

open(In,"<$path/$filein") || die "Cannot open file $filein";
open(Out,">$path/$fileout") || die "Cannot open file $fileout";
while (<In>)
{
	$_=~s/\s*$//;
	if ($_=~/^\>/)
	{
		$_=~s/\s+.+$//;
		print Out "$_\n";
	}else{print Out "$_\n";}
}
close(In);
close(Out);