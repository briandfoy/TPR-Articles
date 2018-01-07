#!/usr/bin/perl

use Expect;

my $user  = $ARGV[0] || "joe";
my $host  = $ARGV[1] || "www.example.com";

my $expect = Expect->new;

$expect->debug(0);
$expect->exp_internal( 1 ); 
$expect->log_file( "$host.log" ); 

my $login = "/usr/bin/ssh $user\@$host";
$expect->spawn($login) or 
	die "Can't login to $host as $user, error is> $!\n";

$expect->send("uptime\n");

$expect->expect(5, "-re", "up (.*), \d+ users");

print +($expect->matchlist )[0], "\n";