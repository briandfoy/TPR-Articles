#!/usr/bin/perl
use XML::DT ;
my $filename = shift;

  %handler = ( -default => sub{ toxml },
              email    => sub{ $v{uri} = $c; undef $c; toxml },
            );
            
            
print dt($filename,%handler);
