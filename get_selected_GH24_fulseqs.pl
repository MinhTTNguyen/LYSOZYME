# october 4th 2017
# extract full-length sequences of selected GH24 proteins
# add cluster and organism information in the id lines

#! /use/perl/bin -w
use strict;

my $filein_selected_list="/home/mnguyen/Research/Lysozyme/GH24/Fungi_CSFG_JGI/GH24_fungi_CLAN_clusters_info.txt";
my $filein_fulseq="/home/mnguyen/Research/Lysozyme/GH24/Fungi_CSFG_JGI/GH24_fungi_CSFG_JGI_fullseqs.fasta";
my $fileout="/home/mnguyen/Research/Lysozyme/GH24/Fungi_CSFG_JGI/GH24_fungi_CSFG_JGI_CLAN_cluster_fullseqs.fasta";

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
		my $group=$cols[3];
		my $org=$cols[4];
		#print "\n$org\t";
		$org=~s/^\s*//;$org=~s/\s*$//;
		$org=~s/\s+/\_/g;
		#print "$org\n";exit;
		my $new_protid="sub".$cluster."|".$protid."_".$group."_".$org;
		$hash_prot_info{$protid}=$new_protid;
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
				delete($hash_prot_info{$id});
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
	delete($hash_prot_info{$id});
}
close(FASTA);
close(Out);
#==============================================================================================================#


print "\n";
while (my ($k, $v)=each (%hash_prot_info))
{
	print "Could not find sequence for this protein: $k\t$v\n";
}