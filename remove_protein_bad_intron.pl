# October 26th 2017
# Discard proteins having short/long intron, or intron not following "GT...AG" rule

#! /usr/perl/bin -w
use strict;

my $filein="/home/mnguyen/Research/Lysozyme/GH23_all_11Dec2017/NFE_Fungi/GH23_Fungi_CLAN_BLASTP_fulseq_have_genomic_seqs_table_info.txt";
my $fileout="/home/mnguyen/Research/Lysozyme/GH23_all_11Dec2017/NFE_Fungi/GH23_Fungi_CLAN_BLASTP_fulseq_have_genomic_seqs_table_info_intron_notGT_AG.txt";
#my $minimum_intron_length=40;
#my $maximum_intron_length=150;

open(In,"<$filein") || die "Cannot open file $filein";
open(Out,">$fileout") || die "Cannot open file $fileout";
while (<In>)
{
	$_=~s/\s*$//;
	if ($_=~/^\#/){print Out "$_\tIntron_filter\t\n";}
	else
	{
		my @cols=split(/\t/,$_);
		my $gene_model_seq=pop(@cols);
		$gene_model_seq=~s/\[\w+\]/\[exon\]/g;
		$gene_model_seq=~s/^\[exon\]//;
		$gene_model_seq=~s/\[exon\]$//;
		my @introns=split(/\[exon\]/,$gene_model_seq);
		my $bad_model=0;
		foreach my $intron (@introns)
		{
			my $intron_length=length($intron);
			my $intron_dinu_start=substr($intron,0,2);
			my $intron_dinu_end=substr($intron,-2);
			#print "\n$intron_length\t$intron_dinu_start\t$intron_dinu_end\n";exit;
			#if (($intron_dinu_start ne "gt") || ($intron_dinu_end ne "ag") || ($intron_length<$minimum_intron_length) || ($intron_length>$maximum_intron_length))
			if (($intron_dinu_start ne "gt") || ($intron_dinu_end ne "ag"))
			{
					$bad_model++;
			}
		}
		if($bad_model){print Out "$_\tbad intron\n";}
		else{print Out "$_\n";}
	}
}
close(In);
close(Out);

