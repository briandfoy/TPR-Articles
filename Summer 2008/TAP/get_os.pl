#!/usr/bin/perl -w

# Name:             get_os.pl
# Purpose:          Demonstrate TAP

use strict;
use Test::More tests => 3;

require_ok( 'Test::File' );
ok($^O eq 'linux', 'Operating system is correct');