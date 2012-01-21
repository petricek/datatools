#!/usr/bin/env perl

use strict;
use warnings;

my $usage = "$0 n [sep]\n";

my $n = shift @ARGV or die $usage;
my $sep ;
$sep = shift @ARGV or $sep = '	';

my $count=0;
my $cpadded=0;
while(my $line=<>)
{
	chomp $line;
	my @fields = split(/$sep/, $line, -1);
	my $diff = $n - scalar(@fields);
	if($diff < 0)
	{
		die "more fields than expected (diff = $diff) in:\n$line\n";
	}
	print $line . ($sep x $diff) . "\n";
	$count++;
	$cpadded++ if $diff > 0;
}

warn "Padded: $cpadded of $count\n";
