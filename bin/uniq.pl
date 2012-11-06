#!/usr/bin/perl

$|=1;

use strict;
use warnings;
use Data::Dumper;

my %lines = ();

my $mode;
$mode = shift @ARGV or $mode = "uniq";

my $total = 0;
while(<>)
{
        $total++;
	chomp;
	if(exists $lines{$_})
	{
		$lines{$_}++;
		next;
	}
	else
	{

		if($mode eq "uniq")
		{
			print "$_\n";
		}
	}
	$lines{$_}++;
}

if($mode eq "counts")
{
	foreach my $k (reverse sort {$lines{$a} <=> $lines{$b}} keys %lines)
	{
		print "$lines{$k}\t$k\n";
	}
}

if($mode eq "percent")
{
	foreach my $k (reverse sort {$lines{$a} <=> $lines{$b}} keys %lines)
	{
		printf "%.1f\t%d\n", ((100 * $lines{$k}) / $total), $k;
	}
}

