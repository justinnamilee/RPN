#!/usr/bin/perl


  ######
  #   RPN::Stack::Frame
   #    Manages the stacks (even for the calculator).
   #    It will never drop the final frame which is
   #    the RPN calculator's stack.

package RPN::Stack::Frame;

use strict;


use RPN::Constant;
use RPN::Error;
use RPN::Stack;


sub init  { my @f = (RPN::Stack->init); return (bless \@f) }
sub flush { my $f = shift; @{$f} = (RPN::Stack->init) }
sub pop   { my $f = shift; pop(@{$f}) if ($f->size > 1) }
sub push  { my $f = shift; push(@{$f}, RPN::Stack->init) }
sub size  { int(@{shift()}) }
sub get   { shift->[0 - shift] }
sub top   { shift->get(1) }


__PACKAGE__
