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

my $usage = "Usage $0 header re [re ...]\n";
my $headerfile = shift @ARGV || die $usage;
my $headerfh = new IO::File $headerfile, "r" or die $!;
my $index = 0;
my $headerline = <$headerfh>;
undef $headerfh;

chomp $headerline;
my @headers = split /,/, $headerline;
my %headers;

foreach my $header (@headers)
  { 
    $headers{$header} = $index unless exists $headers{$header};
    ++$index;
    die "bad header $header" if $header =~ /:\|\s/;
  }

  my @res = @ARGV;
  @ARGV=();

  my @fields = ();
  foreach my $re (@res)
  {
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

  print "TWOWAYCOMM" . "\t" . join "\t", @fields;
  print "\n";

while (defined ($_ = <>))
  {
    die $_ if $_ =~ /:\|/;

    chomp;
    my @line = split /\t/, $_;

	my @out = ();
	foreach my $f (@unique_fields)
	{
    	push @out, defined $line[$headers{$f}] ? $line[$headers{$f}] : "";
	}
    my $positive = defined $headers{TWOWAYCOMM_14D} ? $line[$headers{TWOWAYCOMM_14D}] : $line[$headers{TWOWAYCOMM}];

    print "$positive\t", join "\t", @out;
    print "\n";
  }

