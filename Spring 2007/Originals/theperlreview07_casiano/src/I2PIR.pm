package main;

# This module has been generated using Parse::Eyapp::Treereg
# from file I2PIR.trg. Don't modify it.
# Change I2PIR.trg instead.
# Copyright (c) Casiano Rodriguez-Leon 2006. Universidad de La Laguna.
# You may use it and distribute it under the terms of either
# the GNU General Public License or the Artistic License,
# as specified in the Perl README file.

use strict;
use warnings;
use Carp;
use Parse::Eyapp::_TreeregexpSupport qw(until_first_match checknumchildren);

#line 43 "I2PIR.trg"
our @translation = Parse::Eyapp::YATW->buildpatterns(t_num => \&t_num, t_var => \&t_var, t_op => \&t_op, t_neg => \&t_neg, t_assign => \&t_assign, t_list => \&t_list, t_print => \&t_print,);
#line 6 "I2PIR.trg"
our @algebra = Parse::Eyapp::YATW->buildpatterns(fold => \&fold, wxz => \&wxz, zxw => \&zxw, neg => \&neg,);
our @all = ( our $fold, our $zxw, our $wxz, our $neg, our $reg_assign, our $t_num, our $t_var, our $t_op, our $t_neg, our $t_assign, our $t_print, our $t_list, ) = Parse::Eyapp::YATW->buildpatterns(fold => \&fold, zxw => \&zxw, wxz => \&wxz, neg => \&neg, reg_assign => \&reg_assign, t_num => \&t_num, t_var => \&t_var, t_op => \&t_op, t_neg => \&t_neg, t_assign => \&t_assign, t_print => \&t_print, t_list => \&t_list, );

#line 1 "I2PIR.trg"
 #  Example of support code
  use List::Util qw(reduce);
  my %Op = (PLUS=>'+', MINUS => '-', 
            TIMES=>'*', DIV => '/');


  sub fold { 
    my $fold = $_[3]; # reference to the YATW pattern object
    my @NUM;
    my $b;

    {
      my $child_index = 0;

      return 0 unless ref($b = $_[$child_index]) =~ m{\bTIMES\b|\bPLUS\b|\bDIV\b|\bMINUS\b}x;
    return 0 unless ref($NUM[0] = $b->child(0+$child_index)) eq 'NUM';
    return 0 unless ref($NUM[1] = $b->child(1+$child_index)) eq 'NUM';

    } # end block of child_index
#line 9 "I2PIR.trg"
  {  
  my $op = $Op{ref($b)};
  $NUM[0]->{attr} = eval  
  "$NUM[0]->{attr} $op $NUM[1]->{attr}";
  $_[0] = $NUM[0]; 
}

  } # end of fold 


  sub zxw { 
    my $zxw = $_[3]; # reference to the YATW pattern object
    my $NUM;
    my $W;
    my $TIMES;

    {
      my $child_index = 0;

      return 0 unless (ref($TIMES = $_[$child_index]) eq 'TIMES');
    return 0 unless ref($NUM = $TIMES->child(0+$child_index)) eq 'NUM';
    return 0 unless defined($W = $TIMES->child(1+$child_index));
    return 0 unless do 
#line 15 "I2PIR.trg" 
      {$NUM->{attr} == 0};

    } # end block of child_index
#line 16 "I2PIR.trg"
  {  $_[0] = $NUM }

  } # end of zxw 


  sub wxz { 
    my $wxz = $_[3]; # reference to the YATW pattern object
    my $NUM;
    my $W;
    my $TIMES;

    {
      my $child_index = 0;

      return 0 unless (ref($TIMES = $_[$child_index]) eq 'TIMES');
    return 0 unless defined($W = $TIMES->child(0+$child_index));
    return 0 unless ref($NUM = $TIMES->child(1+$child_index)) eq 'NUM';
    return 0 unless do 
#line 17 "I2PIR.trg" 
      {$NUM->{attr} == 0};

    } # end block of child_index
#line 18 "I2PIR.trg"
  {  $_[0] = $NUM }

  } # end of wxz 


  sub neg { 
    my $neg = $_[3]; # reference to the YATW pattern object
    my $NUM;
    my $NEG;

    {
      my $child_index = 0;

      return 0 unless (ref($NEG = $_[$child_index]) eq 'NEG');
    return 0 unless ref($NUM = $NEG->child(0+$child_index)) eq 'NUM';

    } # end block of child_index
#line 20 "I2PIR.trg"
  {  $NUM->{attr} = -$NUM->{attr}; 
     $_[0] = $NUM }

  } # end of neg 

