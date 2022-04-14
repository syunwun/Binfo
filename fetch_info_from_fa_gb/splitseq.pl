#!/usr/bin/env perl
use strict;
use Bio::SeqIO;

my $file = shift;
my $num  = 1;


my $seqio = Bio::SeqIO->new(-file => $file,
                            -format => 'fasta' );

while ( my $seq = $seqio->next_seq){
	
	##104_g:Chromosome:6:138463:140036:-1:1:44449_fasta.contigs##
	#KP1750_6M.fasta_unitig_3|quiver.fasta#
	#my $id = $seq->id;
	   #$id =~ /(unitig_\d+)\|/;
	   #$file =~ /^(.+)\.fasta/;
	#my $out_name = "$file\_$1";
	#my $gene_name = $1;
	
	my $seqout = Bio::SeqIO->new(-file   => ">$file.$num",
	
	#my $seqout = Bio::SeqIO->new(-file   => ">$out_name",
				     -format => 'fasta');
	$num++;
       	$seqout->write_seq($seq);
}
#print $num."\n";	        
