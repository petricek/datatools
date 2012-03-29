#!/usr/bin/env perl

srand 7;

use strict;
use warnings;
use IO::File;
use IO::Zlib;

my $usage = "Usage: $0 name n [compress]\n";
my $name=shift @ARGV or die $usage;
my $n=shift @ARGV or die $usage;
my $compress=shift @ARGV;

# open splits
my %fh = ();
for(my $i=0; $i < $n ; $i++)
{
	if(defined $compress)
	{
		$fh{$i} = (new IO::Zlib "$name.$i.gz", "w") or die $!;
	}
	else
	{
		$fh{$i} = (new IO::File "> $name.$i" or die $!);
	}
}

my $c = 0;
while(my $l=<>)
{
	my $r = ($c % $n);
	my $h = $fh{$r};
	print $h "$l";
	$c++;
}

# close splits
foreach my $h (keys %fh)
{
	close $fh{$h};
}
