#!/use/bin/env perl
use strict;
#use warnings;

my $target_f = shift;
open (IN, $target_f);

my %target;
my @tar_det;

while(my $line = <IN>){
	chomp($line);
	my $gene;
	my $num;
	if ($line =~ /(\d+\_g)/){
		$gene = $1;
		$line =~ /(\:\s+)([0-9.]+)/;
	#if ($line =~ /(\d+\_g)(.+)(\:\s+)([0-9.]+)/){
		push @tar_det, $2;
		#$target{$gene} = [@tar_det];
		#print $gene, "\t",$target{$gene}[0],"\n";
	}
	my $pos;
	if ($line =~ /TMhelix\s+(\d+)/){
		#print $gene."\n";
		my @field = split "\t", $line;
		$gene = $field[0];
		$pos = $1;
		push @tar_det, $1;
		$target{$gene} = [@tar_det];
		print join "\t", ($gene, $target{$gene}[0], $target{$gene}[1]);
		#print "\n";
	}
}
print "\n";		
close(IN);
