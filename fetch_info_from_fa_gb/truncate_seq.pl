#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
my $start = shift;
my $end = shift;
my $seqin  = Bio::SeqIO->new(-format => 'fasta', -file => "$in");
my $seqout = Bio::SeqIO->new(-format => 'fasta', -file => ">$in.partial");

while(my $seqobj = $seqin->next_seq()){
	#my $length = $seqobj->length();
	my $newseq = $seqobj->trunc($start, $end);
	$seqout->write_seq($newseq);
}
