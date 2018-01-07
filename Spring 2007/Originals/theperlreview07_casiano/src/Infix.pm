###################################################################################
#
#    This file was generated using Parse::Eyapp version 1.069577.
#
# (c) Parse::Yapp Copyright 1998-2001 Francois Desarmenien.
# (c) Parse::Eyapp Copyright 2006 Casiano Rodriguez-Leon. Universidad de La Laguna.
#        Don't edit this file, use source file "Infix.eyp" instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
###################################################################################
package Infix;
use strict;
use Parse::Eyapp::Driver;
push @Infix::ISA, 'Parse::Eyapp::Driver';
use Parse::Eyapp::Node;




#line 21 ./Infix.pm

my $warnmessage =<< "EOFWARN";
Warning!: Did you changed the \@Infix::ISA variable inside the header section of the eyapp program?
EOFWARN

sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    warn $warnmessage unless __PACKAGE__->isa('Parse::Eyapp::Driver'); 
    my($self)=$class->SUPER::new( yyversion => '1.069577',
                                  yyGRAMMAR  =>
[
  [ _SUPERSTART => '$start', [ 'line', '$end' ], 1 ],
  [ EXPS => 'PLUS-1', [ 'PLUS-1', ';', 'sts' ], 1 ],
  [ EXPS => 'PLUS-1', [ 'sts' ], 1 ],
  [ line_3 => 'line', [ 'PLUS-1' ], 1 ],
  [ PRINT => 'sts', [ 'PRINT', 'leftvalue' ], 1 ],
  [ sts_5 => 'sts', [ 'exp' ], 1 ],
  [ NUM => 'exp', [ 'NUM' ], 1 ],
  [ VAR => 'exp', [ 'VAR' ], 1 ],
  [ ASSIGN => 'exp', [ 'leftvalue', '=', 'exp' ], 1 ],
  [ PLUS => 'exp', [ 'exp', '+', 'exp' ], 1 ],
  [ MINUS => 'exp', [ 'exp', '-', 'exp' ], 1 ],
  [ TIMES => 'exp', [ 'exp', '*', 'exp' ], 1 ],
  [ DIV => 'exp', [ 'exp', '/', 'exp' ], 1 ],
  [ NEG => 'exp', [ '-', 'exp' ], 0 ],
  [ exp_14 => 'exp', [ '(', 'exp', ')' ], 1 ],
  [ VAR => 'leftvalue', [ 'VAR' ], 1 ],
],
                                  yyTERMS  =>
{ '$end' => 0, '(' => 0, ')' => 0, '*' => 0, '+' => 0, '-' => 0, '/' => 0, ';' => 0, '=' => 0, NEG => 1, NUM => 1, PRINT => 1, VAR => 1 },
                                  yyFILENAME  => "Infix.eyp",
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7,
			'PRINT' => 9
		},
		GOTOS => {
			'exp' => 2,
			'sts' => 8,
			'leftvalue' => 3,
			'line' => 10,
			'PLUS-1' => 4
		}
	},
	{#State 1
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 11,
			'leftvalue' => 3
		}
	},
	{#State 2
		ACTIONS => {
			"-" => 12,
			"*" => 15,
			"+" => 13,
			"/" => 14
		},
		DEFAULT => -5
	},
	{#State 3
		ACTIONS => {
			"=" => 16
		}
	},
	{#State 4
		ACTIONS => {
			";" => 17
		},
		DEFAULT => -3
	},
	{#State 5
		DEFAULT => -6
	},
	{#State 6
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 18,
			'leftvalue' => 3
		}
	},
	{#State 7
		ACTIONS => {
			"=" => -15
		},
		DEFAULT => -7
	},
	{#State 8
		DEFAULT => -2
	},
	{#State 9
		ACTIONS => {
			'VAR' => 20
		},
		GOTOS => {
			'leftvalue' => 19
		}
	},
	{#State 10
		ACTIONS => {
			'' => 21
		}
	},
	{#State 11
		DEFAULT => -13
	},
	{#State 12
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 22,
			'leftvalue' => 3
		}
	},
	{#State 13
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 23,
			'leftvalue' => 3
		}
	},
	{#State 14
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 24,
			'leftvalue' => 3
		}
	},
	{#State 15
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 25,
			'leftvalue' => 3
		}
	},
	{#State 16
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7
		},
		GOTOS => {
			'exp' => 26,
			'leftvalue' => 3
		}
	},
	{#State 17
		ACTIONS => {
			'NUM' => 5,
			"-" => 1,
			"(" => 6,
			'VAR' => 7,
			'PRINT' => 9
		},
		GOTOS => {
			'exp' => 2,
			'sts' => 27,
			'leftvalue' => 3
		}
	},
	{#State 18
		ACTIONS => {
			"-" => 12,
			"*" => 15,
			"+" => 13,
			"/" => 14,
			")" => 28
		}
	},
	{#State 19
		DEFAULT => -4
	},
	{#State 20
		DEFAULT => -15
	},
	{#State 21
		DEFAULT => 0
	},
	{#State 22
		ACTIONS => {
			"*" => 15,
			"/" => 14
		},
		DEFAULT => -10
	},
	{#State 23
		ACTIONS => {
			"*" => 15,
			"/" => 14
		},
		DEFAULT => -9
	},
	{#State 24
		DEFAULT => -12
	},
	{#State 25
		DEFAULT => -11
	},
	{#State 26
		ACTIONS => {
			"-" => 12,
			"*" => 15,
			"+" => 13,
			"/" => 14
		},
		DEFAULT => -8
	},
	{#State 27
		DEFAULT => -1
	},
	{#State 28
		DEFAULT => -14
	}
],
                                  yyrules  =>
