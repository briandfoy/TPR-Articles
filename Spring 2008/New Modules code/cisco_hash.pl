use Cisco::Hash qw(decrypt encrypt usage);

print encrypt( 'Buster', time % 53 ), "\n";

print decrypt( '00260615105E19' ), "\n";