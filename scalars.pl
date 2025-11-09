use warnings;

###################################################
# Numbers

# Numberic Literals
print "0777 = ", 0777, "\n"; # Base 8
print "0xff = ", 0xff, "\n"; # Base 16
print "0b11 = ", 0b11, "\n"; # Base 2

print "255.01 = ", 255.01, "\n";
print "2.5501e2 = ", 2.5501e2, "\n";

# Numberic Operations
print "3 / 2 = ", 3 / 2, "\n"; # The result is a float
print "3 % 2 = ", 3 % 2, "\n"; # Modulus
print "3.5 % 2.3 = 3 % 2 = ", 3.5 % 2.3, "\n"; # For Modulus floats are truncated to ints
print "3 ** 2 = ", 3 ** 2, "\n"; # Exp

###################################################
# Strings

# String Literals
print "\'Single quoted string\' = ", 'Single quoted string', "\n";
print 'In single quoted string \n is not the new line: ', 'hello\nthere', "\n";
print 'In double quoted string \n is the new line: ', "hello\nthere", "\n";

print "Double quoted string = ", "Double quoted string", "\n";

# String operators
print "hello" . " world = ", "hello" . " world", "\n"; # Concatenation operator
print "hello  x 3.8 = ", "hello " x 3.8, "\n";

###################################################
# Assertions
die "Assertion failed: 2 + 2 != 4" unless 2 + 2 == 4;

###################################################
# Automatic conversion between strings and numbers
print "String . 5 == ", "String " . 5, "\n";
print "5 + 6 == ", "5" + 6, "\n";


###################################################
# Variables

$nVar1 = 10;
$sVar1 = "hello";
print "\$nVar1 == ", $nVar1, "\n";
print "\$sVar1 == ", $sVar1, "\n";

$nVar1 += 5;
print "\$nVar1 += 5 == ", $nVar1, "\n";

# Variables interpolation in strings
$sInterpolated = "Str with interpolated var $nVar1";
print "\$sInterpolated == $sInterpolated\n";
print "\{\$sVar1}_suffix == {$sVar1}_suffix\n";


###################################################
# The if statement, comparison ops and booleans
$sVar2 = "hello world";

if ($sVar1 gt $sVar2){
    print "$sVar1 gt $sVar2\n";
} else {
    print "$sVar1 le $sVar2\n";
}

if ($nVar1 >= 5){
    print "$nVar1 >= 5\n";
} else {
    print "$nVar1 < 5\n";
}

# Boolean values are 0 (false) or 1 (true)
$bVar1 = $nVar1 >= 5;

if ($bVar1){
    print "\$bVar1 is true ($bVar1)\n";
} else {
    print "\$bVar1 is false ($bVar1)\n";
}

if (! $bVar1){
    print "! \$bVar1 is true (!$bVar1)\n";
} else {
    print "! \$bVar1 is false (!$bVar1)\n";
}


###################################################
# Getting user input
print "Type something and press ENTER: ";

# The chomp removes one trailing new line char and returns the number
# of chars removed
# chomp($sInputLine = <STDIN>);
# print "\$sInputLine == $sInputLine\n";

###################################################
#  The while statement
$nCount = 2;

while ($nCount > 0){
    print "\$nCount == $nCount\n";
    $nCount -= 1;
}

###################################################
# The defined function
if (defined($nVarUndefined)) {
    print "\$nVarUndefined is defined\n";
} else {
    print "\$nVarUndefined is undefined\n";
}
