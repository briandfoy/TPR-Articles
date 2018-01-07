#!/usr/bin/perl

use Test::More tests => 2;
use Test::Timer;

time_atmost(  
	sub { 1; },        # less than two seconds
	2, 
	'Passing test' 
	);

time_atmost( 
	sub { sleep 4; },  # more than two seconds
	2, 
	'Failing test' 
	);
