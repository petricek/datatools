#!/usr/bin/env perl

use strict;
use warnings;
use IO::Zlib;

my $usage="zcat file.zg | $0 name column\n";
my $name = shift @ARGV or die $usage;
my $col = shift @ARGV or die $usage;

# open splits
my %fh = ();

my $c = 0;
while(my $l=<>)
{
	chomp $l;
	my @fields = split('\t', $l);
	my $val = $fields[$col - 1];
	my $h = undef;
	if(!exists $fh{$val})
	{
		print STDERR "opening $val\n";
		my $fh = new IO::Zlib;
		$fh->open("$val-$name.gz", 'w') || die "can't open $val-$name.gz";

		$fh{$val} = $fh;
	}
	$h = $fh{$val};
	print $h "$l\n";
	$c++;
}

