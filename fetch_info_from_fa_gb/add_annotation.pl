#!/use/bin/env perl
use strict;
#use warnings;

my $annotation = shift;
my $list = shift;
open (IN, $annotation);
my %anno_hash;
#my %protcomp;
#my @tar_det;

while(my $line = <IN>){
	chomp($line);
    my @fields = split ("\t", $line);
    my $gene = $fields[0];
    $fields[4] =~ /Full\=(.+)\;/;
    my $anno = $1;
    $anno_hash{$gene} = $anno;
}
close(IN);
warn $anno_hash{'7142_g'}."\n";

open(IN2, $list);
my $line2 = <IN2>;
chomp($line2);
print $line2."\t"."annotation"."\n";
while($line2=<IN2>){
    chomp($line2);
    $line2 =~ /^(\d+\_g)/;
    my $gene = $1;
    #warn $gene."\n";
    print $line2."\t".$anno_hash{$gene}."\n";
}
close(IN2);
