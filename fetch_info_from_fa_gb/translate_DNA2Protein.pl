#!/usr/bin/env perl
use strict;
use warnings;
use Bio::SeqIO;

my $fileIn = shift;
my $seqin = Bio::SeqIO->new(-file => "$fileIn",
		              -format => "fasta");
my $seqout = Bio::SeqIO->new(-file => ">$fileIn"."_prot.fasta");

while(my $seq_obj = $seqin->next_seq){
	my $pro_obj = $seq_obj->translate;
	#my $pro_obj = $seq_obj->translate( -orf => 1);
	#my $pro_obj = $seq_obj->translate(-complete => 1, -orf => 1);
	print $seqout->write_seq($pro_obj), "\n";
}

