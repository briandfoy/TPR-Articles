use Video::Dumper::QuickTime;

my $file = Video::Dumper::QuickTime->new( 
	-filename => $ARGV[0], 
	);

eval { $file->Dump };
print "Error during processing: $@\n" if $@;

print $file->Result;