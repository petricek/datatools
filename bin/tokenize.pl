#!/usr/bin/env perl

use strict;
use warnings;

sub tokenize ($)
{
  my ($a)  = @_;

return map { $_ = lc $_; s/'$//; s/^'//; $_ }
split /[^\w']+/, $a;

}

while(<>)
{
	print join " ", tokenize($_);
        print "\n";
}
