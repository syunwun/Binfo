#!/use/bin/env perl
use strict;
use warnings;

my $work_dir = shift;
my @targetp_results = glob("$work_dir/UE_split.*_out.txt");
#open (OUT,">>target_parsed.out");

foreach my $file(@targetp_results){
	open(IN, $file);
	while(my $line = <IN>){
		chomp($line);
		#if($line =~ /(\S+)\s+\d+\s+[\d\.]+\s+[\d\.]+\s+[\d\.]+\s+(\S+)\s+(\d+)/){
		if ($line =~ /_g/){
		#print OUT $line."\n";
		print $line."\n";
			#if($2 eq 'M'){
				#$res_targetp->{$1} = $1;
			#}
		}
	}
}
close(IN);
#close(OUT);
