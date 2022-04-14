#!/usr/bin/env perl
use strict;
#my @strains = ('LMGS29188','Lpp230','NRIC1917');
my @strains = ('TMW1.1434', 'L9', 'NTU101','8700_2', 'PS23', 'ATCC334', 'FAM18149');
foreach my $s(@strains){
    warn $s.".......\t";
    system ("perl /data02/home/susan/project/15_PS23/16_merge_COGs_KEGG/script/merge.pl /data02/home/susan/project/15_PS23/13_COGs/fasta/results_$s/protein-id_cog.txt /data02/home/susan/project/15_PS23/14_KEGG/BlastKoala/$s.txt  > $s\_cogs_kegg.txt");
    #system ("awk '\$3~/I/{print}' $s\_cogs_kegg.txt > $s\_I_cogs_kegg.txt");
}
