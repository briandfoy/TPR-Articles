#!/usr/bin/perl
use XML::DT ;
my $filename = shift;
%handler=(
   '-outputenc' => 'ISO-8859-1',
   '-default'   => sub{""},
   'title'      => sub{"<b>$c</b>"},
   'author'     => sub{"  <i>$c</i>"},
   'article'    => sub{"$c<br>"}
 );
print dt($filename,%handler);
