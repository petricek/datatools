#!/usr/bin/perl

$|=1;

use strict;
use warnings;
use Data::Dumper;

my %lines = ();

my $mode;
$mode = shift @ARGV or $mode = "uniq";

while(<>)
{
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