[
	[#Rule _SUPERSTART
		 '$start', 2, undef
#line 278 ./Infix.pm
	],
	[#Rule EXPS
		 'PLUS-1', 3,
sub {
#line 11 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_TX1X2 }
#line 285 ./Infix.pm
	],
	[#Rule EXPS
		 'PLUS-1', 1,
sub {
#line 11 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYActionforT_single }
#line 292 ./Infix.pm
	],
	[#Rule line_3
		 'line', 1,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 299 ./Infix.pm
	],
	[#Rule PRINT
		 'sts', 2,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 306 ./Infix.pm
	],
	[#Rule sts_5
		 'sts', 1,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 313 ./Infix.pm
	],
	[#Rule NUM
		 'exp', 1,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 320 ./Infix.pm
	],
	[#Rule VAR
		 'exp', 1,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 327 ./Infix.pm
	],
	[#Rule ASSIGN
		 'exp', 3,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 334 ./Infix.pm
	],
	[#Rule PLUS
		 'exp', 3,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 341 ./Infix.pm
	],
	[#Rule MINUS
		 'exp', 3,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 348 ./Infix.pm
	],
	[#Rule TIMES
		 'exp', 3,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 355 ./Infix.pm
	],
	[#Rule DIV
		 'exp', 3,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 362 ./Infix.pm
	],
	[#Rule NEG
		 'exp', 2,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 369 ./Infix.pm
	],
	[#Rule exp_14
		 'exp', 3,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 376 ./Infix.pm
	],
	[#Rule VAR
		 'leftvalue', 1,
sub {
#line 7 "Infix.eyp"
 goto &Parse::Eyapp::Driver::YYBuildAST }
#line 383 ./Infix.pm
	]
],
#line 386 ./Infix.pm
                                  yybypass => 1,
                                  @_,);
    bless($self,$class);

    $self->make_node_classes( qw{TERMINAL _OPTIONAL _STAR_LIST _PLUS_LIST 
         _SUPERSTART
         EXPS
         line_3
         PRINT
         sts_5
         NUM
         VAR
         ASSIGN
         PLUS
         MINUS
         TIMES
         DIV
         NEG
         exp_14} );
    $self;
}

#line 33 "Infix.eyp"

  my $lineno = 1;

  sub Err {
    my $parser = shift;

    my($token)=$parser->YYCurval;
    my($what)= $token ? "input: '$token'" 
                      : "end of input";
    my @expected = $parser->YYExpect();
    local $" = ', ';
    die << "ERRMSG";
Syntax error near $what (line number $lineno). 
Expected one of these terminals: @expected
ERRMSG
  }

  sub Lex {
    my($parser)=shift; # The parser object

    for ($parser->YYData->{INPUT}) { # Topicalize
      m{\G[ \t]*}gc;
      m{\G\n}gc                      
        and $lineno++;
      m{\G([0-9]+(?:\.[0-9]+)?)}gc   
        and return('NUM',$1);
      m{\Gprint}gc                   
        and return('PRINT', 'PRINT');
      m{\G([A-Za-z_][A-Za-z0-9_]*)}gc 
        and return('VAR',$1);
      m{\G(.)}gc                     
        and return($1,$1);
      return('',undef);
    }
  }

#line 446 ./Infix.pm

1;
