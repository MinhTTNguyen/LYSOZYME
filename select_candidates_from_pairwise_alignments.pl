#! /usr/perl/bin -w
use strict;

my $filein="GH25_set2_matrix1_proteins_aln.txt";
my $fileout="GH25_set2_matrix1_proteins_aln_selection_cutoff65.txt";
my $percent_id_cutoff=65;

open(In,"<$filein") || die "Cannot open file $filein";
open(Out,">$fileout") || die "Cannot open file $fileout";
my %hash_protid_similarprots;
my %hash_all_prots;
while (<In>)
{
	$_=~s/\s*$//;
	my @cols=split(/\t/,$_);
	my $protid1=$cols[0];
	my $protid2=$cols[1];
	my $percent_id=$cols[2];
	$hash_all_prots{$protid1}++;
	$hash_all_prots{$protid2}++;
	if ($percent_id >= $percent_id_cutoff)
	{
		if ($hash_protid_similarprots{$protid1}){$hash_protid_similarprots{$protid1}=$hash_protid_similarprots{$protid1}.";".$protid2;}
		else{$hash_protid_similarprots{$protid1}=$protid2;}
		
		if ($hash_protid_similarprots{$protid2}){$hash_protid_similarprots{$protid2}=$hash_protid_similarprots{$protid2}.";".$protid1;}
		else{$hash_protid_similarprots{$protid2}=$protid1;}
	}
}
close(In);
my @all_proteins=keys(%hash_all_prots);

my %hash_protid_selection;

foreach my $protein (@all_proteins)
{

	my $similar_protein=$hash_protid_similarprots{$protein};
	if ($similar_protein)
	{
		if ($similar_protein=~/\;/)
		{
			$hash_protid_selection{$protein}=$similar_protein;
		}else
		{
			if ($hash_protid_similarprots{$similar_protein} eq $protein)
			{
				unless ($hash_protid_selection{$protein})
				{
					$hash_protid_selection{$protein}="selected_1";
					$hash_protid_selection{$similar_protein}="discarded";
				}
			}else{$hash_protid_selection{$protein}=$similar_protein;}
		}
	}else{$hash_protid_selection{$protein}="selected";}
}

while (my ($k, $v)=each (%hash_protid_selection))
{
	print Out "$k\t$v\n";
}
close(Out);