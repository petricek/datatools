#! /usr/bin/env perl

use warnings;
use strict;

use IO::File;
use Time::Local;
use Digest::MD5;
use POSIX qw(ceil tanh);

#---------------------------------------------------------------------
#                                mainz                                
#---------------------------------------------------------------------

my $usage = "Usage $0 <headerfile|-> headeron|headeroff re [re ...]\n";
my $headerfile = shift @ARGV || die $usage;
my $headeron = shift @ARGV || die $usage;
my @res = @ARGV;
@ARGV=();
my $headerline;
if($headerfile eq "-")
{
	$headerline=<>;
}
else
{
	my $headerfh = new IO::File $headerfile, "r" or die "Can't open $headerfile: $!\n";
	$headerline = <$headerfh>;
	undef $headerfh;
}
my $index = 0;
my $cond=1;

chomp $headerline;
my @headers = split /,|\t/, $headerline;
my %headers;

foreach my $header (@headers)
{ 
	$headers{$header} = $index unless exists $headers{$header};
	++$index;
	die "bad header $header" if $header =~ /:\|\s/;
}


my @fields = ();
foreach my $re (@res)
{
	if($re =~ /^~/)
	{
		$re =~ s/^~//;
		$cond=$re;
	} 
	if($re =~ /^-/)
	{
		$re =~ s/^\-//;
		push @fields, grep {!/$re/} @headers;
	} 
	else
	{
		push @fields, grep {/$re/} @headers;
	}
}
# keep just each field just once
my @unique_fields = ();
my %seen = ();
foreach my $f (@fields) {
	push(@unique_fields, $f) unless $seen{$f}++;
}

if($headeron eq "headeron")
{
	print join "\t", @unique_fields;
	print "\n";
}

while (defined ($_ = <>))
{
	die $_ if $_ =~ /:\|/;

	chomp;
	my @line = split /,|\t/, $_;

	next unless eval $cond;

	my @out = ();
	foreach my $f (@unique_fields)
	{
		push @out, defined $line[$headers{$f}] ? $line[$headers{$f}] : "";
	}

	print join "\t", @out;
	print "\n";
}

