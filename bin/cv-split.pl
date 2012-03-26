#!/usr/bin/env perl

srand 7;

use strict;
use warnings;
use IO::File;

my $usage = "Usage: $0 name n\n";
my $name=shift @ARGV or die $usage;
my $n=shift @ARGV or die $usage;

# open splits
my %fh = ();
for(my $i=0; $i < $n ; $i++)
{
	$fh{$i} = (new IO::File "> $name.$i" or die $!);
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
