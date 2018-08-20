# 26 October 2017
# Convert genomic sequence of gene models into input file in R to create bar plot showing gene models

#! /usr/perl/bin -w
use strict;
use Getopt::Long;

my $folderout="/home/mnguyen/Research/Lysozyme/GH23_all_11Dec2017/Fungi/12Jul2018/Branch_no_good_models_3_produced_Rinput_part2";
my $folderin="/home/mnguyen/Research/Lysozyme/GH23_all_11Dec2017/Fungi/12Jul2018";
my $filein="protids_branch_no_good_model_with_3_produced_all_protid_CDs_part2.txt";
mkdir $folderout;
#GetOptions('folderin=s'=>\$folderin, 'filein=s'=>\$filein, 'folderout=s'=>\$folderout);

my $temp=$filein;
$temp=~s/\.txt//;
my $file_color=$temp."_color.txt"; #color array in R
my $file_bar_plot_coordinates=$temp."_coordinates.txt"; #color array in R
my $file_segment=$temp."_segment.txt";
my $file_exon_location=$temp."_text.txt";
my $file_model_ids=$temp."_text_modelids.txt";

#print "\n$folderout\n";exit;

open(Color,">$folderout/$file_color") || die "Cannot open file $file_color";
open(Coordinates,">$folderout/$file_bar_plot_coordinates") || die "Cannot open file $file_bar_plot_coordinates";
open(Segment,">$folderout/$file_segment") || die "Cannot open file $file_segment";
open(Text,">$folderout/$file_exon_location") || die "Cannot open file $file_exon_location";
open(Modelid,">$folderout/$file_model_ids") || die "Cannot open file $file_model_ids";
print Color "Color\n";
print Coordinates "x\ty\n";
print Text "x\ty\n";
print Segment "Start_x\tStart_y\tEnd_x\tEnd_y\n";
print Modelid "x\ty\tid\n";


open(In,"<$folderin/$filein") || die "Cannot open file $filein";
my $y=0;

while (<In>)
{
	$y++;
	$_=~s/\s*$//;
	$_=~s/^\s*//;
	my @cols=split(/\t/,$_);
	my $protid=$cols[0];
	my $modelid_y=$y+0.5;
	print Modelid "1\t$modelid_y\t$protid\n";
	my $seq=$cols[1];
	$seq=~s/\s*//g;
	my $x=0;
	my $intron_end=0;
	my $intron_start=0;
	my $exon_start=0;
	my $exon_end=0;
	my $exon=0;
	my $len=length($_);
	my $fileout=$protid.".txt";
	$fileout=~s/\|/\_/g;

	for (my $i=0;$i<$len;$i++)
	{
		my $nu=substr($seq,$i,1);
		if ($nu eq "[")
		{
			$exon=1;
			$exon_start=$x+1;
			print Text "$exon_start\t$y\n";
			if ($intron_start)
			{
				$intron_end=$x-1;
				print Segment "$intron_start\t$y\t$intron_end\t$y\n";
			}
		}elsif($nu eq "]")
		{
			$exon=0;
			$exon_end=$x;
			print Text "$exon_end\t$y\n";
			$intron_start=$x+1;
		}else
		{
			if ($exon){print Color "red\n";}
			else{print Color "white\n";}
			$x++;
			print Coordinates "$x\t$y\n";
		}
	}
}
close(In);
close(Color);
close(Coordinates);
close(Text);
close(Segment);
close(Modelid);