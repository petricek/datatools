#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
use Getopt::Long;
use Pod::Usage;

my $man = 0;
my $help = 0;
my $hsep = "\t";
my $dsep = "\t";
my $osep = "\t";
my $hfield = 0;
my $dfield = 0;
my $hfile = undef;
my $result = GetOptions ("hsep=s" => \$hsep,
                        "dsep=s"   => \$dsep,
                        "osep=s"   => \$osep,
                        "hfield=i"   => \$hfield,
                        "dfield=i"   => \$dfield,
                        "hfile=s"   => \$hfile,
                        'help|?' => \$help,
                        man => \$man
                      ) or pod2usage(2);
pod2usage(1) if $help;
pod2usage(-exitstatus => 0, -verbose => 2) if $man;
pod2usage(-exitstatus => 0, -verbose => 2) if (!defined $hfile);



my %hash = ();
open(H, $hfile);
while(my $l=<H>)
{
	chomp $l;
	my @f = split($hsep, $l);
	my $key = $f[$hfield];
	$hash{$key} = $l;
}

print STDERR "hfile $hfile loaded\n";
print STDERR Dumper(\%hash);

while(my $l=<>)
{
	chomp $l;
	my @f = split($dsep, $l);
	my $key = $f[$dfield];
	my $dataline = ((defined $key) and (exists $hash{$key})) ? $hash{$key} : "MISSING";
	print $l . $osep . $dataline . "\n";
}



__END__

=head1 NAME

B<hashjoin.pl> - Hash join a file to another one.

=head1 SYNOPSIS

hashjoin.pl [options] --hfile file [file ...]

=head1 OPTIONS

=over 8

=item B<--hfile> 

file to load into hash for joining

=item B<--help>

Print a brief help message and exits.

=item B<--man>

Prints the manual page and exits.

=item B<--hsep>

hash file field separator

=item B<--dsep>

data file(s) field separator

=item B<--osep>

output separator

=item B<--man>

full documentation

=item B<--help>

full documentation

=item B<--hfield>

hash file field number to join on (0 ~ fist)

=item B<--dfield>

data file field number to join on (0 ~ fist)

=back

=head1 DESCRIPTION

B<This program> will read the given input file(s) and join them together on the
field specified by loading the hashfile into a ahsh table in RAM.

=cut

