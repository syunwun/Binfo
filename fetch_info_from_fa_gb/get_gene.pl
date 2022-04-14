#!/usr/bin/env perl
use strict;
use Bio::EnsEMBL::Registry;

my $list = shift;
my $registry= 'Bio::EnsEMBL::Registry';
$registry->load_all('./registry.conf');

my $gene_adaptor = $registry->get_adaptor( "vibrio_cholerae", "core", "gene" );
my $slice_adaptor = $registry->get_adaptor( "vibrio_cholerae", "core", "slice" );

my $slice = $slice_adaptor->fetch_by_region('chromosome', '1', 13023, 13445);
print $slice->seq();

my @genes = @{$gene_adaptor->fetch_all_by_external_name('VC0395_A0018')};
# my @genes = @{$gene_adaptor->fetch_all()};
# print scalar(@genes);
foreach my $gene(@genes){
  print $gene->stable_id()."\n";
  print $gene->seq_region_start. "\t". $gene->seq_region_end. "\t". $gene->seq_region_strand. "\n";
  print $gene->canonical_transcript()->translate()->seq();
}

