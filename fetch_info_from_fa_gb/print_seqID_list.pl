#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
my $seqin  = Bio::SeqIO->new(-format => 'fasta', -file => "$in");
#my $seqout = Bio::SeqIO->new(-format => 'fasta', -file => ">$in.genelist.txt");
open(OUT, ">$in.genelist.txt");

while(my $seqobj = $seqin->next_seq()){
	my $ID = $seqobj->id;
	#if ($ID =~ /(unitig_\d+)/){
	#	$ID = $1;
		#my @name = split (/\|/,$ID);
		#print OUT $name[2]."\n";
		print OUT $ID."\n";
	#	print OUT $seqobj->seq."\n";
		#$seqout->write_seq($seqobj);
	#}
}
close(OUT);
