#!/usr/bin/perl

use CPAN;
use Data::Dumper;

CPAN::HandleConfig->load(
	be_silent => 1
	);

print Dumper( $CPAN::Config );
