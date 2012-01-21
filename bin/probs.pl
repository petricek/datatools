#!/usr/bin/env perl

use strict;
use warnings;

my $usage="Usage: zcat *.tp.gz | $0 [bin]  > file.probs";

my $bin = shift @ARGV;
$bin = defined $bin ? $bin : 200;

my %matches=();
my %comms=();
my %scores=();

# read tp pred and 
while(my $l=<>)
{
	chomp $l;
	my @F = split (/\s|\t/, $l);

	my $comm = $F[0];
	my $score = $F[1];
	my $binnedscore=int($bin*$score)/$bin;

	++$matches{$binnedscore};
	++$comms{$binnedscore} if ($comm eq "1");
	$scores{$binnedscore} += $score;

}
foreach my $p (sort { $a <=> $b } keys %matches) 
{
	my $binnedscore = $p+0.5/$bin;
	my $mean_score_in_bin = sprintf("%.4f", $scores{$p} / $matches{$p});
	$comms{$p}+=0;
	my $e=$comms{$p}/$matches{$p};
	my $empiricalcomm = sprintf("%.8f",$e);
	my $sd = sprintf("%.8f",sqrt($e*(1-$e)/$matches{$p}));
	print "" . join "\t", $mean_score_in_bin, $empiricalcomm, $sd, $matches{$p}, $comms{$p};
	print "\n";
}
