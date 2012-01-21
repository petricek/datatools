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

my $usage = "Usage: zcat data.gz | $0 header.txt col1 col2 ... > cols.txt\n"; 
my $headerfile = shift @ARGV or die $usage;
my $headerfh = new IO::File $headerfile, "r" or die "$!: $usage";
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

  my @fields = @ARGV;
  @ARGV=();

while (defined ($_ = <>))
  {
    die $_ if $_ =~ /:\|/;

    chomp;
    my @line = split /\t/, $_;

	my @out = ();
	foreach my $f (@fields)
	{
    	push @out, defined $line[$headers{$f}] ? $line[$headers{$f}] : "";
	}
    my $positive = defined $headers{TWOWAYCOMM_14D} ? $line[$headers{TWOWAYCOMM_14D}] : $line[$headers{TWOWAYCOMM}];

    print "$positive\t", join "\t", @out;
    print "\n";
  }

