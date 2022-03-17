#!/usr/bin/env perl
use strict;
use warnings;
use Bio::Tools::GFF;
use Bio::SeqFeatureI;

my $list = shift;
my $file = shift;
#print join "\t", ('name', 'seqid','start', 'end', 'strand', 'description');
#print "\n";

my %gff;
my $gffin = Bio::Tools::GFF->new (-file => $file, -gff_version => 3);
while (my $feat = $gffin->next_feature){
	if ($feat->primary_tag eq 'gene'){
		#my @tags = $feat->get_all_tags;
		#my @alltagvalue = $feat->get_tagset_values(qw(locus_tag product));
		my @gene = $feat->get_tag_values('locus_tag');
		my @des  = $feat->get_tag_values('product');
		my $loc  = $feat->location;
		my $str  = $feat->gff_string;
		my @field = split "\t", $str;
		my $seqid = $field[0];
		my $strand = $field[6];
		#print join "\t", ($$gene, $$des);
#       $gene[0]=~/UE_(\d+)/;
#       my $gene_name = "$1\_g";
		#print $gene[0]."\t";
		#print $gene_name."\t";
#		print $gene[0]."\t";
#		print join "\t", ($seqid,$loc->start, $loc->end, $strand);
#		print "\t";
#		print join " ", @des;
		$gff{$gene[0]} = $str; 
        #foreach my $d (@des){
		#	print $d."\t";
		#}	
#		print "\n";
	}
}	

open(L, $list);
my $line=<L>;
chomp $line;
print $line."\t"."annotation"."\n";
while($line=<L>){
    chomp $line;
    my @f = split "\t", $line;
    my $gene_input = $f[0];
    print join "\t", ($line, $gff{$gene_input});
    print "\n";
}
