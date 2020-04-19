#!/usr/bin/perl


  ######
  #   RPN::Register
   #    The control unit! Manages memory, registers,
   #    and probably some other important stuff...

package RPN::Register;

use strict;


use RPN::Constant;
use RPN::Error;
use RPN::Stack::Frame;


# super helpers
sub hexify($)  { sprintf(RPN::Constant->HEX_FORMAT, shift) }
sub num2reg($) { sprintf(RPN::Constant->REG_FORMAT, shift) } # note R0 is a special register

# just helpers
sub HIGH32($) { (0xFFFFFFFF00000000 & shift) >> 32 }
sub LOW32($)  { 0x00000000FFFFFFFF & shift }
sub HIGH16($) { (0xFFFF0000 & shift) >> 16 }
sub LOW16($)  { 0x0000FFFF & shift }
sub HIGH8($)  { 0xFF00 & shift }
sub LOW8($)   { (0x00FF & shift) >> 8 }

my %opcode; # static crap
my $run; # not how this works
my $config;

sub init
{
	my %self =
	(
		register => {}, # machine "registers"
		memory   => {}, # 32-bit address space
		frame    => RPN::Stack::Frame->init
	);

	# register init
	$self{register}->{INSR}   = undef;
	$self{register}->{DATA}   = undef;
	$self{register}->{PC}     = RPN::Constant->DEF_MEM_BEGIN;
	$self{register}->{RECALL} = RPN::Constant->DEF_MEM_BEGIN;
	$self{register}->{COW}    = hexify(0); # don't have a cow, man
	$self{register}->{R0}     = hexify(0);
	$self{register}->{TEST}   = hexify(0);

	return (bless \%self);
}

# fetchers
sub register    { shift->{register} }
sub memory      { shift->{memory} }
sub frame       { shift->{frame} }
sub stack       { shift->frame->top }

# read only shaz
sub fetch       { my $s = shift; hexify($s->memory->{$s->next_pc}) }
sub instruction { my $s = shift; defined($s->register->{INSR}) ? ($s->register->{INSR} = $s->fetch) : $s->register->{INSR} }
sub data        { my $s = shift; defined($s->register->{DATA}) ? ($s->register->{DATA} = $s->fetch) : $s->register->{DATA} }
sub recall      { hexify(shift->register->{RECALL}) }
sub counter     { hexify(shift->register->{PC}) }
sub next_pc     { hexify(shift->register->{PC}++) }
sub prev_pc     { hexify(shift->register->{PC}--) }

# control
sub halt        { $run = 0 }
sub unhalt      { $run = 1 }

# to and from calculator
sub load        { my $s = shift; $s->memory->{$s->next_pc} = $s->stack->pop }
sub dump
{
	my $s = shift;
	for (my $i = RPN::Constant->DEF_MEM_BEGIN; $i < $s->counter; $i++)
	{
		print q[MEM(]. hexify($i) .q[) => ]. hexify($s->memory->{hexify($i)}) .qq[\n];
	}
}

# these are pretty important
sub run         { shift->step while ($run) }
sub step
{
	my $s = shift;

	if ($s->counter < RPN::Constant->MAX_UINT32)
	{
		if (exists($opcode{$s->instruction}))
		{
			$opcode{$s->instruction}->(); # run it!
		}
		else
		{
			warn RPN::Error->INPUT_UNKNOWN_CMD;
		}
	}
	else
	{
		warn RPN::Error->MEMORY_LIMIT_REACHED;
	}

	# sleep some amount to simulate clock speeds?

	# clean up
	$s->register->{DATA} = undef;
	$s->register->{INSR} = undef;
}

# setup the static crap
sub prime
{
	my $self = shift;

	$config = shift;
	$run = RPN::Constant->DEF_RUN_STATE;

	if (-f $config->{computer})
	{
		%opcode = do $config->{computer};
	}
	else
	{
		RPN::Error->MODULE_LOAD_FAILED;
	}
}


__PACKAGE__
