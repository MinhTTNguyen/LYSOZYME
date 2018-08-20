#! /usr/perl/bin -w
use strict;

my $filein="/home/mnguyen/Research/Lysozyme/GH73_all_16Jan_2018/CLAN_BLASTP_virus_fullseq/GH73_virus_CLAN_fulseq_clusters_info.txt";
my $folderout="/home/mnguyen/Research/Lysozyme/GH73_all_16Jan_2018/CLAN_BLASTP_virus_fullseq/CLAN_Clustered_fulseqs";
mkdir $folderout;

open(In,"<$filein") || die "Cannot open file $filein";
while (<In>)
{
	if ($_!~/^\#/)
	{
		$_=~s/\s*$//;
		my @cols=split(/\t/,$_);
		my $CLAN_cluster=$cols[0];
		my $protein_id=$cols[1];
		my $protein_seq=$cols[3];
		#my $org_group=$cols[2];
		#$CLAN_cluster="G".$CLAN_cluster;
		#unless ($CLAN_G0_cluster eq ""){$CLAN_cluster=$CLAN_cluster."_".$CLAN_G0_cluster;}
		my $fileout=$CLAN_cluster.".fasta";
		#$protein_id=$CLAN_cluster."|".$org_group."|".$protein_id;
		$protein_id=$CLAN_cluster."|".$protein_id;
		open(Out,">>$folderout/$fileout") || die "Cannot open file $fileout";
		print Out ">$protein_id\n$protein_seq\n";
		close(Out);
	}
}
close(In);