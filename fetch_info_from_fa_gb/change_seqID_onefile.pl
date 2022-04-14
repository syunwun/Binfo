#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
#my $new = shift;
#my @all_seq = glob "$path/*.fa";
#my $new_id;
#foreach my $in (@all_seq){
my $seqin  = Bio::SeqIO->new(-format => 'fasta', -file => "$in");
my $seqout = Bio::SeqIO->new(-format => 'fasta', -file => ">$in\_parsed.fasta");

while(my $seqobj = $seqin->next_seq()){
	my $id = $seqobj->id;
#my $id_de = $seqobj->desc();
#		my $id;
#		if ($id_de =~ /id\=\d+\_1/){
#			$id = $id_o."_1";
#		}else{
#			$id = $id_o;
#		} 
		#print $id."\n";
		$id =~ /UE\_(\d+)/;
        my $num = $1;
        my $new_num = $num-1;
		my $new_id = "UE_".$new_num;
		#$new_id = $new if ($id =~ /^gene/);
		#$new_id = "Ecoli_BR933" if ($id =~ /^BE933/);
		#$new_id = "CG43" if ($id =~ /^LV/);
		#$new_id = "PMK1" if ($id =~ /^PMK1/);
		$seqobj->id($new_id);
        #my $des = "";
        #$seqobj->desc($des);
        #$seqobj->id($id);
		$seqout->write_seq($seqobj);	
	}
#}
