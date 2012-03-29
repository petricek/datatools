#!/usr/bin/perl
#
# assumes that the input is sorted and grouped by user
# TODO: change not to assume sorted input by target and prediction
#
# Prediction Target UserId 
#

use strict;
use warnings;

use IPC::Open2;

#$|=1;

our $verbose = 0;

sub compute_user_metric($$$)
{
	my ($positives, $negatives, $metric_name) = @_;
	
	return "NaN" if(0 == (scalar @$positives));
	return "NaN" if(0 == (scalar @$negatives));

        my $pid = open2(\*CHLD_OUT, \*CHLD_IN, "perf -$metric_name");
	foreach my $l (@$positives, @$negatives)
	{
		print CHLD_IN $l;
	}
	close CHLD_IN;

	my $out = <CHLD_OUT>;
	close CHLD_OUT;
	waitpid $pid, 0;

	$out =~ /^[^\s]*\s*(.*)/;
	my $metric = $1;

	return $metric;
}

sub main()
{

	my $usage = "Expects: pred target user
assumes that the input is sorted and grouped by user

Usage: $0 metric [verbose]

";
	my $metric_name = shift @ARGV or die $usage;
	if((defined $ARGV[0]) and ($ARGV[0] eq "verbose"))
	{
		$verbose = 1;
		shift;
	}

        my $previous_user = -1;
        my $n_all_users = 0;
        my $n_ok_users = 0;
        my $sum_ok_metric = 0;

	my @positives=();
	my @negatives=();

        while(my $line=<>)
        {
                chomp $line;

                my ($pred, $t, $user) = split(/\s|_/,$line,-1);

		if(($user != $previous_user) and ($previous_user != -1))
		{
			my $metric = compute_user_metric(\@positives, \@negatives, $metric_name);
			@positives = ();
			@negatives = ();
			if($metric ne "NaN")
			{
				$n_ok_users++;
				$sum_ok_metric += $metric;
			}
			$n_all_users++;
			print "$metric\tuser $metric_name\n" if($verbose);
		}
		$previous_user = $user;
		push @positives, "$t $pred\n" if($t == 1);
		push @negatives, "$t $pred\n" if($t != 1);

        }
	my $metric = compute_user_metric(\@positives, \@negatives, $metric_name);
	if($metric ne "NaN")
	{
		$n_ok_users++;
		$sum_ok_metric += $metric;
	}
	$n_all_users++;
	print "$metric\tuser $metric_name\n" if($verbose);

        printf("%f\tu$metric_name Mean $metric_name over %d users with both +/- examples out of %d\n", ($sum_ok_metric / $n_ok_users), $n_ok_users, $n_all_users);

}

main();
