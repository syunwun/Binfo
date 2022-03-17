#!/use/bin/env perl
use strict;
use List::MoreUtils qw(uniq);
#use warnings;

my $protcomp_f = shift;
open (IN, $protcomp_f);

my $gene_line;
my %gene_list;
#my @tar_det;
my $line = <IN>;
#$line = <IN>;
#$line = <IN>;
#chomp($line);
#$gene_line = $line;
while(my $line = <IN>){
	chomp($line);
    if($line =~ /^Seq\sname\:\s(\d+\_g)/){
        $gene_line = $1;
        $gene_list{$gene_line} = 'Y';
        #push @gene_list, $gene_line;
#    }elsif($line =~ /Extracellular\s\(Secreted\)/){
    }elsif(($line =~ /Database\ssequence\:/)&&($line !~ /Extracellular/)){
        warn $gene_line."\n";
        $gene_list{$gene_line} = 'N';
        #    }else{
        #        $gene_list{$gene_line} = 'Y';
        #push @gene_list, $gene_line;
        #Location:Extracellular (Secreted)
        #if($line !~ /Extracellular/){
            #print $gene_line."\t".$line."\n";
            #$gene_line =~ /Seq\sname\:\s(\d+\_g)/;
            #}
    }
}
close(IN);

foreach my $g(keys%gene_list){
    print $g."\t"."$gene_list{$g}"."\n";
}
#my @uniq_gene_list = uniq @gene_list;
#foreach my $u(@uniq_gene_list){
#    print $u."\n";
#}
