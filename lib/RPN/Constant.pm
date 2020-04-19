#!/usr/bin/perl


  ######
  #   RPN::Constant
   #    No more scary constants...Well some.

package RPN::Constant;

use strict;


sub PROMPT()
{ q[ ~ ] }
sub PROMPT_DISABLE()
{ '%interactive=>0' }
sub PROMPT_ENABLE()
{ '%interactive=>1' }


#sub MAX_UINT64()
# 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF }
sub MAX_UINT32()
{ 0xFFFFFFFFFFFFFFFF }
sub MAX_UINT16()
{ 0xFFFFFFFF }
sub MAX_UINT8()
{ 0xFFFF }
#sub MIN_UINT64()
#{ 0x00000000000000000000000000000000 }
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
sub DEF_CALC_FILE()
{ q[./data/Calculator.rpn] }
sub DEF_COMP_FILT()
{ q[./data/Computer.rpn] }

sub TEST_FLAG_OVFL()
{ 0b01 }

sub HEX_FORMAT()
{ q[0x%08X] }
sub REG_FORMAT()
{ q[R%d] }


__PACKAGE__
