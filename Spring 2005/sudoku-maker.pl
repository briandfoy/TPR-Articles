#!/usr/bin/perl

############################################################
##   INIT                                                 ##
############################################################

use strict;
use warnings;
use List::Util qw{ shuffle };

# constants
our $COLCNT    = 4 * 9**2;    # number of columns in cover
our $ROWCNT    = 9**3;        # number of rows in cover

# bitvecs for full and empty rows and cols
our $ZEROCOL   = pack( 'b*', "0" x $COLCNT );
our $ZEROROW   = pack( 'b*', "0" x $ROWCNT );
our $FULLCOL   = pack( 'b*', "1" x $COLCNT );
our $FULLROW   = pack( 'b*', "1" x $ROWCNT );


############################################################
##   MAIN                                                 ##
############################################################

# create the cover puzzle, and an initial path stash
my $puzzle = make_puzzle();
my $pstash = make_path_stash( $puzzle );

# find a completed Sudoku puzzle
my @solutions = solve_cover( $puzzle, $pstash, 1 );
my $solset    = pop @solutions;

print "\nComplete puzzle:\n";
pprint_puzzle( @$solset );

# find -a- minimal puzzle with that set
my @sol = find_minimal( @$solset );

print "\nMinimal puzzle:\n";
pprint_puzzle( @sol );

# for fun, re-solve the puzzle
print "\nRe-solved:\n";

my $nstash    = make_path_stash( $puzzle, @sol );
my @re_solved = solve_cover( $puzzle, $nstash, 1 );

pprint_puzzle( @{ $re_solved[0] } );


############################################################
##   FUNCTIONS                                            ##
############################################################


############################################################
# solve_cover() - given an initial path stash, solve puzzle

sub solve_cover
{
  my ( $puzref, $iloc, $tofind ) = @_;
  $tofind      ||= 1;

  # initialize as much as possible here,
  # to avoid allocing during tightloop
  my @stack      = ( $iloc );   # 'recurse' agenda
  my @liverows   = ();          # don't allocated any arrays in
  my @pivrows    = ();          # loop - expensive.
  my @solutions  = ();          # solutions found
  my $curpaths   = 0;           # counter for paths (stats only)
  my @puz        = @$puzref;

  RECURSE:
  while ( 1 )
  {
     # basecase 1:
     my $rloc = pop @stack or last RECURSE;

     if ( $rloc->{livecol} eq $ZEROCOL )
     {
        my @setlist = grep { vec $rloc->{solset}, $_, 1 } 0.. ( $ROWCNT - 1 );
        push @solutions, \@setlist;

        # basecase 2 - we satisfy our solution agenda
        last RECURSE if ( scalar( @solutions ) >= $tofind );
        next RECURSE;
     }

     # enumerate active rows
     my $cand = ( ~ $rloc->{removed} );
     @liverows = ();
     vec( $cand, $_, 1 ) && push( @liverows, $_ )
        for 0 .. ( $ROWCNT - 1 );

     # basecase 3:
     my $colcheck = $ZEROCOL;
     $colcheck |= $puz[$_] for @liverows;
     next RECURSE unless $colcheck eq $rloc->{livecol};

     # select a pivot column
     my $pivcol; my $pivmask;

     COLPICK:
     for my $col ( 0 .. $COLCNT - 1 )
     {
        next COLPICK unless vec( $rloc->{livecol}, $col, 1 );

        $pivcol = $col;
        $pivmask = $ZEROCOL;
        vec( $pivmask, $pivcol, 1 ) = 1;

        my $cnt = 0;
        (( $pivmask & $puz[$_] ) ne $ZEROCOL ) and $cnt++
           for @liverows;

        # shortcurcuit select if any singletons found
        last COLPICK if $cnt == 1;
     }

     # enumerate pivot rows:
     @pivrows = ();
     for ( @liverows )
     {
        push @pivrows, $_
           if (( $pivmask & $puz[$_] ) ne $ZEROCOL );
     }

     # DESCEND - each pivot row is a path to descend into
     for my $prow ( shuffle @pivrows )
     {
        my %crloc = %$rloc;

        # prune out covered rows
        for my $r ( @liverows )
        {
           vec( $crloc{removed}, $r, 1 ) = 1
              if ( $puz[$r] & $puz[$prow] ) ne $ZEROCOL;
        }

        # mask out consumed columns
        $crloc{livecol} &= ~ $puz[$prow];

        # add row to solutionset
        vec( $crloc{solset}, $prow, 1 ) = 1;

        $curpaths++;
        push @stack, \%crloc;
     }

  }
  return @solutions;
}

