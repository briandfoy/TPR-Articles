use WWW::PAUSE::RecentUploads;
# Zoffix Znet, zoffix@cpan.org

my $pause = WWW::PAUSE::RecentUploads->new(
	login   => $ENV{CPAN_USER},
	pass    => $ENV{CPAN_PASS},
	);

my $data = $pause->get_recent
	or die "Failed to fetch data: " . $pause->error;

foreach my $dist ( @$data ) {
	printf " %-10s  %8d  %s\n",
		@$dist{qw( name size dist )};
	}