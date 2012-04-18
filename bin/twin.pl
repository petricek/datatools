#!/usr/bin/env perl

use strict;
use warnings;

my $previus_uid=-1;
my @positives=();
my @negatives=();
my %seen = ();
our $keepall=0;

my $usage = "echo \"DV DV_UID|namespace feature\" | $0 [keepall]";

sub finalize_user($$)
{
	my ($positives, $negatives) = @_;


	# only if both +/- examples for this user
	if(0 < (scalar @$positives) * (scalar @$negatives))
	{
		foreach my $p (@$positives)
		{
			foreach my $n (@$negatives)
			{
				print "$p\n$n\n";
			}
		}

	}
	elsif($keepall == 1)
	{
		foreach my $e (@$positives, @$negatives)
		{
			print "$e\n";
		}
	}
	@$positives=();
	@$negatives=();

}

sub main()
{

	my $arg = shift @ARGV;
	if(defined $arg)
	{
		if($arg eq "keepall")
		{
			$keepall = 1;
		}
		else
		{
			print "$usage\n";
			exit();
		}
	}
	else
	{
		$keepall = 0;
	}

	my $previous_uid=-1;
	while(my $l =<>)
	{
		chomp $l;
		my ($dv, $_, $uid, $rest) = split(/ |_|\|/, $l, 4);
		#print "#uid=$uid\n";

		if(($uid ne $previous_uid) and ($uid ne "-1"))
		{
			finalize_user(\@positives, \@negatives);
		}	

		if($dv eq "1")
		{
			push @positives, $l;
		}
		else
		{
			push @negatives, $l;
		}
		$previous_uid = $uid;

	}

	finalize_user(\@positives, \@negatives);

}

main();
