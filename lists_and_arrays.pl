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
$n1 = 1;
$n2 = 2;
@a1 = ($n1, $n2);
print "\@a1 == ", join(", ", @a1), "\n"; # @a1 == (1, 2)
$n1 += 3;
print "\$n1 == $n1\n";
print "\@a1 == ", join(", ", @a1), "\n"; # @a1 == (1, 2)

# The qw (quoted words) operator
@a2 = qw(one two three); # ("one", "two", "three")
print "\@a2 == ", join(", ", @a2), "\n";

# List assignments
($n0, $n1) = (1, 2, 3); # $n0 == 1, $n1 == 2
print "\$n0 == $n0, \$n1 == $n1\n";
($n0, $n1, $n2) = (1, 2, ); # $n0 == 1, $n1 == 2, $n2 == undef
print "\$n0 == $n0, \$n1 == $n1, \$n2 == $n2\n";

# The nested arrays are expanded to their members
@a3 = (@a1, @a2, 7, 8, 9); # @a3 == 1, 2, one, two, three, 7, 8, 9
print "\@a3 == ", join(", ", @a3), "\n";

# Copy arrays
@a4 = @a1;
print "\@a1 == ", join(", ", @a1), "\n";
$a4[0] = 43;
print "\@a4 == ", join(", ", @a4), "\n";

# pop and push
$e1 = pop(@a1); # $e1 == 2, @a1 == (1, )
print "\$e1 == $e1, \@a1 == ", join(", ", @a1), "\n";
push @a1, 2; # @a1 == (1, 2, )
print "\@a1 == ", join(", ", @a1), "\n";

# shift and unshift: same as pop and push, but for the array front

# ##############################################
# Remove elements with the splice operator 
@a5 = (1, 2, 3, 4, 5);
@a51 = splice @a5, 2; # @a51 == (3, 4, 5, )
print "\@a5 == ", join(", ", @a5), "\n";
print "\@a51 == ", join(", ", @a51), "\n";

@a5 = (1, 2, 3, 4, 5);
@a51 = splice @a5, 2, 2; # @a51 == (3, 4, )
print "\@a5 == ", join(", ", @a5), "\n";
print "\@a51 == ", join(", ", @a51), "\n";

@a5 = (1, 2, 3, 4, 5);
@a51 = splice @a5, 2, 0, (6, 7, ); 
print "\@a5 == ", join(", ", @a5), "\n"; # @a5 == (1, 2, 3, 6, 7, 4, 5, )
print "\@a51 == ", join(", ", @a51), "\n"; # @a1 == ()

# Array interpolation into a string
print "\@a5 == @a5\n"; # @a5 == 1 2 6 7 3 4 5

# When a string is used in a numeric expression, Perl converts
# the string to number until the first non-number element in the string.
# Hence, $z == 4 - 1 == 3 and not 12 - 1 == 11
$y = "4*3";
$z = $y - 1;
print "$y - 1; $z\n";

# foreach statement
foreach $e (@a5) {
    print "\$e == $e, ";
    # The control variable ($e) is the reference to the list elements
    # Changing it changes the list elements
    # @a5 == 2 3 7 8 4 5 6 after the loop
    $e += 1;
}
print "\n\@a5 == @a5\n";

# The value of control variable ($cv) remains the same after the foreach
$cv = 1;
foreach $cv (1,2,3) {
    print "$cv, ";
}
print "\$cv == $cv\n"; # $cv = 1

# The favorite default var $_
foreach (1..3) {
    print "\$_ == $_\n";
    print ; # Prints the same $_
}

# The reverse operator
@a7 = (1,2,3,);
@a7 = reverse(@a7);
print "\@a7 == @a7\n"; # 3 2 1

# The sort operator by default sorts in Unicode postcodes order.
# By default, the numbers are sorted as strings.
@a8 = 97..102;
@a8 = sort(@a8); # @a8 == 100 101 102 97 98 99
print "\@a8 == @a8\n";

# The each operator returns the index and the value
@a9 = qw / e1 e2 e3 /;
while (($i, $e) = each @a9){
    print "\$i, \$e == $i, $e\n";
}

# List producing expressions in the scalar context
$s2 = reverse qw / one two three /;
@s2 = reverse qw / one two three /;
# $s2 == eerhtowteno; @s2 == three two one 
print "\$s2 == $s2; \@s2 == @s2\n";

# `scalar` forces scalar context: @s2 == three two one; scalar @s2 == 3
print "\@s2 == @s2; ", 'scalar @s2 == ', scalar @s2, "\n";

# `<STDIN>` in list context returns a list of the input strings until EOF - 
# Ctrl-D on Linux, Ctrl-Z on Windows
# print "Enter lines and press Ctrl-Z or D:\n";
# chomp(@aInputs = <STDIN>);
# print "\@aInputs == @aInputs\n"; # @aInputs == l1 l2 l3

