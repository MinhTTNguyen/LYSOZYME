# October 4th 2017
# Get list of protein ids and cluster information from CLAN clusters

#! /usr/perl/bin -w
use strict;

my $CLAN_cluster_folder="/home/mnguyen/Research/Lysozyme/GH25_all_15Dec2017/Fungi/CLAN_fulseq_BLASTP/Groups_haveSP/CLAN_G0/G0_subgroups";
my $fileout="/home/mnguyen/Research/Lysozyme/GH25_all_15Dec2017/Fungi/CLAN_fulseq_BLASTP/Groups_haveSP/CLAN_G0/G0_subgroups.txt";

open(Out,">$fileout") || die "Cannot open file $fileout";
print Out "#Cluster\tID\tDomain_location\n";
opendir(DIR,"$CLAN_cluster_folder") || die "Cannot open folder $CLAN_cluster_folder";
my @files=readdir(DIR);
closedir(DIR);

foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		open(In,"<$CLAN_cluster_folder/$file") || die "Cannot open file $file";
		my $cluster=$file;
		#$cluster=~s/^.+\_//;
		while (<In>)
		{
			$_=~s/\s*$//;
			if ($_=~/^\>/)
			{
				my $id_line=$_;
				$id_line=~s/^\>//;
				$id_line=~s/\s+\d+$//;
				if ($id_line=~/\;/)
				{
					my @ids=split(/\;/,$id_line);
					foreach my $each_id (@ids)
					{
						
						my @id_domain=split(/\|/,$each_id);
						my $domain_loc=pop(@id_domain);
						my $temp=scalar(@id_domain);
						my $seq_id;
						if ($temp > 1){$seq_id=$id_domain[0]."|".$id_domain[1]."|".$id_domain[2];}
						else{$seq_id=$id_domain[0];}
						$domain_loc=~s/\-/../;
						print Out "$cluster\t$seq_id\t$domain_loc\n";
					}
				}
				else
				{
					#>jgi|Diocr1|272388|estExt_Genewise1.C_120108|220-352
					my @id_domain=split(/\|/,$id_line);
					my $domain_loc=pop(@id_domain);
					my $temp=scalar(@id_domain); # CSFG's id does not contain |; so, $temp should be 1
					my $seq_id;
					if ($temp > 1){$seq_id=$id_domain[0]."|".$id_domain[1]."|".$id_domain[2];}
					else{$seq_id=$id_domain[0];}
					$domain_loc=~s/\-/../;
					print Out "$cluster\t$seq_id\t$domain_loc\n";
				}
			}
		}
		close(In);
	}
}

close(Out);