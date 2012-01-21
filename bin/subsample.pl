#!/usr/bin/perl

use strict;
use warnings;

my $p = shift @ARGV or die "Usage: $0 prob_accept\n";

my $seed = shift @ARGV;
$seed = (defined $seed) ? $seed : 7;
srand $seed;

while(my $line=<>)
{
		print $line if(rand() < $p); 
}
