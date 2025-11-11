use strict;
use feature 'state';

my $n;
print "\$n == $n\n";

sub hello {
    $n += 1; # Global variable
    print "hello: \$n == $n\n";
}

&hello;
&hello;

# Global variable
print "\$n == $n\n";

# The return value is the last evaluated expression
sub SubWIthRetVal {
    $n += 1;
}

my $r1 = &SubWIthRetVal;
print "\$r1 == $r1\n";
$r1 = &SubWIthRetVal;
print "\$r1 == $r1\n";

# Arguments are stored in array @_
sub SubWithArgs {
    print "SubWithArgs: \@_ == @_\n";
    print "SubWithArgs: \$_[0] == $_[0]; \$_[1] == $_[1]\n";

    if ($_[0] >= $_[1]) {
        $_[0];
    } else {
        $_[1];
    }
}

print "\&SubWithArgs(2, 1) == ", &SubWithArgs(2, 1), "\n";
print "\&SubWithArgs(1, 2) == ", &SubWithArgs(1, 2), "\n";

# Private variables (lexical variables)
sub SubWithArgs1 {
    my ($n1, $n2) = @_;

    if ($n1 >= $n2) {
        $n1;
    } else {
        $n2;
    }
}

print "\&SubWithArgs1(2, 1) == ", &SubWithArgs1(2, 1), "\n";
print "\&SubWithArgs1(1, 2) == ", &SubWithArgs1(1, 2), "\n";

sub SubWithArgsN {
    my ($nMax) = shift @_;

    foreach (@_){
        if ($_ > $nMax){
            $nMax = $_;
        }
    }
    $nMax;
}

print "\&SubWithArgsN(2, 1, 3) == ", &SubWithArgsN(2, 1, 3), "\n";
print "\&SubWithArgsN(1, 2, 3) == ", &SubWithArgsN(1, 2, 3), "\n";
print "\&SubWithArgsN() == ", &SubWithArgsN(), "\n"; # == undef

# The `return` operator
sub SubWIthReturnFindInArray {
    # Return the index of an $ElemToFind in @Array
    my($ElemToFind, @Array) = @_;

    foreach (0 .. $#Array){
        if ($ElemToFind == $Array[$_]){
            return $_;
        }
    }

    return -1; # The `return` is optional; `-1;` does the same
}

print "\&SubWIthReturnFindInArray(1, (2,1,4)) == ", &SubWIthReturnFindInArray(1, (2,1,4)), "\n";
print "\&SubWIthReturnFindInArray(10, (2,1,4)) == ", &SubWIthReturnFindInArray(10, (2,1,4)), "\n";

# Non-scalar return values
sub BiDirRange {
    my($Start, $Stop) = @_;

    # Return true in list context, false in scalar, undef in void
    my $bWantArray = wantarray;
    print "\$bWantArray == $bWantArray\n";

    if ($Start < $Stop){
        $Start..$Stop;
    }
    else {
        reverse $Stop..$Start;
    }
}

my @lUp = &BiDirRange(1, 3);   # 1 2 3
my @lDown = &BiDirRange(3, 1); # 3 2 1
print "\@lUp == @lUp\n";
print "\@lDown == @lDown\n";

my $sUp = &BiDirRange(1, 3);   # 1E0 - not sure why it is different from the below
my $sDown = &BiDirRange(3, 1); # 321
print "\$sUp == $sUp\n";
print "\$sDown == $sDown\n";

# Persistent local vars
sub SubWithStateVar {
    state $n = 0;
    $n += 1;
    print "SubWithStateVar: \$n == $n\n";
}
&SubWithStateVar;
&SubWithStateVar;

# Subroutine signatures were only added in Perl v5.20
# use v5.20;
# use experimental qw(signatures);
# sub max ($n1, $n2){
#     if ($n1 > $n2) { $n1 } else { $n2 }
# }
# &max(1,2);

sub total {
    my $nTotal = 0;

    foreach (@_) {
        $nTotal += $_;
    }
    $nTotal;
}

my @l1 = qw( 1 3 5 7 9 );
my $nTotalL1 = &total(@l1);
print "\$nTotalL1 == $nTotalL1\n";
print "\&total(1..1000) == ", &total(1..1000), "\n";

sub average {
    my $nTotal = &total(@_);
    my $nAverage = $nTotal / @_;
}

print "average(1..3) == ", &average(1..3), "\n";

sub above_average {
    my $nAverage = &average(@_);
    my @lAboveAverage = ();

    foreach (@_) {
        if ($_ > $nAverage){
            push @lAboveAverage, $_;
        }
    }

    @lAboveAverage;
}

my @lAboveAverage = &above_average(1..10);
print "\@lAboveAverage == @lAboveAverage\n";
@lAboveAverage = &above_average(100, 1..10);
print "\@lAboveAverage == @lAboveAverage\n";

sub greet {
    state $sPreviousName = "";
    my $sCurrName = @_[0];

    if (! $sPreviousName){
        print "The first name is $sCurrName\n";
    } else {
        print "The previous name is $sPreviousName; the current name is $sCurrName\n";
    }
    
    $sPreviousName = $sCurrName;
}

&greet("One");
&greet("Two");
&greet("Three");
