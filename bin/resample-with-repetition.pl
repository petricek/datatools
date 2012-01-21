#!/usr/bin/perl

my $seed = shift @ARGV ;
my $perc = shift @ARGV;
die "Usage $0 seed [percent]" if ! defined $seed;
srand($seed);

my @lines = ();
while(my $line=<>)
{
	push @lines, $line;
}

my $n = scalar @lines;
$n = $n * $perc if(defined $perc);

for(my $i=0;$i<$n;$i++)
{
	my $r = int((rand() * $n) + 0.5);
	print $lines[$r];
}
