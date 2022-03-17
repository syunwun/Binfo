#!/usr/bin/env perl
use strict;
use Bio::SeqIO;
use Bio::SeqFeature::Generic;
use Bio::Tools::GFF;
use Getopt::Long;

my ($gff, $fasta);
&GetOptions(
    'gff:s' => \$gff,
    'fa:s' => \$fasta,
    );

unless($gff && $fasta){
  die "Usage:
      perl generate_genbank_from_gff.pl -gff gff_file.gff -fa seq.fa\n";
}

my $gbk = $gff;
$gbk =~ s/gff/gb/;
my $gff_features;
my $gffio = new Bio::Tools::GFF(-file => "$gff" ,
                     -gff_version => 3);

while(my $feature = $gffio->next_feature()) {
  my ($locus_tag) = $feature->get_tag_values('locus_tag');
  push(@{$gff_features->{$feature->seq_id}->{$locus_tag}->{$feature->primary_tag}}, $feature);
}
$gffio->close();
  
my $seq_in  = Bio::SeqIO->new(-file => $fasta ,
                           -format => 'Fasta');
my $seq_out = Bio::SeqIO->new(-file => ">$gbk" ,
                           -format => 'Genbank');
while(my $seq = $seq_in->next_seq){
  foreach my $locus_tag(keys %{$gff_features->{$seq->id}}){
    #print $locus_tag. "\n";
    foreach my $type(keys %{$gff_features->{$seq->id}->{$locus_tag}}){
      my $feature;

      # join CDS together
      if($type eq 'CDS'){
        my $location = Bio::Location::Split->new();
        for my $f ( @{$gff_features->{$seq->id}->{$locus_tag}->{$type}}) {
          $location->add_sub_Location($f->location);
        }

        $feature = Bio::SeqFeature::Generic->new(-location =>$location, 
-primary_tag => 'CDS');

        # make translation
        my $cds;
        if($feature->strand == -1){
          $cds = $seq->trunc($location->start, $location->end)->revcom();
        }else{
          $cds = $seq->trunc($location->start, $location->end)
        }
        my $translation = $cds->translate->seq();
        $feature->add_tag_value("locus_tag", $locus_tag);
        $feature->add_tag_value("translation", $translation);
      }elsif(scalar(@{$gff_features->{$seq->id}->{$locus_tag}->{$type}}) > 1){
        die "Feture type: $type has more than one freture!!\n";
      }else{
        ($feature) = @{$gff_features->{$seq->id}->{$locus_tag}->{$type}};
      }
      $seq->add_SeqFeature($feature);
    }  
  }
  $seq_out->write_seq($seq);
}

=head
my %genes;
while( my $f = $gffio->next_feature ) {
   my ($group) = $feature->get_tag_values('Group'); # substitute group 
with whatever you have in the group field
  push @{$gene{$group}}, $feature;
}
# get a Bio::Seq object called $seq somehow, either by reading in a 
fasta sequence file, etc...
while( my ($gene,$features) = each %genes ) {
  my $location = Bio::Location::Split->new();
  for my $f ( @$features ) {
    $location->add_sub_Location($f->location);
  }
  my $genef = Bio::SeqFeature::Generic->new(-location =>$location, 
-primary_tag => 'CDS');
  $seq->add_SeqFeature($genef);
}
my $seqio = Bio::SeqIO->new(-format => 'genbank');
$seqio->write_seq($seq);
=cut

