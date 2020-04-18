#!/usr/bin/perl


  ######
  #   RPN::Stack::Frame
   #    Manages the stacks (even for the calculator).
   #    It will never drop the final frame which is
   #    the RPN calculator's stack.

package RPN::Stack::Frame;

use strict;
use RPN::Stack;


sub init  { my @f = (RPN::Stack->init); return (bless \@f) }
sub flush { my $f = shift; $f->pop while ($f->size > 1) }
sub pop   { my $f = shift; pop(@{$f}) if ($f->size > 1) }
sub push  { my $f = shift; push(@{$f}, RPN::Stack->init); return ($f->get) }
sub size  { int(@{shift()}) }
sub get   { shift->[0 - shift] }
sub top   { shift->get(1) }


__PACKAGE__
