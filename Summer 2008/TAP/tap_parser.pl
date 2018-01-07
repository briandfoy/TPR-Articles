#!/usr/bin/perl -w

# Name:          tap_parser.pl
# Purpose:       A test scheduler and runner

use strict;
use TAP::Parser qw/all/;
use TAP::Parser::Aggregator qw/all/;

open my $out_file, ">", "/home/jeremiah/TAP_report.txt"
or die "Cannot open outfile. $!\n";
printf $out_file "\nReport %s\n---\n", `date +"%D"`;

my @files = qw[
	/home/jeremiah/code/shell/uptime.sh
	/home/jeremiah/code/perl/get_os.pl
	];

foreach my $file (@files) {
	my $parser = TAP::Parser->new( { source => $file } );
	print $out_file "$file results:\n---\n";
	
	while ( my $result = $parser->next ) {
		my $out = $result->as_string;
		print $out_file "$out\n";
		}
	
	my $aggregate = TAP::Parser::Aggregator->new;
	$aggregate->add( 'testcases', $parser );
	printf $out_file "\n\tPassed: %s\n\tFailed: %s\n\n", 
					scalar $aggregate->passed, scalar $aggregate->failed;
	}

1;