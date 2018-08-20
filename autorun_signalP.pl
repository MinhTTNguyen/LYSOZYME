# October 5th 2017
# autorun muscle

#! /usr/perl/bin -w
use strict;

my $folderin="Proteomes";
my $folderout="Proteomes_signalP4_0";
my $output_format="summary";
my $org_group="euk";
mkdir $folderout;
opendir(DIR,"$folderin") || die "Cannot open folder $folderin";
my @files=readdir(DIR);
print "\n";
foreach my $file (@files)
{
	if (($file ne ".") and ($file ne ".."))
	{
		print "File $file ... begin\n";
		my $fileout=substr($file,0,-6);
		$fileout=$fileout."_SP.txt";
		my $cmd="/opt/signalp-4.0/signalp -f $output_format -t $org_group $folderin/$file > $folderout/$fileout";
		system $cmd;
		print "File $file ... done\n";
	}
}
closedir(DIR);