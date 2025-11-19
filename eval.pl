use strict;
use warnings;

# Using `eval` to handle exceptions and prevent a program to exit
my $nResult;

eval { $nResult = 1 / 0; } ;
# Error captured by `eval`: Illegal division by zero at .\eval.pl line 1.
print "Error captured by `eval`: $@";
# $nResult is undef
print "\$nResult == $nResult\n";

$nResult = eval { 1 / 0 } ;
# $nResult is undef
print "\$nResult == $nResult\n";
my @aResult = eval { 1 / 0; } ;
# @aResult is ()
print "\@aResult == @aResult\n";

$nResult = eval { 1 / 1 } ;
# $nResult is 1
print "\$nResult == $nResult\n";
@aResult = eval { 1 / 1; } ;
# @aResult is (1, )
print "\@aResult == @aResult\n";

# Using `eval` to evaluate strings
my $sOperator = '+';
my $nSum = eval "1 $sOperator 2";
print "\$nSum == $nSum\n";
