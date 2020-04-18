#!/usr/bin/perl


  ######
  #   RPN::Stack
   #    A singular stack...What fun is that?

package RPN::Stack;

use strict;

sub init  { my @s = (); return (bless \@s) }
sub has   { my $e = shift->size >= shift; warn RPN::Error->STACK_EMPTY unless $e; return ($e) }
sub dump  { @{shift()} }
sub flush { @{shift()} = () }
sub size  { int(@{shift()}) }
sub empty { not(shift->size) }
sub push  { push(@{shift()}, @_) }
sub pop   { pop(@{shift()}) }
sub set   { shift->[0 - shift] = shift } # reverse indexed
sub get   { shift->[0 - shift] } # ditto
sub top   { shift->get(1) }


__PACKAGE__
