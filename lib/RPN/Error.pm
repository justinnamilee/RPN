#!/usr/bin/perl


  ######
  #   RPN::Error
   #    A collection of error messages, pure poetry.

package RPN::Error;

use strict;


sub STACK_EMPTY()
{ q[Stack is empty, what are you doing] }
sub INPUT_UNKNOWN_CMD()
{ q[Unknown operation found while parsing input, try reading some documentation first] }
sub POSSIBLE_BUFFER_OVERFLOW()
{ q[Hit unintialized memory, you really suck at this] }
sub MEMORY_LIMIT_REACHED()
{ q[Holy hell, we hit the end of the universe, Bill Gates was wrong after all] }


__PACKAGE__
