#!/usr/bin/perl

use strict;

my $blocksize=3;
my $gridsize=$blocksize*$blocksize;

my $zeroflags=[0,0,0,0,0,0,0,0,0,0];

my ($failedrow, $failedcol, $failedblock)=(1,2,3);

sub printgrid {
  for (my $row=0; $row<$gridsize; $row++) {
    for (my $col=0; $col<$gridsize; $col++) {
      my $value=$grid[$row][$col];
      
      if ($value) {print "$value";} else {print ".";}
      if (!(($col+1) % 3)) {print " ";}
    }

    if (!(($row+1) % 3)) {print "\n";} print "\n";
  }
}

sub nextcell
{
  my $maxhits=0; my @maxcell=(0,0);

  for (my $row=0; $row<$gridsize; $row++) {
    for (my $col=0; $col<$gridsize; $col++) {

      if ($grid[$row][$col]) {next;}

      my $blockrow=$row-($row % $blocksize);
      my $blockcol=$col-($col % $blocksize);
  
      my $hits=0;
      for (my $i=0; $i<$blocksize; $i++) {
        for (my $j=0; $j<$blocksize; $j++) {
          my $pos=$i*$blocksize+$j;

          if ($grid[$pos][$col]) {$hits++;}
      
          if ($grid[$row][$pos]) {$hits++;}

          if ($grid[$blockrow+$i][$blockcol+$j]) {$hits++;}
        }
      }

      if ($hits > $maxhits) {$maxhits=$hits; @maxcell=($row,$col);}
    }
  }

  if ($maxhits == 0) {
    print "A solution to this puzzle is\n\n";
    printgrid();
    exit;
  }

  return @maxcell;
}

sub testcell
{
  my ($row, $col) = @_;
  my @rowflags=my @colflags=my @blockflags=$zeroflags;

  my $blockrow=$row-($row % $blocksize);
  my $blockcol=$col-($col % $blocksize);
  
  for (my $i=0; $i<$blocksize; $i++) {
    for (my $j=0; $j<$blocksize; $j++) {
      my $pos=$i*$blocksize+$j;

      my $value=$grid[$pos][$col];
      if ($value) {
        if ($colflags[$value]) {return $failedrow};
        $colflags[$value]=1;
      }
      
      $value=$grid[$row][$pos];
      if ($value) {
        if ($rowflags[$value]) {return $failedcol};
        $rowflags[$value]=1;
      }

      $value=$grid[$blockrow+$i][$blockcol+$j];
      if ($value) {
        if ($blockflags[$value]) {return $failedblock};
        $blockflags[$value]=1;
      }
    }
  }

  return 0;
}

sub solve {
  my ($row,$col)=nextcell;

  for (my $value=1; $value<$gridsize+1; $value++) {
    $grid[$row][$col]=$value;

    if (testcell($row,$col) == 0) {
      solve();
    }
  }

  $grid[$row][$col]=0;
}

