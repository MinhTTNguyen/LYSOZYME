#October 11th 2017
#Read a fasta file, get list of ids of duplicated sequences

#! /usr/perl/bin -w
use strict;

my $filein_fasta="/home/mnguyen/Research/Lysozyme/GH25_all_15Dec2017/Fungi/CLAN_fulseq_BLASTP/GH25_fungi_fullseqs_nr.fasta";
my $fileout="/home/mnguyen/Research/Lysozyme/GH25_all_15Dec2017/Fungi/CLAN_fulseq_BLASTP/GH25_fungi_fullseqs_id_duplicates.txt";

open(In,"<$filein_fasta") || die "Cannot open file $filein_fasta";
open(Out,">$fileout") || die "Cannot open file $fileout";
print Out "ID\tIDs_of_duplicated_seqs\n";
while (<In>)
{
	$_=~s/\s*$//;
	if (($_=~/^\>/) and ($_=~/\;/))
	{
		$_=~s/^\>//;
		my @ids=split(/\;/,$_);
		foreach my $id (@ids)
		{
			print Out "$id\t$_\n";
		}
	}
}
close(In);
close(Out);