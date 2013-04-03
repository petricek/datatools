#!/usr/bin/perl

use strict;
use warnings;

my %lines = ();

my $mode;
$mode = shift @ARGV or $mode = "uniq";

my $total = 0;
while(<>)
{
        $total++;
        $lines{$_}++;
	next if($lines{$_}>1);
        print $_ if($mode eq "uniq");
}

if($mode eq "counts")
{
	foreach my $k (reverse sort {$lines{$a} <=> $lines{$b}} keys %lines)
	{
		print "$lines{$k}\t$k";
	}
}

if($mode eq "percent")
{
	foreach my $k (reverse sort {$lines{$a} <=> $lines{$b}} keys %lines)
	{
		printf "%.1f\t%s", ((100 * $lines{$k}) / $total), $k;
	}
}

