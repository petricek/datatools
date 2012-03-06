#!/usr/bin/perl

use strict;
use warnings;

my $usage="$0 {-f file.sql|-c 'select * from table'}\n";

die $usage if $#ARGV <= 0;

my $command = join " ",
                   "/usr/local/bin/nzsql -h " . $ENV{'NZ_HOST'} . " -A -F'|||' ",
                   (map { "'$_'" } @ARGV),
                   "| perl -ne 'print \$l if defined (\$l); s/\\t/\\\\t/g; s/\\|\\|\\|/\\t/g; \$l=\$_; } { print STDERR \$l if defined (\$l);'";
my $test_command = "/usr/local/bin/nzsql -h " . $ENV{'NZ_HOST'} . " -c 'select 1;' 2>&1 | grep -q failed ";

while(system($test_command) == -1)
{
	printf ".";
	sleep(15);
}


# run netezza and output clean data.

my $status = system ("$command");

if ($status == -1) 
  {
    print "\t\t$0 failed: $!\n";
    exit 1;
  }

exit 0;