#line 23 "I2PIR.trg"
{ my $num = 1; # closure
  sub new_N_register {
    return '$N'.$num++;
  }
}

  sub reg_assign { 
    my $reg_assign = $_[3]; # reference to the YATW pattern object
    my $x;

    {
      my $child_index = 0;

      return 0 unless defined($x = $_[$child_index]);

    } # end block of child_index
#line 30 "I2PIR.trg"
  {  
    if (ref($x) =~ /VAR|NUM/) {
      $x->{reg} = $x->{attr};
      return 1;
    }
    if (ref($x) =~ /ASSIGN/) {
      $x->{reg} = $x->child(0)->{attr};
      return 1;
    }
    $_[0]->{reg} = new_N_register(); 
  }

  } # end of reg_assign 


  sub t_num { 
    my $t_num = $_[3]; # reference to the YATW pattern object
    my $NUM;

    {
      my $child_index = 0;

      return 0 unless ref($NUM = $_[$child_index]) eq 'NUM';

    } # end block of child_index
#line 46 "I2PIR.trg"
  {  $NUM->{tr} = $NUM->{attr} }

  } # end of t_num 

#line 47 "I2PIR.trg"
 our %s; 

  sub t_var { 
    my $t_var = $_[3]; # reference to the YATW pattern object
    my $VAR;

    {
      my $child_index = 0;

      return 0 unless ref($VAR = $_[$child_index]) eq 'VAR';

    } # end block of child_index
#line 48 "I2PIR.trg"
  { 
    $s{$_[0]->{attr}} = "num";
    $_[0]->{tr} = $_[0]->{attr};
  }

  } # end of t_var 


  sub t_op { 
    my $t_op = $_[3]; # reference to the YATW pattern object
    my $y;
    my $b;
    my $x;

    {
      my $child_index = 0;

      return 0 unless ref($b = $_[$child_index]) =~ m{\bTIMES\b|\bPLUS\b|\bDIV\b|\bMINUS\b}x;
    return 0 unless defined($x = $b->child(0+$child_index));
    return 0 unless defined($y = $b->child(1+$child_index));

    } # end block of child_index
#line 53 "I2PIR.trg"
  { 
    my $op = $Op{ref($b)};
    $b->{tr} = "$b->{reg} = $x->{reg} "
                   ."$op $y->{reg}"; 
  }

  } # end of t_op 


  sub t_neg { 
    my $t_neg = $_[3]; # reference to the YATW pattern object
    my $exp;
    my $NEG;

    {
      my $child_index = 0;

      return 0 unless (ref($NEG = $_[$child_index]) eq 'NEG');
    return 0 unless defined($exp = $NEG->child(0+$child_index));

    } # end block of child_index
#line 58 "I2PIR.trg"
  { 
  $NEG->{tr} = "$NEG->{reg} = - $exp->{reg}";
}

  } # end of t_neg 


  sub t_assign { 
    my $t_assign = $_[3]; # reference to the YATW pattern object
    my $e;
    my $ASSIGN;
    my $v;

    {
      my $child_index = 0;

      return 0 unless (ref($ASSIGN = $_[$child_index]) eq 'ASSIGN');
    return 0 unless defined($v = $ASSIGN->child(0+$child_index));
    return 0 unless defined($e = $ASSIGN->child(1+$child_index));

    } # end block of child_index
#line 62 "I2PIR.trg"
  {  
  $s{$v->{attr}} = "num";
  $ASSIGN->{tr} = "$v->{reg} = $e->{reg}" 
}

  } # end of t_assign 

#line 67 "I2PIR.trg"
 my $cr = '\\n'; 

  sub t_print { 
    my $t_print = $_[3]; # reference to the YATW pattern object
    my $W;
    my $var;
    my $PRINT;

    {
      my $child_index = 0;

      return 0 unless (ref($PRINT = $_[$child_index]) eq 'PRINT');
    return 0 unless defined($W = $PRINT->child(0+$child_index));
    return 0 unless defined($var = $PRINT->child(1+$child_index));

    } # end block of child_index
#line 69 "I2PIR.trg"
  { 
    $s{$var->{attr}} = "num";
    $PRINT->{tr} =<<"EOP";
print "$var->{attr} = "
print $var->{attr}
print "$cr"
EOP
  }

  } # end of t_print 

#line 78 "I2PIR.trg"

  # Concatenates the translations of the subtrees
  sub cat_trans {
    my $t = shift;

    my $tr = "";
    for ($t->children) {
      (ref($_) =~ m{NUM|VAR|TERMINAL}) 
        or $tr .= cat_trans($_)."\n" 
    }
    $tr .= $t->{tr} ;
  }


  sub t_list { 
    my $t_list = $_[3]; # reference to the YATW pattern object
    my @S;
    my $EXPS;

    {
      my $child_index = 0;

      return 0 unless (ref($EXPS = $_[$child_index]) eq 'EXPS');
    @S = ($EXPS->children);
    @S = @S[$child_index+0..$#S];

    } # end block of child_index
#line 93 "I2PIR.trg"
  { 
    $EXPS->{tr} = "";
    my @tr = map { cat_trans($_) } @S;
    $EXPS->{tr} = 
      reduce { "$a\n$b" } @tr if @tr;
  }

  } # end of t_list 


1;

