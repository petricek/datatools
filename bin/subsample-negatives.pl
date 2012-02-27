#!/usr/bin/perl

use strict;
use warnings;

my $p = shift @ARGV or die "Usage: $0 prob_accept_negative\n";

#print "$p\n";

while(my $line=<>)
{
	if(($line =~ /^0/) or ($line =~ /^-1/))
	{
		print $line if(rand() < $p); 
	}
	else
	{
		print $line;
	}
}
