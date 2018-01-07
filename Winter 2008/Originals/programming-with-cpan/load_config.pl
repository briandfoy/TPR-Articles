#!/usr/bin/perl

use CPAN;
use Data::Dumper;

die "Could not find file [$ARGV[0]]\n" 
	unless -e $ARGV[0];

{
# don't search any Perl directories
# but look in the current directory if it's
# a relative path
local @INC = qw(.);
do $ARGV[0];
die "Could not read $ARGV[0]! [$!]"    if $!;
die "Could not compile $ARGV[0]! [$@]" if $@;
}

# fake out CPAN::HandleConfig::require_myconfig_or_config
# I'll need this later
$INC{'CPAN/MyConfig.pm'} = $file;
$INC{'CPAN/Config.pm'} = 1;

foreach my $mirror ( @{ $CPAN::Config->{urllist} } )
	{
	print "$mirror\n";
	}
