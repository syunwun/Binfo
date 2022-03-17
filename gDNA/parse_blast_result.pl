#!/usr/bin/env perl
use strict;
use warnings;
use Bio::SearchIO;

my $path = shift;
my @files = glob "$path/*out";
my $cov_thre = shift;
my $id_thre  = shift;
my $qname = "c$cov_thre"."i$id_thre";

##input blast file
#my $in = shift;
foreach my $in (@files){
my $input = new Bio::SearchIO(-format => '', -file   => $in);
#my $output = $in.'_parsed_flag1';
my $output = $in.'_parsed_'.$qname;

open (OUT,">$output")or die "$!";
print OUT "Query\t","Qlength\t","Qstart\t","Qend\t","Sbject\t","Slength\t","Sstart\t","Send\t","Bit_score\t","Evalue\t","Raw_score\t","Query_coverage\t","Subject_coverage","Identity\t"."Query_description\t","Subject_description\n";


while( my $result = $input -> next_result ) {
    my $flag = 1;
	while( my $hit = $result -> next_hit ) {
#    my $flag = 1;
		while( my $hsp = $hit -> next_hsp ) {
			my $cov_q = $hsp->length('query')/($result->query_length)*100;
			my $cov_s = $hsp->length('hit')/($hit->length)*100;
            my $id = $hsp->percent_identity;
            if ($flag == 1){
		    	#if (($cov_q >= 50)&&($id >= 90)&&($cov_s >= 50)){
                if (($cov_q >= $cov_thre)&&($id >= $id_thre)){
                #if (($cov_s >= $cov_thre)&&($id >= $id_thre)){
			        print OUT 
			        #print
    				#Query
    				$result->query_name,"\t",
    				$result->query_length,"\t",
    				$hsp->start('query'),"\t",
    				$hsp->end('query'),"\t",
    				#Subject
    				$hit->name,"\t",
    				$hit->length,"\t",
    				#$hit->start('hit'),"|",
    				#$hit->end('hit'),"|",
    				$hsp->start('hit'),"\t",
    				$hsp->end('hit'),"\t",
                    #$hsp->strand('hit'),"\t",
    				#$hsp->range('query'),"\t",
    				#$hsp->matches('hit'),"\t",
    				#$hsp->matches('query'),"\t",
	    			#blast
    				#$result->query_length,"\t",
    				#$hit->length,"\t",
    				#$hsp->length('total'),"\t",
    				#$hsp->length('hit'),"\t",   #lenght of subject hitted - length of gap 
    				#$hsp->length('query'),"\t", #length of query hitted - length of gap
    				#$hsp->hsp_length,"\t",
    				$hsp->bits,"\t",
                    $hsp->evalue,"\t",
    				$hit->raw_score,"\t";
    				#$hsp->length('total'),"|",
    				#my $conserve = $hsp->num_conserved;
    				#my $length = $hit->length;
    				#"%.2f",$conserve/$length,"\t";
    				#$hsp->num_conserved,"\t",	#query與subject相同序列的長度
    				#($hsp->end('query')-$hsp->start('query'))/($hit->length)*100;
    				#$hsp->length('hit')/3,"\t",
    				#$hsp->length('query'),"|",
    				#$hsp->hsp_length,"|",
    				#$hit->length,"|",
    				#$hsp->num_conserved/($hsp->length('hit')/3)*100;
    				#$hsp->length('hit')/$result->query_length,"|";
    				#Percent ident
    				#"%.2f",$hsp->percent_identity,"\t";
    				#$hsp->percent_identity,"\t",
    			    #print OUT $hsp->rank,"\n";
    			    printf OUT "%.2f",$cov_q;
         			print OUT "\t";
         			printf OUT "%.2f",$cov_s;
        			print OUT "\t";
        			printf OUT "%.2f",$id;
        			print OUT "\t";
        			print OUT	
        			#printf  "%.2f",$cov;
        			#print  "\t";
        			#printf  "%.2f",$id;
        			#print  "\t";
        			$result->query_description,"\t",
        			#$result->query_accession,"\t",
    				$hit->description,"\t",
    				$flag, "\n";
                    }
                    $flag++;
    		    }
    	    }
#            $flag++;
        }
    }
close(OUT);
#system "sort -n -k 3 $output \> $output\_sort";
}
#my $filter_1 = $output.'_filtered_c80i80';
#my $filter_2 = $output.'_filtered_c90i60';
#my $filter_3 = $output.'_filtered_c40i30';
#system("cat $output | awk '\$13 >=80 && \$14 >=80 {print}' > $filter_1") == 0 or die "filtered failed\n";
#system("cat $output | awk '\$11 >=90 && \$12 >=60 {print}' > $filter_2") == 0 or die "filtered failed\n";
#system("cat $output | awk '\$11 >=40 && \$12 >=30 {print}' > $filter_3") == 0 or die "filtered failed\n";
