#!/usr/bin/perl
#
# assumes that the input is sorted and grouped by user
# TODO: make it not assume sorted by target and prediction
#
# Prediction Target UserId 
#

use strict;
use warnings;

use IPC::Open2;

$|=1;

our $verbose = 0;

sub compute_user_metric($$$)
{
	my ($positives, $negatives, $metric_name) = @_;
	
	return "NaN" if(0 == (scalar @$positives));
	return "NaN" if(0 == (scalar @$negatives));

        my $pid = open2(\*CHLD_OUT, \*CHLD_IN, "tee xxx | perf -$metric_name");
	foreach my $l (@$positives, @$negatives)
	{
		print CHLD_IN $l;
	}
	close CHLD_IN;

#	print "==\n";
	my $out = <CHLD_OUT>;
	close CHLD_OUT;
	waitpid $pid, 0;
	$out =~ /^[^\s]*\s*(.*)/;
	my $metric = $1;
#	print "$metric\n";
#	print "==\n";
	return $metric;
}

sub main()
{

	my $usage = "Expects: pred target user\n\nassumes that the input is sorted and grouped by user\n\n$0 metric [verbose]\n";
	my $metric_name = "undefined";
	while(my $arg = shift @ARGV)
	{
		if((defined $arg) and ($arg eq "verbose"))
		{
			$verbose = 1;
			next;
		}
		else
		{
			$metric_name = $arg;	
		}
	}
	die $usage if $metric_name eq "undefined";

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

#		print "### $user $previous_user\n";
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
