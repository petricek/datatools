#!/usr/bin/perl

srand 7;

use strict;
use warnings;
use IO::File;

my $usage = "Usage: $0 name field n\n";
my $name=shift @ARGV or die $usage;
my $fieldnum=shift @ARGV or die $usage;
my $n=shift @ARGV or die $usage;

# open splits
my %fh = ();
for(my $i=0; $i < $n ; $i++)
{
	$fh{$i} = (new IO::File "> $name.u$i" or die $!);
}

while(my $l=<>)
{
	my @fields = split(/\t/, $l);
	my $field = $fields[$fieldnum];
	chomp $field;
	
	my $r = ($field % $n);
	my $h = $fh{$r};
	print $h "$l";
}

# close splits
foreach my $h (keys %fh)
{
	close $fh{$h};
}
