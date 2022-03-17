#!/use/bin/env perl
use strict;
use warnings;

my $file = shift;
my $new_id;
#open (OUT,">>target_parsed.out");
open(IN, $file);
my $line = <IN>;
chomp($line);
print $line."\n";
while($line = <IN>){
	chomp($line);
		#if($line =~ /(\S+)\s+\d+\s+[\d\.]+\s+[\d\.]+\s+[\d\.]+\s+(\S+)\s+(\d+)/){
	if ($line =~ /(\d+)\_g(.+)/){
        $new_id = "UE_".$1;
		#print OUT $line."\n";
		print $new_id.$2."\n";
			#if($2 eq 'M'){
				#$res_targetp->{$1} = $1;
			#}
		}
	}
    #}
close(IN);
#close(OUT);