############################################################

sub find_minimal
{
  my ( @solset ) = @_;

  # This is cheap and dirty, but at least it's cheap and dirty.
  my @sol;
  do
  {
     @sol = shuffle @solset;
     pop @sol for 0..30;
  }
  until ( is_unambiguous( @sol ) );

  TRIM:
  while ( 1 )
  {
     for ( 0..$#sol )
     {
        my $front = shift @sol;
        next TRIM if is_unambiguous( @sol );
        push @sol, $front;
     }
     last TRIM;  # none can be removed
  }

  return @sol;
}

############################################################

sub is_unambiguous
{
  my @set        = @_;
  my $puzzle     = make_puzzle();
  my $pstash     = make_path_stash( $puzzle, @set );

  my @solutions  = solve_cover( $puzzle, $pstash, 2 );

  return ( scalar( @solutions ) == 1 );
}

############################################################

sub make_path_stash
{
  my( $puz, @set ) = @_;
  my $mask    = $ZEROCOL;
  my $solset  = $ZEROROW;
  my $remset  = $ZEROROW;

  if ( @set )
  {
     $mask |= $puz->[$_] for @set;

     for my $row ( 0.. ( $ROWCNT - 1 ) )
     {
        vec( $remset, $row, 1 ) = 1
           if ( ( $puz->[$row] & $mask ) ne $ZEROCOL );
     }

     vec( $solset, $_, 1 ) = 1 for @set;
  }

  return {
           livecol  => ( ~ $mask ) & $FULLCOL,
           removed  => $remset,
           solset   => $solset,
           colptr   => 0,
         };
}

############################################################
# return puzzle array

sub make_puzzle
{
  my @puz;
  for my $sqr ( 0..80 )
  {
     for my $val ( 1..9 )
     {
        push @puz, map_to_covervec( $val, $sqr );
     }
  }

  return \@puz;
}

############################################################
# given a square and a value, return bitvec

sub map_to_covervec
{
  my ( $num, $sqr ) = @_;
  my $bitmap = $ZEROCOL;        # blank row
  my $seg = 9**2;               # constraint segment offset

  my $row = int( $sqr / 9 );    # row
  my $col = $sqr % 9;           # col
  my $blk = int( $col / 3 ) +   # block
            int( $row / 3 ) * 3;

  # map to contraint offsets
  my @offsets = (
     $sqr,
     $seg + $row * 9 + $num - 1,
     $seg * 2 + $col * 9 + $num - 1,
     $seg * 3 + $blk * 9 + $num - 1,
     );

  # poke out offsets
  vec( $bitmap, $_, 1 ) = 1 for @offsets;

  return $bitmap;
}

############################################################
# pretty print puzzle

sub pprint_puzzle
{
  my @set = @_;

  # map values on to squares:
  my @puzzle;
  $puzzle[int($_ / 9)] = 1 + $_ % 9 for @set;

  for ( 1..81 )
  {
     print( ( $puzzle[$_-1] ) ? "$puzzle[$_-1] " : "- " );
     print "  " unless $_ % 3;
     print "\n" unless $_ % 9;
     print "\n" unless $_ % (9*3);
  }
}saints
