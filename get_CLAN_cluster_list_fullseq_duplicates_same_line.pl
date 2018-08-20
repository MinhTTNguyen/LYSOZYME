# October 4th 2017
# Get list of protein ids and cluster information from CLAN clusters
# Modified on November 28th 2017 for fullseq CLAN clustering analysis

#! /usr/perl/bin -w
use strict;

my $CLAN_cluster_folder="/home/mnguyen/Research/For_Adrian/CLAN_16Jan2018/CLAN_new/Clusters_1E_20";
my $fileout="/home/mnguyen/Research/For_Adrian/CLAN_16Jan2018/CLAN_new/Aspergillus_exoproteins_CLAN_clusters_1E_20.txt";

open(Out,">$fileout") || die "Cannot open file $fileout";
print Out "#Cluster\tID\n";
opendir(DIR,"$CLAN_cluster_folder") || die "Cannot open folder $CLAN_cluster_folder";
my @files=readdir(DIR);
closedir(DIR);

foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		open(In,"<$CLAN_cluster_folder/$file") || die "Cannot open file $file";
		my $cluster=$file;
		$cluster=~s/CLAN\_Fullseq\_BLASTP\_//;
		$cluster=~s/\_//;
		while (<In>)
		{
			$_=~s/\s*$//;
			if ($_=~/^\>/)
			{
				my $id_line=$_;
				$id_line=~s/^\>//;
				$id_line=~s/\s+.*$//; #>NFE_AEB77713.1;NFE_tr|B8YI23|B8YI23_HELZE 267
				$id_line=~s/\|\|/\|/g;
				print Out "$cluster\t$id_line\n";
			}
		}
		close(In);
	}
}

close(Out);