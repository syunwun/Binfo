#!/usr/bin/env perl
use strict;

my $path = shift;
my @files = glob "$path/x*";
#my $f = shift;
foreach my $f(@files){
my @all_ko;
open(IN,$f);
while (my $line = <IN>){
    chomp $line;
    push @all_ko, $line;
}
my $ko_string = join "+", @all_ko;
system("wget -O $f.out http://rest.kegg.jp/link/pathway/$ko_string");
}
