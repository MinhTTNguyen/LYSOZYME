# October 4th 2017
# Get list of protein ids and cluster information from CLAN clusters
# Modified on November 28th 2017 for fullseq CLAN clustering analysis

#! /usr/perl/bin -w
use strict;

my $CLAN_cluster_folder="/home/mnguyen/Research/Lysozyme/GH25_all_15Dec2017/Fungi/CLAN_fulseq_BLASTP/Groups_haveSP/CLAN_G0/G0_subgroups";
my $fileout="/home/mnguyen/Research/Lysozyme/GH25_all_15Dec2017/Fungi/CLAN_fulseq_BLASTP/Groups_haveSP/CLAN_G0/G0_subgroups.txt";
#>G0|Fungi|jgi|Dicsqu464_1|884488;G0|Fungi|jgi|Dicsqu18370_1|770827 416
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
		#$cluster=~s/CLAN\_fullseq\_//;
		while (<In>)
		{
			$_=~s/\s*$//;
			if ($_=~/^\>/)
			{
				my $id_line=$_;
				$id_line=~s/^\>//;
				$id_line=~s/\s+.*$//; #>NFE_AEB77713.1;NFE_tr|B8YI23|B8YI23_HELZE 267
				#$id_line=~s/\|\|/\|/g;
				#my $seq_id="";
				#my $org_group="";
				if ($id_line=~/\;/)
				{
					my @ids=split(/\;/,$id_line);
					foreach my $each_id (@ids)
					{
						#$seq_id=&Process_id($each_id);
						print Out "$cluster\t$each_id\n";
					}
				}
				else
				{
					#$seq_id=&Process_id($id_line);
					print Out "$cluster\t$id_line\n";
				}
			}
		}
		close(In);
	}
}

close(Out);

=pod
###################################################################################
sub Process_id
{
	my $sequence_id=$_[0];
	my $processed_id="";
	if ($sequence_id=~/^Fungi/){$processed_id=$sequence_id;}
	else
	{
		my @cols=split(/\|/,$sequence_id);
		my $org_group=shift(@cols);
		my $temp=scalar(@cols);
		if ($temp>1){$processed_id=$org_group."|".$cols[1];}
		else{$processed_id=$org_group."|".$cols[0];}
		return($processed_id);
	}
}
###################################################################################
=cut