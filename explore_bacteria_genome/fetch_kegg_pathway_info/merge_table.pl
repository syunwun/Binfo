#!/usr/bin/env perl
use strict;
#use warnings;
use List::MoreUtils qw(uniq);

## usage: "perl merge_table.pl your/path name/number > your/file/name";


my $path = shift;
my $demand = shift;  ## name or number
my @files = glob "$path/*.txt";
my %b_koala;
my @all_ko;
foreach my $f(@files) {
    $f =~ /\/(.+)\.txt/;
    my $name = $1;
    open (IN, $f);
    #my $line = <IN>;
    while (my $line = <IN>){
        chomp $line;
        #CMGKPKIH_00004 K03629
        $line =~ /^(\w+)\t(K\d+)/;
        my $gene = $1;
        my $ko = $2;
        if ($ko){
            push @all_ko, $ko;
            if (exists $b_koala{$name}->{$ko}){
                push @{$b_koala{$name}->{$ko}}, $gene;
            }else{
                $b_koala{$name}->{$ko} = [$gene];
            }
        }
    }
}
close(IN);
#warn $b_koala{"PS23"}{"K00009"}[3]."\n";

my @strains = sort (keys %b_koala);
my $ss = join "\t", @strains;
print "KO\t$ss\n";   

my $allK_file = '/data02/home/susan/project/15_PS23/14_KEGG/BlastKoala/result/ko_pathway_parsed.txt';
my %allK;
open (IN, $allK_file);
while (my $line = <IN>){
    chomp $line;
    my @fie = split "\t", $line;
    $allK{$fie[0]} = $fie[1];
}
close(IN);

my $cog_k_file = '/data02/home/susan/project/15_PS23/16_merge_COGs_KEGG/cog_kegg_table.txt';
my %cog_k;
open (INK, $cog_k_file);
while (my $line_k = <INK>){
    chomp $line_k;
    my @fie_k = split "\t", $line_k;
    $cog_k{$fie_k[0]} = $fie_k[1];
}

my @uni_ko = uniq @all_ko;
#warn scalar @uni_ko."\n";
#warn $uni_ko[0]."\n";

foreach my $uni(@uni_ko){
    print $uni."\t";
    print $allK{$uni}."\t";
    print $cog_k{$uni}."\t";
    my $num = 0;
    foreach my $st(@strains){
        if (exists $b_koala{$st}{$uni}){
            my $value = $b_koala{$st}{$uni};
            if ($demand eq 'number'){
                my $num_value = scalar @{$value};
                print $num_value."\t";
                $num++ if($num_value > 0);
                #print scalar @{$value}."\t";
            }elsif ($demand eq 'name'){
                my $string = join ",", @{$value};
                print $string."\t";
            }
        }else{
            print "0\t";
        }
    }
    print "$num\n";
}
