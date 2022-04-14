#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
my $seqin  = Bio::SeqIO->new(-format => 'fasta', -file => "$in");
$in =~ /(.+)\.fa/;
my $name = $1;
my $seqout = Bio::SeqIO->new(-format => 'fasta', -file => ">$name\_reverse.fa");

while(my $seqobj = $seqin->next_seq()){
	if ($seqobj->alphabet eq 'dna'){
		my $rev = $seqobj->revcom;
		$seqout->write_seq($rev);
	}
}
