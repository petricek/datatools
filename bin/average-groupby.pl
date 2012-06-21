#!/usr/bin/env perl

use strict;
use warnings;

my $var = shift @ARGV;
my $group = shift @ARGV;

my %cnt=();
my %sum=();

while(my $l=<>)
{
	chomp $l;
	my @f = split "\t", $l;
	
	$sum{$f[$group]} += $f[$var];
	$cnt{$f[$group]} ++;
}

foreach my $grp (keys %cnt)
{
	print (($sum{$grp} / $cnt{$grp}) . "\t" . $cnt{$grp} . "\t$grp\n");
}

