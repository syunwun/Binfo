#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
my $seqin  = Bio::SeqIO->new(-format => 'genbank', -file => "$in");
my $seqout = Bio::SeqIO->new(-format => 'genbank', -file => ">$in\_reverse.gb");

#$revcom = Bio::SeqUtils->revcom_with_features($seq);
while(my $seqobj = $seqin->next_seq()){
	#if ($seqobj->alphabet eq 'dna'){
	#my $rev = $seqobj->revcom;
	my $rev = Bio::SeqUtils->revcom_with_features($seqobj);
	$seqout->write_seq($rev);
	#}
}
