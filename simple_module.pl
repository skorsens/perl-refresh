#!/usr/bin/perl
# Simple module file - no package declaration

sub hello_world {
    print "Hello from the required module!\n";
}

sub add_numbers {
    my ($a, $b) = @_;
    return $a + $b;
}

print "Module loaded successfully!\n";

1; # Return true for successful loading
