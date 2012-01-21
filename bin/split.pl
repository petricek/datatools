#!/usr/bin/perl

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

while(my $l=<>)
{
	my $r = int($n * rand());
	my $h = $fh{$r};
	print $h "$l";
}

# close splits
foreach my $h (keys %fh)
{
	close $fh{$h};
}
