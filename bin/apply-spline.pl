#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;
use POSIX qw(ceil floor);

my $usage = "Usage: zcat tpfile.gz | $0 splinefile [min max]\n";
my $splinefile = shift @ARGV or die $usage;
my $min = shift @ARGV; 
my $max = shift @ARGV;

$max = defined $max ? $max : 1;
$min = defined $min ? $min : 0;

my %spline = ();

sub main()
{

#------------------------------------------------------------
# load spline
#------------------------------------------------------------
	open(S, $splinefile) or die "Cannot open $splinefile: $!\n";
	while(my $l=<S>)
	{
		chomp $l;
		my ($score, $prob) = split('\s|\t', $l);
		$spline{$score}=$prob;

	}
	close S;

	$spline{'-0.00'}=$spline{'0.00'};

#	print "SPLINE\n";
#	print Dumper(\%spline);
#	print "END SPLINE\n";

#------------------------------------------------------------
# calibrate
#------------------------------------------------------------
	while(my $l=<>)
	{
		chomp $l;
		my @fields = split(/\s|\t/, $l);
		if(scalar @fields == 3)
		{
			my($truth, $pred, $label) = @fields;
			my $cal_pred = calibrate($pred, \%spline);
			print "$truth\t" . sprintf("%.6f", $cal_pred) . " $label\n";
		}
		elsif(scalar @fields == 2)
		{
			my($truth, $pred) = @fields;
			my $cal_pred = calibrate($pred, \%spline);
			print "$truth\t" . sprintf("%.6f", $cal_pred) . "\n";
		}
		elsif(scalar @fields == 1)
		{

			my $pred = $l;
			my $cal_pred = calibrate($pred, \%spline);
			printf("%.6f\n", $cal_pred);
		}
		else
		{
			die "unknown format:" . scalar @fields;
		}


	}
}

sub calibrate($$)
{
	my ($score, $spline) = @_;

	my $cal_pred = 0.0001;
	if($score >= $max)
	{
		$score = $max;
	}
	if($score <= $min)
	{
		$score = $min;
	}

	my $l = sprintf("%.2f", 0.05 * floor($score / 0.05));
	my $u = sprintf("%.2f", 0.05 * ceil($score / 0.05));
	if($l == $u)
	{
		$cal_pred = $spline{$l};
		#print "#$cal_pred at $l\n";
	}
	else
	{

		my $ld = $score - $l;
		my $ud = $u - $score;

		my $d = $ld + $ud;

		my $lv = $spline{sprintf("%.2f",$l)};
		my $uv = $spline{sprintf("%.2f",$u)};

#			print "# score=$score l=$l u=$u ld=$ld ud=$ud lv=$lv uv=$uv\n" if ($d == 0);
		my $lw = $ud / $d;
		my $uw = $ld / $d;

#			print "# score=$score l=$l u=$u ld=$ld ud=$ud lv=$lv uv=$uv lw=$lw uw=$uw\n";
		$cal_pred = $lv * $lw + $spline{$u} * $uw; 
	}

	return $cal_pred;

}

main();
