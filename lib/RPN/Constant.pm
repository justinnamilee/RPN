#!/usr/bin/perl


  ######
  #   RPN::Constant
   #    No more scary constants...Well some.

package RPN::Constant;

use strict;


sub MAX_UINT32()
{ 0xFFFFFFFFFFFFFFFF }
sub MAX_UINT16()
{ 0xFFFFFFFF }
sub MAX_UINT8()
{ 0xFFFF }
sub MIN_UINT32()
{ 0x0000000000000000 }
sub MIN_UINT16()
{ 0x00000000 }
sub MIN_UINT8()
{ 0x0000 }

sub DEF_STACK_BEGIN()
{ 0 }
sub DEF_MEM_BEGIN()
{ 0x0000000000000000 }
sub DEF_AUTO_REVERSE()
{ 1 }
sub DEF_INTERACTIVE()
{ 0 }
sub DEF_RUN_STATE()
{ 0 }


__PACKAGE__
