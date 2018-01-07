sub head { shift }
sub tail { shift; return @_ }
sub len  { scalar @_ }

sub fold(&@)
	{
	my( $f, @a ) = @_;                    
	return head( @a ) if len( tail( @a )  ) < 1;

	my ($a, $b) = ( head( @a ), head( tail( @a ) ) );
	
	fold( $f, ( $f->($a,$b), tail( tail( @a ) ) ) );
	}
	
	sub mult { $_[0] * $_[1] };
	
	my $result = fold { $_[0] * $_[1] } 1 .. 10;

print "result is $result\n";