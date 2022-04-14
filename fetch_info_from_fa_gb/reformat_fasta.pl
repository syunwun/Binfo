#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
my $seqin  = Bio::SeqIO->new(-format => '', -file => "$in");
my $seqout = Bio::SeqIO->new(-format => 'fasta', -file => ">$in.parsed");

while(my $seqobj = $seqin->next_seq()){
	$seqout->write_seq($seqobj);
}
