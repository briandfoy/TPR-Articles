<p>
I've been doing a lot of work with Sudoku this week because the next issue of the Perl review it almost entirely devoted to it. We'll have things
to make the puzzle and things to solve it.
</p>
<p>
Eric Maki's puzzle generator output text, so I wanted to turn that into something a bit nicer. I figured it would be a snap for [cpan://PDF::API2], and it mostly was when I figured out what the methods actually did.
</p>
<p>
I was surprised that I couldn't find more [cpan://PDF::API2] examples, so I offer this one, with some notes at the end.
</p>

<readmore>
#!/usr/bin/perl

=head1 NAME

sudoku_maker - create Sudoku puzzles with PDF::API2

=head1 SYNOPSIS

	% perl sudoku_maker > sudoku.pdf
	- - 6   8 - 4   - - -   
	- - -   - 9 -   7 - 8   
	- - -   5 - -   - 9 -   
	
	1 - -   - 4 -   - - 9   
	- - -   - - -   5 - -   
	4 6 -   - - 1   - 3 -   
	
	8 7 -   - - -   4 - -   
	- - -   - 5 -   2 - -   
	- - -   - - 2   - 1 - 

=head1 DESCRIPTION

This is a proof-of-concept script. Eric Maki created a Sudoku puzzle
generator, but he output the text you see in the SYNOPSIS. I wanted
to turn that into a nice puzzle so I started tinkering with PDF::API2.
Eric's source will be part of the Spring 2006 issue of The Perl Review.

If you want to change the input, change C<get_puzzle> to parse it
correctly.

=head1 TO DO

=over 4

=item * most things can be configurable, but I hardcoded them

=item * i'd like to generate several puzzles per page

=item * the C<place_digit> routine is a bit of guess work for font centering.

=back

=head1 AUTHOR

brian d foy, C<< <bdfoy@cpan.org> >

=head1 COPYRIGHT and LICENSE

Copyright 2006, brian d foy, All rights reserved.

This software is available under the same terms as perl. 

=cut

use strict;
use warnings;

use PDF::API2;

use constant PAGE_WIDTH      => 595;
use constant PAGE_HEIGHT     => 842;
use constant MARGIN          =>  25;

use constant WIDE_LINE_WIDTH =>   3;
use constant LINE_WIDTH      =>   2;
use constant THIN_LINE_WIDTH =>   1;

use constant SQUARE_SIDE     => 270;

use constant FONT_SIZE       => int( 0.70 * SQUARE_SIDE / 9 );


my $pdf  = PDF::API2->new;
my $font = $pdf->corefont( 'Helvetica-Bold' );

run() unless caller;

