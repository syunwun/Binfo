#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
my $shift_base = shift;
#my $seqin  = Bio::SeqIO->new(-format => 'genbank', -file => "$in");
#my $seqout = Bio::SeqIO->new(-format => 'genbank', -file => ">$in\_shift.gb");
my $seqin  = Bio::SeqIO->new(-file => "$in");
my $seqout = Bio::SeqIO->new(-file => ">$in.shift.fasta");


while(my $seq = $seqin->next_seq()){
	#split into two seqs frag.
	my $front_seq = Bio::SeqUtils->trunc_with_features($seq, $shift_base + 1 , $seq->length);
	my $back_seq  = Bio::SeqUtils->trunc_with_features($seq, 1, $shift_base);
  	#join two seqs 
	Bio::SeqUtils->cat($front_seq, $back_seq);
	$seqout->write_seq($front_seq);
}
