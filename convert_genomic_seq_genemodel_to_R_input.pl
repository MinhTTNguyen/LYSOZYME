# 26 October 2017
# Convert genomic sequence of gene models into input file in R to create bar plot showing gene models

#! /usr/perl/bin -w
use strict;

my $filein="/home/mnguyen/Research/Lysozyme/GH23_all_11Dec2017/Fungi/12Jul2018/protids_branch_no_good_model_with_3_produced_all_protid_CDs.txt"; #gene model sequences
my $folder_color="Color"; #color array in R
my $folder_bar_plot_coordinates="Coordinates"; #color array in R
my $folder_segment="Segment";
my $folder_exon_location="Text";
mkdir $folder_color;
mkdir $folder_bar_plot_coordinates;
mkdir $folder_segment;
mkdir $folder_exon_location;

open(In,"<$filein") || die "Cannot open file $filein";
my $x=0;
my $y=1;
my $exon=0;
my $intron_end=0;
my $intron_start=0;
my $exon_start=0;
my $exon_end=0;
while (<In>)
{
	$_=~s/\s*$//;
	$_=~s/^\s*//;
	my @cols=split(/\t/,$_);
	my $protid=$cols[0];
	#print "$protid\t";
	my $seq=$cols[1];
	$x=0;
	my $len=length($_);
	my $fileout=$protid.".txt";
	$fileout=~s/\|/\_/g;
	#print "$fileout\n";
	open(Color,">$folder_color/$fileout") || die "Cannot open file $folder_color/$fileout";
	open(Coordinates,">$folder_bar_plot_coordinates/$fileout") || die "Cannot open file $folder_bar_plot_coordinates/$fileout";
	open(Segment,">$folder_segment/$fileout") || die "Cannot open file $folder_segment/$fileout";
	open(Text,">$folder_exon_location/$fileout") || die "Cannot open file $folder_exon_location/$fileout";
	print Color "Color\n";
	print Coordinates "x\ty\n";
	print Text "x\ty\n";
	print Segment "Start_x\tStart_y\tEnd_x\tEnd_y\n";
	
	for (my $i=0;$i<$len;$i++)
	{
		my $nu=substr($_,$i,1);
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
		}
		elsif($nu eq "]")
		{
			$exon=0;
			$exon_end=$x-1;
			print Text "$exon_end\t$y\n";
			$intron_start=$x+1;
		}
		else
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