sub run 
	{
	$pdf->mediabox( PAGE_WIDTH, PAGE_HEIGHT );
	
	my $gfx = $pdf->page->gfx;
	$gfx->strokecolor( '#000' );
	$gfx->linewidth( WIDE_LINE_WIDTH );

	make_grid( 
		$gfx,
		( PAGE_WIDTH - SQUARE_SIDE ) / 2 ,  # x
		PAGE_HEIGHT - SQUARE_SIDE - MARGIN, # y
		);
		
	populate_puzzle( $gfx, get_puzzle() );
	
	print $pdf->stringify;
	}
	
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
sub populate_puzzle
	{
	my( $gfx, $array ) = @_;
	
	foreach my $row ( 0 .. $#$array )
		{
		my $row_array = $array->[$row];
		
		foreach my $column ( 0 .. $#$row_array )
			{
			next unless defined $row_array->[$column];
			place_digit( $gfx, $row, $column, $row_array->[$column] )
			}
		}
	}
	
sub place_digit
	{
	my( $gfx, $row, $column, $digit ) = @_;
	
	my $x_start = ( PAGE_WIDTH - SQUARE_SIDE ) / 2;
	my $y_start = PAGE_HEIGHT - SQUARE_SIDE - MARGIN;
	
	my $x_offset = 0.30 * SQUARE_SIDE / 9; # empirically derived
	my $y_offset = 0.25 * SQUARE_SIDE / 9;
	
	my $x = $x_start + $column * SQUARE_SIDE / 9 + $x_offset;
	my $y = $y_start + $row * SQUARE_SIDE / 9 + $y_offset;
		
	$gfx->textlabel( $x, $y, $font, FONT_SIZE, $digit );
		
	}

sub get_puzzle
	{
	my @array;
	
	print STDERR "Waiting for puzzle input!\n";
	
	while( <STDIN> )
		{
		chomp;
		s/^\s|\s$//g;
		next unless length $_;
		push @array, [ map { $_ eq '-' ? undef : $_ } split ];
		}
	
	return \@array;
	}
	
sub make_grid 
	{
	my( $gfx, $lower_left_x, $lower_left_y ) = @_;
		
	make_outline( $gfx, $lower_left_x, $lower_left_y );

	$gfx->linewidth( THIN_LINE_WIDTH );
	make_blocks(  $gfx, $lower_left_x, $lower_left_y, 9 );

	$gfx->linewidth( LINE_WIDTH );
	make_blocks(  $gfx, $lower_left_x, $lower_left_y, 3 );
	}

sub make_blocks
	{
	my( $gfx, $lower_left_x, $lower_left_y, $cells ) = @_;
	
	my( $xs, $ys ) = 
		map { 
			my $point = $_; 
			[ map { $point + $_ * SQUARE_SIDE / $cells } 1 .. $cells - 1 ];
			} ( $lower_left_x, $lower_left_y );
		
	foreach my $x ( @$xs )
		{
		make_line( $gfx, 
			$x, $lower_left_y,
			$x, $lower_left_y + SQUARE_SIDE,
			);
		}

	foreach my $y ( @$ys )
		{
		make_line( $gfx, 
			$lower_left_x, $y,
			$lower_left_x + SQUARE_SIDE, $y,
			);
		}
	}
	
sub make_outline
	{
	my( $gfx, $lower_left_x, $lower_left_y ) = @_;

	my( $upper_right_x, $upper_right_y ) = 
		map { $_ + SQUARE_SIDE } ( $lower_left_x, $lower_left_y );
	
	my @points = (
		[ $lower_left_x,   $lower_left_y - WIDE_LINE_WIDTH / 2,
		  $lower_left_x,   $upper_right_y ],
		[ $lower_left_x, $upper_right_y - WIDE_LINE_WIDTH / 2,
		  $upper_right_x, $upper_right_y ],
		[ $upper_right_x - WIDE_LINE_WIDTH / 2, $upper_right_y,
		  $upper_right_x, $lower_left_y ],
		[ $upper_right_x, $lower_left_y + WIDE_LINE_WIDTH / 2,
		  $lower_left_x, $lower_left_y ],
		);
		
	foreach my $tuple ( @points ) { make_line( $gfx, @$tuple ) }
	}
	
sub make_line
	{
	my( $gfx, $x, $y, $x2, $y2 ) = @_;
	
	$gfx->move( $x,  $y  );
	$gfx->line( $x2, $y2 );
	$gfx->fillstroke;
	}

__END__
- - 6   8 - 4   - - -   
- - -   - 9 -   7 - 8   
- - -   5 - -   - 9 -   

1 - -   - 4 -   - - 9   
- - -   - - -   5 - -   
4 6 -   - - 1   - 3 -   

8 7 -   - - -   4 - -   
- - -   - 5 -   2 - -   
- - -   - - 2   - 1 - 
</readmore>

<h3>Some notes</h3>

<p>
Some of this is just my newness to the inner workings of PDF, and some
to the interface issues. [cpan://PDF::API2] is really a low level module,
so I can't really complain. We're supposed to build stuff on top of it.
Some of you may be able to elaborate on or correct these simple observations:
</p>

<ul>
<li>You need a graphics object to make graphics. That seems simple, but there
aren't many examples in the distro, and most people seem concerned with 
placing text. To get a graphics object, you need a page on which to put the graphics, so 
you need a page object first.
<li>To make the lines and other graphics elements show up, you have to
call <code>fillstroke</code>.
<li>Drawing a line doesn't move your cursor. The line starts at the 
current "pen" position and draws the line to the point you specify. Your pen
stays put. This isn't LOGO. :)
<li>The coordinates start at the lower lefthand corner. Y increases as you go up the page, and
X increases as you go to the right.
<li>To make two lines join nicely, you have to take into account their line
widths.
<li>When placing the pen, you don't have to use integers.
<li>For text, the starting point is the lower left corner of the first character (although
it looks like there is stuff to affect this).
</ul>

<p>
That's enough for 6 AM, I think. :)
</p>