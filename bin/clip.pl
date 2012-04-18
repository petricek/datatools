#!/usr/bin/perl

use strict;
use warnings;

my $min = shift @ARGV;
my $max = shift @ARGV;
my $col = shift @ARGV;

$min = 0 if ! defined $min;
$max = 1 if ! defined $max;
$col = 1 if ! defined $col;

while(my $l=<>)
{
	chomp $l;
	my @F = split /\t/, $l;
	my $p = $F[$col];
	$p = ($p > $max) ? $max : $p;
	$p = ($p < $min) ? $min : $p;
	$F[$col] = $p;

	print join ("\t" , @F) . "\n";
}
