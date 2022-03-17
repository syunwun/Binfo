#!/usr/bin/env perl
use Bio::SeqIO;

my $gb_file = shift;
my $seqio_object = Bio::SeqIO->new(-file => $gb_file);
my $seq_object = $seqio_object->next_seq;

for my $feat_object ($seq_object->get_SeqFeatures) {
    #foreach my $tag ($feat_obj->get_all_tags) {
    #        if ($tag eq "translation"){    
    #if ($feat_object->primary_tag eq "CDS") {
            if ($feat_object->primary_tag eq "CDS") {
            print ">", $feat_object->get_tag_values('locus_tag'),"\n";
            print $feat_object->spliced_seq->seq,"\n";
        }
    }
    #}

=head
#while(my $seqobj = $seqin->next_seq()){
#     my $desired_seq = Bio::SeqUtils->trunc_with_features($seqobj, $start, $end);
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
=cut
