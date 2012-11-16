#!/usr/bin/perl

use strict;
use warnings;

my $p = shift @ARGV or die "Usage: $0 prob_accept seed invert\n";

my $seed = shift @ARGV;
$seed = (defined $seed) ? $seed : 7;
srand $seed;

my $invertResults = shift @ARGV;
$invertResults = (defined $invertResults) ? $invertResults : 0;

while(my $line=<>)
{
	if($invertResults){
		print $line if(rand() >= $p)
	}else{
		print $line if(rand() < $p); 
	}
}
