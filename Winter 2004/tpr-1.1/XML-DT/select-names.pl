	#!/usr/bin/perl
	use XML::DT ;
	
	my $filename = shift;
	
	%handler=(
		'address' => sub { $c },
		'book'    => sub { $c },
		'name'    => sub { $c },
		-default  => sub { "" },
		);
	
	print dt( $filename, %handler);
