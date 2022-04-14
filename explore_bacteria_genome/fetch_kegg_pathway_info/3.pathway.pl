#!/usr/bin/env perl
use strict;
 
my $kp_file = '/data02/home/susan/project/15_PS23/14_KEGG/BlastKoala/result/ko_pathway.txt';
my %hash;
#ko:K02787   path:map00052
#ko:K02787   path:ko00052
open (IN, $kp_file);
while(my $line = <IN>){
    chomp $line;
    $line =~ /ko\:(K\d+)\tpath\:(map\d+)/;
    my $ko  = $1;
    my $map = $2;
    if (exists $hash{$ko}){
        push @{$hash{$ko}}, $map;
    }else{
        $hash{$ko} = [$map];
    }
}
close(IN);

my @all_k = sort keys %hash;
shift @all_k;

foreach my $k(@all_k){
    print $k."\t";
    my $k_string = join ",",@{$hash{$k}};
    print $k_string."\n";
}
