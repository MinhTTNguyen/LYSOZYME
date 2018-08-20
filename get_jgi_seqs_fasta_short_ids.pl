# October 10th 2017
# re-create fasta file for jgi sequences using short ids

#~ /usr/perl/bin -w
use strict;

my $filein="/home/mnguyen/Research/Lysozyme/Fungi/Added_JGI_fungi_26Feb2018/hmmscan/GH25_Fungi_new_genomes_26Feb2018_CAZy_module.fasta";
my $fileout="/home/mnguyen/Research/Lysozyme/Fungi/Added_JGI_fungi_26Feb2018/hmmscan/GH25_Fungi_new_genomes_26Feb2018_CAZy_module_shortID.fasta";

open(In,"<$filein") || die "Cannot open file $filein";
open(Out,">$fileout") || die "Cannot open file $fileout";
while (<In>)
{
	$_=~s/\s*$//;
	if ($_=~/^\>/)
	{
		$_=~s/^\>//;
		my @temps=split(/\|/,$_);
		my $new_id=$temps[0]."|".$temps[1]."|".$temps[2];
		print Out ">$new_id\n";
	}else{print Out "$_\n";}
}
close(In);
close(Out);