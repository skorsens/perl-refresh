#!/usr/bin/perl
use strict;
use warnings;

print "Before require - trying to call hello_world():\n";
# This would fail: hello_world(); # Function not defined yet

print "Loading module with require...\n";
require './simple_module.pl';
# After the call to the `require`, all sub's in ./simple_module.pl
# are visible because Perl adds them to the global namespace `main`.
print "After require - now I can call the functions:\n";
hello_world();

my $result = add_numbers(5, 3);
print "5 + 3 = $result\n";

# Let's check what namespace we're in
print "Current package: ", __PACKAGE__, "\n";
