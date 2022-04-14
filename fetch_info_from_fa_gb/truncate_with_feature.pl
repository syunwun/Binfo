#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
my $start = shift;
my $end = shift;
my $seqin  = Bio::SeqIO->new(-format => 'genbank', -file => "$in");
my $seqout = Bio::SeqIO->new(-format => 'genbank', -file => ">$in\_trunc.gb");


while(my $seq = $seqin->next_seq()){
	#split into two seqs frag.
    #my $trunc_seq  = Bio::SeqUtils->trunc_with_features($seq, 1, $base);
	my $trunc_seq  = Bio::SeqUtils->trunc_with_features($seq, $start, $end);
	$seqout->write_seq($trunc_seq);
}
