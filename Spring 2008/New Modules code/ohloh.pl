use WWW::Ohloh::API;

my $ohloh = WWW::Ohloh::API->new( 
	api_key => $ENV{OHLOH_KEY}
	);

my $account = $ohloh->get_account( 
	id => $ARGV[0] 
	);

print $account->as_xml;