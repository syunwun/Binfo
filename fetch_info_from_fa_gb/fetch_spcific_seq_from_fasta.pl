 #!/usr/bin/env perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;

my $in = shift;
my $id_file = shift;
my @ids;
open (IN, $id_file);
while (my $line = <IN>){
	chomp $line;
	push @ids, $line;
}
print scalar @ids."\n";

my $seqout = Bio::SeqIO->new(-format => 'fasta', -file => ">>$in"."_selecte");

foreach my $seqID(@ids){
#print $seqID."\n";
    my $seqin  = Bio::SeqIO->new(-format => 'fasta', -file => "$in");
	while(my $seqobj = $seqin->next_seq){
		my $id = $seqobj->display_id;
        #        $id =~ /UE\_(\d+)/;
        #        my $num = $1;
        #        if (($num>=1329)&&($num<=1382)){
        #if (($num>=1383)&&($num<=1444)){
        if ($id eq "$seqID"){
        #print $id."\n";
			$seqout->write_seq($seqobj);
#		}else{
#print $id."\n";
        }
        	}
    }
