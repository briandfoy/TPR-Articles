#!/usr/bin/perl
use XML::DT ;
my $filename = shift;

%handler = ( name    => sub{ $q="td"; toxml },
		  city    => sub{ $q="td"; toxml },
		  country => sub{ $q="td"; toxml },
		  email   => sub{ $q="td"; toxml },
		  address => sub{ $q="tr"; toxml },
		  book    => sub{ $q="table"; toxml },
		);

print dt($filename,%handler);
