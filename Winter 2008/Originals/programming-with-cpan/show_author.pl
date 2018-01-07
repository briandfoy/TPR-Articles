#!/usr/bin/perl
# show_author.pl

use CPAN;

CPAN::HandleConfig->load(
	be_silent => 1,
	);

CPAN::Index->reload;

foreach my $arg ( @ARGV )
	{
	my $module = CPAN::Shell->expand( 
		"Module", 
		$arg 
		);

	unless( $module )
		{
		print "Didn't find a $arg module, so no author!";
		next;
		}
		
	my $author = CPAN::Shell->expand( 
		"Author", 
		$module->userid 
		);

	unless( $module )
		{
		print "Didn't get an author for $module!";
		next;
		}

	printf "%-25s %-8s %-25s %s\n", 
		$arg, $module->userid, 
		$author->email, $author->fullname;
	}

