# Please note that the output file has full_length protein ids
#! /usr/perl/bin -w
use strict;

my $filein_info="GH25_spreadsheet_Nov24_47_selected_candidates_after_domain_checked.txt";
my $filein_fasta="fasta/GH25/GH25_fullseq_with_nosub.fasta";
my $fileout="GH25_spreadsheet_Nov24_47_selected_candidates_after_domain_checked_domain.fasta";

my %hash_fasta;
open(FASTA,"<$filein_fasta") || die "Cannot open file $filein_fasta";
my $id="";
my $seq="";
while (<FASTA>)
{
	$_=~s/\s*$//;
	if ($_=~/^\>/)
	{
		if ($seq){$hash_fasta{$id}=$seq;$seq="";}
		$id=$_;
		$id=~s/^\>//;
	}else{$_=~s/\s*//g;$seq=$seq.$_;}
}
$hash_fasta{$id}=$seq;
close(FASTA);

open(In,"<$filein_info") || die "Cannot open file $filein_info";
open(Out,">$fileout") || die "Cannot open file $fileout";
while (<In>)
{
	$_=~s/\s*//;
	if ($_=~/^\#/){next;};
	my @cols=split(/\t/,$_);
	my $clan_cluster_number=$cols[0];
	my $protid=$cols[1];
	my $domain_location=$cols[3];
	my $group=$cols[4];
	my $species=$cols[5];
	my $tree_sub=$cols[16];
	$species=~s/ /\_/g;
	$domain_location=~s/\.\./\-/;
	my $full_protid="";
	if ($tree_sub=~/sub\d+/){$full_protid=$tree_sub."|sub".$clan_cluster_number."|".$protid."_".$group."_".$species;}
	else{$full_protid="sub".$clan_cluster_number."|".$protid."_".$group."_".$species;}
	my $sequence=$hash_fasta{$full_protid};
	if ($sequence)
	{
		my @domain_ends=split(/-/,$domain_location);
		my $start=$domain_ends[0];
		my $end=$domain_ends[1];
		#print "\n$domain_location\t$start\t$end\n";
		my $domain_len=$end-$start+1;
		my $domain_sequence=substr($sequence,$start-1,$domain_len);
		print Out ">$full_protid\n$domain_sequence\n";
	}
	else{print "\nCould not find sequence for this id: $full_protid\n";exit;}
}
close(In);
close(Out);