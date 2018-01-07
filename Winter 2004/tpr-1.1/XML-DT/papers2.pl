#!/usr/bin/perl
use XML::DT;

my $filename = shift;
print "filename is $filename\n";

%p_proc=(
   '-default'    => sub{"$c"},
   'proceedings' => sub{"Proceedings $c"},
   'abstract'    => sub{""},
   'article'     => sub{ dt($v{file}, %p_art) },
   'chair'       => sub{"Chair: $c"},
);

%p_art=(
  '-default'     => sub{""},
   'title'       => sub{"  $c"},
   'author'      => sub{"    <i>$c</i>"},
   'article'     => sub{"$c"},
);

print dt( $filename, %p_proc );
