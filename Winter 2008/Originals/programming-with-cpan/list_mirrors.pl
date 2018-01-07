#!/usr/bin/perl

use CPAN;
use Data::Dumper;

CPAN::HandleConfig->load(
	be_silent => 1
	);

foreach my $mirror ( @{ $CPAN::Config->{urllist} } )
	{
	print "$mirror\n";
	}
