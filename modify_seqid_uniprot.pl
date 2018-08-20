#! /usr/perl/bin -w
use strict;

my $path="/home/mnguyen/Research/Lysozyme/Bacteria/GH25/CAZy/Bac_download";
my $filein="GH25_Bac_UniProt_IDs.fasta";
my $fileout="GH25_Bac_UniProt_shortIDs.fasta";

open(In,"<$path/$filein") || die "Cannot open file $filein";
open(Out,">$path/$fileout") || die "Cannot open file $fileout";
while (<In>)
{
	$_=~s/\s*$//;
	if ($_=~/^\>/)
	{
		my @cols=split(/\|/,$_);
		my $new_id=$cols[1];
		print Out ">$new_id\n";
	}else{print Out "$_\n";}
}
close(In);
close(Out);