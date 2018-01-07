use Weather::Google;
# Daniel LeWarne, possum
my $gw = Weather::Google->new( $ARGV[0] ); 

print  "Fetching weather for $ARGV[0]\n\n";

print  "   Day   |   High   Low\n";
print  "---------+--------------\n";

foreach my $day ( 0 .. 4 )
	{
	my $hash = $gw->forecast_conditions( $day );
 	last unless defined $hash->{high};

	printf " % 5s   |   %3d    %3d\n", 
		$hash->{day_of_week}, 
		$hash->{high}, 
		$hash->{low};
	}
