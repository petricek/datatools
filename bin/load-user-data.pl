#!/usr/bin/perl

use warnings;
use strict;
#use Devel::Size qw(total_size);

# Load and parse header
my $header=<>;
chomp $header;
my $c=0;
my %headers=();
foreach my $h (split('\t', $header))
{
	$headers{$h} = $c;
	$c++;
}


my %data=();
while(my $l=<>)
{
	chomp $l;
	my @line=split('\t',$l);
	foreach my $h (keys %headers)
	{
		$data{$line[$headers{USER_ID}]}{$h} = $line[$headers{$h}];
	}
}
#print total_size(\%data) . "\n";
