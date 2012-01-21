#!/usr/bin/env perl

use strict;
use warnings;
use List::Util 'shuffle';

my @lines = ();
my $bufsize = shift @ARGV;
my $usage = "$0 nlines\n";
die $usage if(! defined $bufsize);
while(<STDIN>) {
    push @lines, $_;
    if (@lines == $bufsize) {
        print shuffle(@lines);
        undef @lines;
    }
}
print shuffle(@lines);

#-#
#-##! /usr/bin/perl
#-## randomize cat
#-#
#-## fisher_yates_shuffle code copied from Perl Cookbook 
#-## (By Tom Christiansen & Nathan Torkington; ISBN 1-56592-243-3)
#-#
#-#use strict;
#-#
#-#my @lines = <>;
#-#fisher_yates_shuffle( \@lines );    # permutes @array in place
#-#foreach my $line (@lines) {
#-#        print $line;
#-#}
#-#
#-## fisher_yates_shuffle( \@array ) : generate a random permutation
#-## of @array in place
#-#sub fisher_yates_shuffle {
#-#    my $array = shift;
#-#    my $i;
#-#    for ($i = @$array; --$i; ) {
#-#        my $j = int rand ($i+1);
#-#        next if $i == $j;
#-#        @$array[$i,$j] = @$array[$j,$i];
#-#    }
#-#}
#-#
#-#
