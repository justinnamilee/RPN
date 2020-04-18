  #!/usr/bin/perl

  
  ######
  #   RPN
   #    The main calculation interface and CPU
   #    control interface, etc.

package RPN;

use strict;


use RPN::Register;
use RPN::Constant;
use RPN::Error;


# these should be somewhere else
sub TRUE()  { 1 }
sub FALSE() { 0 }
sub bool2num(_)  { shift() ? TRUE : FALSE }
sub force2num(_) { 0 + shift }


my $config;
my $stack;
my $command;
my $register;
my %operation;
my %help;


# do it!
sub execute
{
	$command = shift;

	if ($command =~ /^(?:\+|-)?(?:0[xXbB])?\d+(?:\.\d+)?(?:e\d+)?$/)
	{
		# push numbers onto the stack
		$stack->push(force2num($command));
	}
	elsif (exists($operation{$command}) && $command !~ /^help/i)
	{
		# grab commands if we have them
		$command = $operation{$command};
	}
	elsif ($command =~ /^help:(.+)/i)
	{
		$command = lc($1);

		if ($command eq q[list])
		{
			print q[list> ]. join(q[, ], keys(%operation)) .qq[\n];
		}
		elsif (exists($operation{help}->{$command}))
		{
			print qq[help[$command]> $operation{help}->{$command}\n];
		}
		else
		{
			warn RPN::Error->INPUT_UNKNOWN_CMD;
		}
	}
	elsif ($command =~ /^help/i)
	{
		print qq[help>\n];
		print qq[\t   Get a listing: help:list\n];
		print qq[\tGet command help: help:<command>\n];
	}
	else
	{
		warn RPN::Error->INPUT_UNKNOWN_CMD;
	}

	$command->(@_) if (ref($command));

	undef($command);
}

# init the static crap
sub prime
{
	my $self = shift;

	$config = shift;
	RPN::Register->prime($config); # get er' nice and ready
	$register = RPN::Register->init; # control unit
	$stack = $register->frame->top; # calculator stack is always top frame

    if (-f $config->{calculator})
    {
	    %operation = do $config->{calculator};
    }
    else
    {
        warn RPN::Error->MODULE_LOAD_FAILED;
    }
}

# fetchers
sub stack    { $stack }
sub register { $register }


__PACKAGE__
