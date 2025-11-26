@lInt = ();

$lInt[0] = 1;
$lInt[1] = 2;
$lInt[3] = 4;

print "\@lInt == @lInt\n";

print "The last element index of \@lInt as \$#lInt == $#lInt\n";
print "The last element of \@lInt as \$lInt[-1] == $lInt[-1]\n";

# The list literals
print '(1,2,3,) == ', (1,2,3,), "\n"; # Gives 123
print '(1,2,3,) == ', join(", ", (1,2,3,)), "\n"; # Gives 1, 2, 3

# The range operator
print '(1..4) == ', join(", ", (1..4)), "\n"; # Gives 1, 2, 3, 4
# (4..1) gives empty list since the range operator only counts up
print '(4..1) == ', join(", ", (4..1)), "\n"; 

# List elements can be variables and those elements are evaluated only once
$nVal1 = 1;
$nVal2 = 2;
@lArr1 = ($nVal1, $nVal2);
print "\@lArr1 == ", join(", ", @lArr1), "\n"; # @lArr1 == (1, 2)
$nVal1 += 3;
print "\$nVal1 == $nVal1\n";
print "\@lArr1 == ", join(", ", @lArr1), "\n"; # @lArr1 == (1, 2)

# The qw (quoted words) operator
@lArr2 = qw(one two three); # ("one", "two", "three")
print "\@lArr2 == ", join(", ", @lArr2), "\n";

# List assignments
($nVal0, $nVal1) = (1, 2, 3); # $nVal0 == 1, $nVal1 == 2
print "\$nVal0 == $nVal0, \$nVal1 == $nVal1\n";
($nVal0, $nVal1, $nVal2) = (1, 2, ); # $nVal0 == 1, $nVal1 == 2, $nVal2 == undef
print "\$nVal0 == $nVal0, \$nVal1 == $nVal1, \$nVal2 == $nVal2\n";

# The nested arrays are expanded to their members
@lArr3 = (@lArr1, @lArr2, 7, 8, 9); # @lArr3 == 1, 2, one, two, three, 7, 8, 9
print "\@lArr3 == ", join(", ", @lArr3), "\n";

# Copy arrays
@lArr4 = @lArr1;
print "\@lArr1 == ", join(", ", @lArr1), "\n";
$lArr4[0] = 43;
print "\@lArr4 == ", join(", ", @lArr4), "\n";

# pop and push
$nElem1 = pop(@lArr1); # $nElem1 == 2, @lArr1 == (1, )
print "\$nElem1 == $nElem1, \@lArr1 == ", join(", ", @lArr1), "\n";
push @lArr1, 2; # @lArr1 == (1, 2, )
print "\@lArr1 == ", join(", ", @lArr1), "\n";

# shift and unshift: same as pop and push, but for the array front

# ##############################################
# Remove elements with the splice operator 
@lArr5 = (1, 2, 3, 4, 5);
@lArr51 = splice @lArr5, 2; # @lArr51 == (3, 4, 5, )
print "\@lArr5 == ", join(", ", @lArr5), "\n";
print "\@lArr51 == ", join(", ", @lArr51), "\n";

@lArr5 = (1, 2, 3, 4, 5);
@lArr51 = splice @lArr5, 2, 2; # @lArr51 == (3, 4, )
print "\@lArr5 == ", join(", ", @lArr5), "\n";
print "\@lArr51 == ", join(", ", @lArr51), "\n";

@lArr5 = (1, 2, 3, 4, 5);
@lArr51 = splice @lArr5, 2, 0, (6, 7, ); 
print "\@lArr5 == ", join(", ", @lArr5), "\n"; # @lArr5 == (1, 2, 3, 6, 7, 4, 5, )
print "\@lArr51 == ", join(", ", @lArr51), "\n"; # @lArr1 == ()

# Array interpolation into a string
print "\@lArr5 == @lArr5\n"; # @lArr5 == 1 2 6 7 3 4 5

# When a string is used in a numeric expression, Perl converts
# the string to number until the first non-number element in the string.
# Hence, $nZ == 4 - 1 == 3 and not 12 - 1 == 11
$sY = "4*3";
$nZ = $sY - 1;
print "$sY - 1; $nZ\n";

# foreach statement
foreach $nElem (@lArr5) {
    print "\$nElem == $nElem, ";
    # The control variable ($nElem) is the reference to the list elements
    # Changing it changes the list elements
    # @lArr5 == 2 3 7 8 4 5 6 after the loop
    $nElem += 1;
}
print "\n\@lArr5 == @lArr5\n";

# The value of control variable ($nControlVar) remains the same after the foreach
$nControlVar = 1;
foreach $nControlVar (1,2,3) {
    print "$nControlVar, ";
}
print "\$nControlVar == $nControlVar\n"; # $nControlVar = 1

# The favorite default var $_
foreach (1..3) {
    print "\$_ == $_\n";
    print ; # Prints the same $_
}

# The reverse operator
@lArr7 = (1,2,3,);
@lArr7 = reverse(@lArr7);
print "\@lArr7 == @lArr7\n"; # 3 2 1

# The sort operator by default sorts in Unicode postcodes order.
# By default, the numbers are sorted as strings.
@lArr8 = 97..102;
@lArr8 = sort(@lArr8); # @lArr8 == 100 101 102 97 98 99
print "\@lArr8 == @lArr8\n";

# The each operator returns the index and the value
@lArr9 = qw / e1 e2 e3 /;
while (($nIndex, $sElem) = each @lArr9){
    print "\$nIndex, \$sElem == $nIndex, $sElem\n";
}

# List producing expressions in the scalar context
$sReversed = reverse qw / one two three /;
@lReversed = reverse qw / one two three /;
# $sReversed == eerhtowteno; @lReversed == three two one 
print "\$sReversed == $sReversed; \@lReversed == @lReversed\n";

# `scalar` forces scalar context: @lReversed == three two one; scalar @lReversed == 3
print "\@lReversed == @lReversed; ", 'scalar @lReversed == ', scalar @lReversed, "\n";

# `<STDIN>` in list context returns a list of the input strings until EOF - 
# Ctrl-D on Linux, Ctrl-Z on Windows
# print "Enter lines and press Ctrl-Z or D:\n";
# chomp(@lInputs = <STDIN>);
# print "\@lInputs == @lInputs\n"; # @lInputs == l1 l2 l3

