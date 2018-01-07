#!/usr/bin/perl

	my $f = sub { $_[0] ** 2 };
	my $g = sub { $_[0] + 1  };

	my $h = sub{ $f->( &$g ) };
	
print "f(5) is ", $f->(5), "\n";
print "g(5) is ", $g->(5), "\n";
print "h(5) is ", $h->(5), "\n";
