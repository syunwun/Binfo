#!/use/bin/env perl
use strict;
#use warnings;

my $protcomp_f = shift;
open (IN, $protcomp_f);

#my %protcomp;
#my @tar_det;

while(my $line = <IN>){
	chomp($line);
	if (($line =~ /^Seq\sname\:/)||($line =~ /Extracellular\s\(Secreted\)/)){
		print $line."\n";
	}
}
#print "\n";		
close(IN);
