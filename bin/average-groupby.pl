#!/usr/bin/env perl

use strict;
use warnings;

my $var = shift @ARGV;
my $group = shift @ARGV;
my $smooth = shift @ARGV if defined $ARGV[0];

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
	if($smooth)
	{
		print ((($sum{$grp} + (1*$smooth)) / ($cnt{$grp}+(2*$smooth))) . "\t" . $cnt{$grp} . "\t$grp\n");
	}
	else
	{
		print (($sum{$grp} / $cnt{$grp}) . "\t" . $cnt{$grp} . "\t$grp\n");
	}
}

