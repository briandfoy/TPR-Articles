#!/usr/bin/perl
use XML::DT ;
my $filename = shift;

%handler=(
#    '-outputenc' => 'ISO-8859-1',
#    '-default'   => sub{"<$q>$c</$q>"},
     'address' => sub{
       # occurred 2 times
       "$q:$c"
     },
     'book' => sub{
       # occurred 1 times
       "$q:$c"
     },
     'city' => sub{
       # occurred 2 times
       "$q:$c"
     },
     'country' => sub{
       # occurred 2 times
       "$q:$c"
     },
     'email' => sub{
       # occurred 2 times
       "$q:$c"
     },
     'name' => sub{
       # occurred 2 times
       "$q:$c"
     },
);
print dt($filename,%handler);
