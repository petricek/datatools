#!/usr/bin/env perl

use strict;
use warnings;

my $usage = "$0 sep mat > tr_mat\n";
my $sep = shift @ARGV or die $usage;

my @tr=();
my $rc = 0;
while(my $l=<>)
{
	chomp $l;
	my $cc = 0;
	foreach my $f (split($sep, $l))
	{
		$tr[$cc][$rc] = $f;
		$cc++;
	}
	$rc++;
}

foreach my $col (@tr)
{
	print join($sep, @$col) . "\n";
}

