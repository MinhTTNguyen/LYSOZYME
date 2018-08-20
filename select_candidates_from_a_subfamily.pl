# November 22nd 2017
# This script is to select candidates from a subfamily
# Step1: read pairwise percent of identity file and save 2 hashes: (1) all protein ids; (2) pairwise percent identity; keep a copy of protein id hash
# Step2:
# - use a for loop to go through all proteins in the subfamily
# - check if the protein was discarded or not. If not, select it and discard those above the cutoff
# fileout
# ProtID	Selection	Alternatives
# jgi|Trigu1|1084712	selected	jgi|Trigu1|1084712;jgi|Agabi_varbisH97_2|120070
# jgi|Trigu1|1084711	discarded

#! /usr/perl/bin -w
use strict;

my $filein_pairwise_aln="/home/mnguyen/Research/Lysozyme/GH22_all_27Nov2017/CLAN_fullseqs/BLASTP/Clustered_seqs_aln/G0_G0.fasta";
my $fileout="/home/mnguyen/Research/Lysozyme/GH22_all_27Nov2017/CLAN_fullseqs/BLASTP/Clustered_seqs_aln/G0_G0_selection_alternatives.txt";
my $cutoff=65;
my %hash_protids;
my %hash_alternatives;
open(In,"<$filein_pairwise_aln") || die "Cannot open file $filein_pairwise_aln";
while (<In>)
{
	$_=~s/\s*$//;
	my @cols=split(/\t/,$_);
	my $protid1=$cols[0];
	my $protid2=$cols[1];
	my $percent_identity=$cols[2];
	$hash_protids{$protid1}++;
	$hash_protids{$protid2}++;
	if ($percent_identity>=$cutoff)
	{
		if ($hash_alternatives{$protid1}){$hash_alternatives{$protid1}=$hash_alternatives{$protid1}.";".$protid2;}
		else{$hash_alternatives{$protid1}=$protid2;}
		
		if ($hash_alternatives{$protid2}){$hash_alternatives{$protid2}=$hash_alternatives{$protid2}.";".$protid1;}
		else{$hash_alternatives{$protid2}=$protid1;}
	}
}
close(In);

my @all_proteins=keys(%hash_protids);
my %hash_protein_selection;
foreach my $protein (@all_proteins)
{
	unless ($hash_protein_selection{$protein})
	{
		$hash_protein_selection{$protein}="selected";
		my $alternatives=$hash_alternatives{$protein};
		if ($alternatives)
		{
			my @alternative_proteins=split(/;/,$alternatives);
			foreach my $each_alternative (@alternative_proteins)
			{
				$hash_protein_selection{$each_alternative}="discarded";
			}
		}
	}
}

open(Out,">$fileout") || die "Cannot open file $fileout";
print Out "#Protein_ID\tSelection\tAlternative_proteins\n";
foreach my $protein (@all_proteins)
{
	my $selection_status=$hash_protein_selection{$protein};
	my $alternative_proteins=$hash_alternatives{$protein};
	print Out "$protein\t$selection_status\t$alternative_proteins\n";
}
close(Out);