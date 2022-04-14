#!/usr/bin/env perl
use strict;
#use warnings;
use List::MoreUtils qw(uniq);

my $path = shift;
my @files = glob "$path/*.txt";
my %kegg;
my @all_ko;
foreach my $f(@files){
    open(IN,$f);
    $f =~ /\/(.+)\.txt/;
    my $out1 = "$1\_with_pathwat.out";
    my $out2 = "$1\_merge.out";

    while (my $line = <IN>){
        chomp $line;
        my @column = split "\t", $line;
        #push @all_ko, $column[1];
        system("wget -O temp http://rest.kegg.jp/link/pathway/$column[1]");
        my $temp = system("") 
        

#build hash
        if (exists $kegg{$column[0]}){
            push @{$kegg{$column[0]}}, $column[1];
        }else{
            $kegg{$column[0]} = [$column[1]];
        }
    }
close(IN);

## fetch all ko
#my @uni_all_ko = uniq @all_ko;
#shift @uni_all_ko;
#my $uni = join "+", @uni_all_ko;
#system("wget -O $1 http://rest.kegg.jp/link/pathway/$uni");

=head
## fetch pathway id through ko
    open(OUT, ">$out1");
    print OUT "Gene\tKO\tpathway\n";
    foreach my $g(sort (keys %kegg)){
        my $ko = join ",", @{$kegg{$g}};
        print OUT join "\t", ($g, $ko);
        print OUT "\n";
    }
=cut

    
##generate a condense file on the gene;
    open(OUT, ">$out2");
    print OUT "Gene\tKO\n";
    foreach my $g(sort (keys %kegg)){
        my $ko = join ",", @{$kegg{$g}};
        print OUT join "\t", ($g, $ko);
        print OUT "\n";
    } 
}
