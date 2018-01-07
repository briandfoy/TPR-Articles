#!/usr/bin/perl

use CPAN;
use Data::Dumper;

CPAN::HandleConfig->load(
	be_silent => 1
	);

my $dd = Data::Dumper->new( 
	[$CPAN::Config], 
	['$CPAN::Config'] 
	);

print $dd->Dump, "\n1;\n__END__\n";
