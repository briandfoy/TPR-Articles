#!/usr/local/bin/perl

use bignum;
use List::Util qw(reduce);

print factorial( $ARGV[0] ), "\n";

sub factorial {
	my $v = shift;
	my $product = 1;
	foreach my $n ( 2 .. $v ) {  $product *= $n }
	$product;
	}
