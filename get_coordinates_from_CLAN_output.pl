# December 20, 2017
# Get protein coordinates from CLAN output file

#! /usr/perl/bin -w
use strict;

my $filein="/home/mnguyen/Research/Lysozyme/GH23_all_11Dec2017/All/CLAN_full_BLASTP/GH23_Bac_Virus_Fungi_NFE_fullseqs_CLAN_24Jan2018";
my $fileout="/home/mnguyen/Research/Lysozyme/GH23_all_11Dec2017/All/CLAN_full_BLASTP/GH23_Bac_Virus_Fungi_NFE_fullseqs_CLAN_24Jan2018_CLAN_coordinates.txt";

open(In,"<$filein") || die "Cannot open file $filein";
open(Out,">$fileout") || die "Cannot open file $fileout";
my $flag=0;
while (<In>)
{
	$_=~s/\s*$//;
	if ($_=~/\<pos\>/){$flag++;}
	if ($_=~/\<\/pos\>/){$flag=0;}
	if ($flag>0)
	{
		my @cols=split(/\s+/,$_);
		my $seqid=$cols[0];
		my $x=$cols[1];
		my $y=$cols[2];
		my $z=$cols[3];
		print Out "$seqid\t$x\t$y\t$z\n";
	}
}
close(In);
close(Out);