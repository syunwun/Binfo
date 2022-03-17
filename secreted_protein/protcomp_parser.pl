#!/usr/bin/env perl
use strict;

my $file = shift;
open(IN, $file);
my $list;
my $gene_id;
while(my $line = <IN>){
  chomp($line);
  if($line =~ /Seq name\:\s+(\S+)\,/){
    $gene_id = $1;
    $list->{$gene_id} = $gene_id;
  }elsif($line =~ s/^\s+//){
    #print $line. "-------\n";
    $line =~ /^(\w+\.?\s?\w+\.?)\s+([\d\.]+)\s\/\s+([\d\.]+)\s\//;
    print $1. "\t". $2. "\t". $3. "\n";
    if($1 ne 'Extracellular' and ($2 ne '0.0' or $3 ne '0.0')){
      #print $line. "\n";
      delete($list->{$gene_id});
    }
  }
}
close(IN);

foreach my $id(sort keys %$list){
   	$id =~ s/(\d+)\_g/JSKK29_$1/;
	print $id. "\n";
}
