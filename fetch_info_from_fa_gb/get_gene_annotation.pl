#!/usr/bin/env perl
use strict;
use Bio::EnsEMBL::Registry;

my $list = shift;
my $registry= 'Bio::EnsEMBL::Registry';
$registry->load_all('./master_reg.conf');

my $gene_adaptor = 
$registry->get_adaptor( "ustilago_esculenta_29", "core",
    "gene" );

open(IN, $list);
print "GENE_ID\tLength\tPosition\tDescription\n";
while(my $line = <IN>){
  chomp($line);
  my @genes = @{$gene_adaptor->fetch_all_by_external_name($line)};
  foreach my $gene(@genes){
    print $gene->external_name. "\t";
    print $gene->length. "\t";
    my $pos = $gene->seq_region_name(). ":".
    $gene->seq_region_start(). "-".
    $gene->seq_region_end(). ":".
    $gene->strand;
    print $pos. "\t";
    print $gene->description(). "\n";
  }  
}
