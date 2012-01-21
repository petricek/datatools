#!/usr/bin/perl

use strict;
use warnings;

my $v=0;
my $sep = "\t";
while(my $arg = shift @ARGV)
{
	if( 'verbose' eq  $arg)
	{
		$v = 1;
	}
	else
	{
		$sep = $arg;
	}
}

my $oldn = -1;
while(my $line = <>)
{
	my @fields = split(/$sep/, "$line", -1);
	my $n = scalar @fields;
	print "$n\n";
	if($v)
	{
		print $line if($n != $oldn);
	}
	$oldn = $n;
}
