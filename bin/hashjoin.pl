#!/usr/bin/env perl

use strict;
use warnings;

my $usage = "$0 hashfield hashfile datafield datafile(s)\n";

die $usage if $#ARGV < 3;

my $hashfield = shift @ARGV;
my $hashfile = shift @ARGV;
my $datafield = shift @ARGV;

my %hash = ();
open(H, $hashfile);
while(my $l=<H>)
{
	chomp $l;
	my @f = split("\t", $l);
	my $key = $f[$hashfield];
	$hash{$key} = $l;
}

print STDERR "hashfile loaded\n";

while(my $l=<>)
{
	chomp $l;
	my @f = split("\t", $l);
	my $key = $f[$datafield];
	my $dataline = ((defined $key) and (exists $hash{$key})) ? $hash{$key} : "MISSING";
	print $l . "\t" . $dataline . "\n";
}



