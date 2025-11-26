# Refernce to a hash
my @required = qw(preserver sunscreen water_bottle jacket);
my %skipper  = map { $_, 1 } qw(blue_shirt hat jacket preserver sunscreen);
my %gilligan = map { $_, 1 } qw(red_shirt hat lucky_socks water_bottle);
my %professor = map { $_, 1 } qw(sunscreen water_bottle slide_rule batteries radio);

sub print_hash {
    my $sHashName = shift;
    my $HashRef = shift;
    print "Hash name == $sHashName\n";

    foreach my $key (keys %{ $HashRef }) {
        print "$key => $HashRef->{$key}\n";
    }
}

print_hash("skipper", \%skipper);
print_hash("gilligan", \%gilligan);
print_hash("professor", \%professor);

# Reference to an array
my @skipper = qw(blue_shirt hat);
my @gilligan = qw(red_shirt hat);

sub print_array {
    my $sArrayName = shift;
    my $ArrayRef = shift;
    print "Array name == $sArrayName\n";

    for my $i (0 .. $#{ $ArrayRef } ) {
        # Shortcut: ${$ArrayRef}[$i] == $ArrayRef->[$i]
        unless ( ${ $ArrayRef }[$i] == $ArrayRef->[$i]){
            print "${ $ArrayRef }[$i] != $ArrayRef->[$i]\n";
        }
        print "$i: $ArrayRef->[$i]\n";
    }
}

print_array("skipper", \@skipper);
print_array("gilligan", \@gilligan);

# Reference to a scalar
my $n = 10;
my $nRef = \$n;

print "\$n == $n\n";
print "\$nRef == $nRef\n";
print "\${\$nRef} == ${ $nRef }\n";

${ $nRef } = 12;
print "\$n == $n\n";
print "\$nRef == $nRef\n";
print "\${\$nRef} == ${ $nRef }\n";


sub calculate_fibonacci {
    my $n = shift;
    return 0 if $n == 0;
    return 1 if $n == 1;
    my ($a, $b) = (0, 1);
    for (my $i = 2; $i <= $n; $i++) {
        my $next = $a + $b;
        $a = $b;
        $b = $next;
    }
    return $b;
    
# Simple assert subroutine
sub assert {
    my ($cond, $msg) = @_;
    die "Assertion failed: $msg\n" unless $cond;
}

# Tests for calculate_fibonacci
assert(calculate_fibonacci(0) == 0, "Fibonacci of 0 should be 0");
assert(calculate_fibonacci(1) == 1, "Fibonacci of 1 should be 1");
assert(calculate_fibonacci(2) == 1, "Fibonacci of 2 should be 1");
assert(calculate_fibonacci(3) == 2, "Fibonacci of 3 should be 2");
assert(calculate_fibonacci(5) == 5, "Fibonacci of 5 should be 5");
assert(calculate_fibonacci(10) == 55, "Fibonacci of 10 should be 55");
}
