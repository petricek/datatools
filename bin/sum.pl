#!/usr/bin/env perl

use strict;
use warnings;

my $sum=0;
while(<>)
{
	$sum += $_;
}

print $sum;
