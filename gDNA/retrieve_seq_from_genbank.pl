#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
my ($start, $end) = (shift, shift);
my $seqin  = Bio::SeqIO->new(-format => 'genbank', -file => "$in");
my $seqout = Bio::SeqIO->new(-format => 'fasta', -file => ">$in.fa");
#my $seqout = Bio::SeqIO->new(-format => 'genbank', -file => ">$in\_after.gb");

while(my $seqobj = $seqin->next_seq()){
	my $desired_seq = Bio::SeqUtils->trunc_with_features($seqobj, $start, $end);	
	for my $feat_obj($desired_seq->get_SeqFeatures){
		foreach my $tag ( $feat_obj->get_all_tags() ) {
       	 		if ($tag eq "translation"){ 
				my @id = $feat_obj->get_tag_values("locus_tag");
				my @protein = $feat_obj->get_tag_values($tag);
				my $seq = Bio::Seq->new( -display_id => $id[0], -seq => $protein[0]);
                        $seqout->write_seq($seq)
			}
    		}
	}
}
