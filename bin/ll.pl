#!/usr/bin/perl

use strict;
use warnings;

my $fp_sum = 0;
my $fp = 0;
my $tp_sum = 0;
my $tp = 0;
sub main()
{
        while(my $line=<>)
        {
                chomp $line;

                my ($t, $pred) = split(/\t/,$line,2);
		next if(($pred <= 0) or ($pred >=1));

                if($t == 0)
                {
                        # will fail if $pred == 1
                        if($pred == 1)
                        {
                                print "LL impossible pred:$pred outcome:$t\n";
                                exit;
                        }
                        $fp_sum += log(1-$pred);
                        $fp++;
                }
                elsif($t == 1)
                {
                        if($pred == 0)
                        {
                                print "LL impossible pred:$pred outcome:$t\n";
                                exit;
                        }
                        $tp_sum += log($pred);
                        $tp++;
                }
                else
                {
                        warn "class not 0 or 1: $t\n";
                }

        }



        my $ll =  $tp_sum + $fp_sum;
        #print "LL\t$ll (" . ($tp+$fp) . " +:$tp/-:$fp)\n";
        print "lloss\t" . (- $ll / ($tp+$fp)) . "\n";
        #print "tp_sum = $tp_sum\n";
        #print "fp_sum = $fp_sum\n";
}

main();
