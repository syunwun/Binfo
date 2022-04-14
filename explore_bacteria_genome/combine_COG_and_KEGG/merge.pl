#!/usr/bin/env perl
use strict;
use List::MoreUtils qw(uniq);

# COGs: '/data02/home/susan/project/15_PS23/13_COGs/fasta/results_PS23/protein-id_cog.txt';

my $cogs = shift;
# NEHKHJAN_00002  COG1597 I   R
# NEHKHJAN_00004  COG3464 L

my $kegg = shift;
# KEGG: PS23.txt
# NEHKHJAN_00006
# NEHKHJAN_00007    K03581

my %c;
open (IN1, $cogs);
while (my $line1 = <IN1>){
    chomp $line1;
    my @field1 = split "\t", $line1;
    my $gene1 = shift @field1;
    my $cogs  = shift @field1;
    my $f_string = join "", @field1;
    $c{$gene1} = [$cogs, $f_string];
}
my %k;
open (IN2, $kegg);
while (my $line2 = <IN2>){
    chomp $line2;
    my @field2 = split "\t", $line2;
    my $gene2 = $field2[0];
    my $keg   = $field2[1] if (scalar @field2 >=2);
       $keg   = "\t" if (scalar @field2 == 1);
    if (exists $k{$gene2}){ 
        push @{$k{$gene2}}, $keg;
    }else{
        $k{$gene2} = [$keg];
    }
}


my @all_gene_multi = (keys %c, keys %k);
my @all_gene = uniq @all_gene_multi;
warn scalar @all_gene."\n";
foreach my $uni(@all_gene){
    print $uni."\t";
    my $str_c = "\t";
       $str_c = join "\t", @{$c{$uni}} if (exists $c{$uni});
    my $str_k = join "\t", @{$k{$uni}};
    print $str_c."\t", $str_k."\n";
    #print join "\t", (@{$c{$uni}}, @{$k{$uni}});
    #print "\n";
}
