use strict;
use feature 'state';

# <STDIN> operator is used to read from stdin
sub ReadFromStdin {
    my $sStdin = ();
    chomp($sStdin = <STDIN>);
    print "\$sStdin == $sStdin\n";
}
# &ReadFromStdin;

# `<STDIN>` returns `undef` when reaching the EOF
sub ReadFromStdinUntilEof {
    my $sLine = undef;

    while (defined($sLine = <STDIN>)){
        print "\$sLine = $sLine";
    }
}
# &ReadFromStdinUntilEof;

# The diamond operator `<>` is used to read the inputs from the command line arguments.
# The arguments can be file names and/or `-`. In the latter case, the input is read from 
# the stdin
sub UseDiamondOp {
    while (<>) {
        chomp;
        print "\$_ == $_\n";
    }
}
# &UseDiamondOp;
# Run perl io.pl f1.txt - f2.txt
# $_ == f1.txt, line1
# $_ == f1.txt, line2
# l1
# $_ == l1
# l2
# $_ == l2
# ^Z
# $_ == f2.txt, line1
# $_ == f2.txt, line2

# The double-diamond operator `<<>>` requires use v5.22 and prevents treating `|` in
# the input file name as a pipe

# Command line params: @ARGV
print "\@ARGV == @ARGV\n";

print @ARGV, "\n"; # List of items with no spaces 123
print "@ARGV\n"; # Interpolated string 1 2 3

# Running `perl io.pl f1.txt` prints the contents of `f1.txt`
# print <>;

# Formatting with `printf` operator
# %x - hex
# %o - oct
my $s = "abc";
my $d = 2;
my $f = 2.3;
printf "printf: \$s == %s; \$d == %d; \$f == %g\n", $s, $d, $f;
printf "printf: \$s == %5s; \$d == %5d; \$f == %5g\n", $s, $d, $f;
printf "printf: \$s == %-5s; \$d == %-5d; \$f == %-5g\n", $s, $d, $f;
printf "printf: %%\n"; # %
printf "printf: \$s == %*s\n", 5, $s; # Width as an argument
printf "printf: \$s == %-*s\n", 5, $s; # Width as an argument


# Filehandles
# Filehandles reserved by Perl: STDIN, STDOUT, STDERR, DATA, ARGV, ARGVOUT
open F1TXT, '<', 'f1.txt'; # Open a file for read `<`, write `>`, append `>>`
print "f1.txt:\n";
print <F1TXT>;

# It is possible to specify the encoding and check the result of the `open`
my $bOpenResult = open F1TXT, '<:encoding(UTF-8)', 'f1.txt'; # Open a file for read `<`, write `>`, append `>>`
print "f1.txt:\n";
print <F1TXT>;
print "\$bOpenResult == $bOpenResult\n";
close F1TXT; # Perl closes a file handle automatically if it is re-opend or on exit

$bOpenResult = open F11TXT, '<:encoding(UTF-8)', 'f11.txt'; # Open a file for read `<`, write `>`, append `>>`
print "f11.txt:\n";
print <F11TXT>;
print "\$bOpenResult == $bOpenResult\n";
print "\$! == $!\n"; # $! == No such file or directory

# The `warn` function
warn "Wanring message: $!";   # Wanring message: No such file or directory at io.pl line 89.
warn "Wanring message: $!\n"; # Wanring message: No such file or directory

# `use autodie` pragma can be used to automatically call `die` in case of errors

# It is possible to specify a file handler
print STDERR "Printing to STDERR\n";

# Change the default file handle (replace STDOUT with STDERR)
select STDERR;
print "Replacing STDOUT by STDERR\n";
select STDOUT;

# It is possible to re-open a standard file handle
# Save original STDERR
open my $orig_stderr, ">&", \*STDERR or die "Can't dup STDERR: $!";

open STDERR, ">>", "stderr_file.txt" or die "Cannot open stderr_file.txt: $!";
warn "Writing to STDERR-> stderr_file.txt";

# Restore STDERR
open STDERR, ">&", $orig_stderr or die "Can't restore STDERR: $!";
warn "Writing to STDERR";

# File handles can be stored in scalar vars
open my $f2_txt_handler, '<', 'f2.txt' or die "Could not open f2.txt: $!";
print "f2.txt: \n";
print <$f2_txt_handler>;
