# october 4th 2017
# extract full-length sequences of selected GH24 proteins
# add cluster and organism information in the id lines

#! /use/perl/bin -w
use strict;

my $filein_selected_list="GH24_preliminary_targets_05102017.txt";
my $filein_fulseq="CAZy_GH24_domain_seqs_after_hmm.fasta";
my $fileout="GH24_preliminary_targets_05102017_domainseqs.fasta";

#==============================================================================================================#
open(Selected,"<$filein_selected_list") || die "Cannot open file $filein_selected_list";
my %hash_prot_info;
while (<Selected>)
{
	$_=~s/\s*$//;
	if ($_!~/^#/)
	{
		my @cols=split(/\t/,$_);
		my $cluster=$cols[0];
		my $protid=$cols[1];
		my $domain_loc=$cols[2];
		my $group=$cols[3];
		my $org=$cols[4];
		$domain_loc=~s/\.\./\-/;
		my $old_protid=$protid."|".$domain_loc;
		my $new_protid="sub".$cluster."|".$protid."|".$domain_loc."_".$group."_".$org;
		$hash_prot_info{$old_protid}=$new_protid;
	}
}
close(Selected);
#==============================================================================================================#




#==============================================================================================================#
open(FASTA,"<$filein_fulseq") || die "Cannot open file $filein_fulseq";
open(Out,">$fileout") || die "Cannot open file $fileout";
my $id="";
my $seq="";
while (<FASTA>)
{
	$_=~s/\s*$//;
	if ($_=~/^\>/)
	{
		if ($seq)
		{
			if ($hash_prot_info{$id})
			{
				my $new_id=$hash_prot_info{$id};
				print Out ">$new_id\n$seq\n";
			}
			$seq="";
			$id="";
		}
		$id=$_;
		$id=~s/^\>//;
		$id=~s/\s*//g;
	}
	else{$_=~s/\s*//g;$seq=$seq.$_;}
}
if ($hash_prot_info{$id})
{
	my $new_id=$hash_prot_info{$id};
	print Out ">$new_id\n$seq\n";
}
close(FASTA);
close(Out);
#==============================================================================================================#