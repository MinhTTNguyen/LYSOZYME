#! /usr/perl/bin -w
use strict;

my $filein="";
my $fileout="";

open(In,"<$filein") || die "Cannot open file $filein";
open(Out,">$fileout") || die "Cannot open file $fileout";
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