#!/usr/bin/perl

use strict;
use warnings;

my %lines = ();

while(<>)
{
	$lines{$_} = 1;
}

print join "", (sort keys %lines);
