#!/usr/bin/env perl
use strict;
use Bio::EnsEMBL::Registry;
use Bio::SeqIO;
use Bio::PrimarySeq;

my $pass_sigp = 0;
my $pass_tmhmm = 0;
my $pass_targetp = 0;
my $out = Bio::SeqIO->new(-file=>">secreted_proteins.fa", 
                          -format=> 'Fasta');

my $targetp_result = './targetp_results.txt';
my $targetp = &get_targetp_result($targetp_result);

#my $signalp_result = './signalp_result.v3.out.parsed';
my $signalp_result;
my $signalp;
if($signalp_result){
  $signalp = &get_signalp_result($signalp_result);
}

my $registry= 'Bio::EnsEMBL::Registry';
$registry->load_all('./master_reg.conf');

my $transcript_adaptor =
    $registry->get_adaptor( "ustilago_esculenta_29", "core",
    "transcript" );

my $translation_adaptor =
    $registry->get_adaptor( "ustilago_esculenta_29", "core",
    "translation" );

my $transcripts = $transcript_adaptor->fetch_all();
foreach my $transcript(@$transcripts){
  my $gene_id = $transcript->get_Gene()->external_name();
  $gene_id =~ s/\S+\_(\d+)/$1\_g/;

  my $translation =
    $translation_adaptor->fetch_by_Transcript($transcript);

  my $sigp_features;
  if($signalp_result){
    $sigp_features = $signalp->{$gene_id};
  }else{
    $sigp_features = $translation->get_all_ProteinFeatures('Signalp');
  }
  my $tmhmm_features = $translation->get_all_ProteinFeatures('Tmhmm');
  
  # avoid undefined value for signalp 3.0 results
  next unless(defined $sigp_features);
  if(scalar(@$sigp_features) > 0){
    $pass_sigp++;
  }
  if(scalar(@$sigp_features) > 0 and scalar(@$tmhmm_features) == 1){
  #if(scalar(@$sigp_features) > 0 and scalar(@$tmhmm_features) > 0){
   
    my $distance = 100;
    # for signalp 3.0 results input as file
    if($signalp_result && 
      @$tmhmm_features[0]->start > (@$sigp_features[0]->{'end'} + $distance)){ 
      next;
    }
    # for signalp results from ensembl protein features
    if(!$signalp_result &&
      @$tmhmm_features[0]->start > (@$sigp_features[0]->end() + $distance)){
      next;
    }

    $pass_tmhmm++;
    if($targetp->{$gene_id} eq 'M'){
      next;
    }else{
      print $gene_id. "\n";
      
      my $seqobj = Bio::PrimarySeq->new ( -seq => $translation->seq(),
                                          -id  => $gene_id,);
      $out->write_seq($seqobj);
      $pass_targetp++;
    }
  }else{
    #print "no\n";
  }
  #foreach my $feature(@$features){
  #  print $feature->hseqname(). "\n";
  #}
}
print "Signalp: $pass_sigp\n";
print "Tmhmm: $pass_tmhmm\n";
print "Targetp: $pass_targetp\n";

sub get_targetp_result {
  my $file = shift;

  my $ref;
  open(IN, $file);
  while(my $line = <IN>){
    chomp($line);
    my @array = split("\t", $line);
    $ref->{$array[0]} = $array[1];
  }
  close(IN);

  return $ref;
}

sub get_signalp_result {
  my $file = shift;

  my $ref;
  open(IN, $file);
  while(my $line = <IN>){
    chomp($line);
    my @array = split("\t", $line);
    if($array[1] eq 'S' and $array['3'] eq 'Y'){
      my $sigp->{'end'} = $array[2];
      push(@{$ref->{$array[0]}}, $sigp);
    }else{
      $ref->{$array[0]} = [];
    }
  }
  close(IN);

  return $ref;  
}
