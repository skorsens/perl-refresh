use strict;

my %d1 = ();
%d1 = ('k1', 'v1', 'k2', 'v2');
my @a1 = %d1; 
print "\@a1 == @a1\n"; # @a1 == k2 v2 k1 v1
my $n1 = %d1;
print "\$n1 == $n1\n"; # $n1 == 2/8 (nKeys/nBuckets)
$n1 = scalar(keys %d1);
print "\$n1 == $n1\n"; # $n1 == 2

# Inversing a hash
my %dInversed = reverse %d1;
@a1 = %dInversed;
print "\@a1 == @a1\n"; # @a1 == v1 k1 v2 k2

# The arrow =>
my %h2 = (
    'k1' => 'v1',
    'k2' => 'v2',
);

# It is possible to omit the '' for simple keys
my %h3 = (
    k1 => 'v1',
    k2 => 'v2',
);

# Reference an element
print "\$h3{'k1'} == $h3{'k1'}\n";
print "\$h3{k1}   == $h3{k1}\n";

# Getting keys and values
my @lH3Keys = keys %h3;
my @lH3Values = values %h3;
print "\@lH3Keys == @lH3Keys; \@lH3Values == @lH3Values\n";

# Getting the number of elements in the hash
$n1 = keys %d1;
print "\$n1 == $n1\n"; # $n1 == 2

# Iterating over hash
while (my($k, $v) = each %h3){
    print "\$k == $k; \$v == $v\n";
}

# Iterating over hash in the sorted order of keys
foreach my $k (sort keys %h3){
    print "$k => $h3{$k}\n";
}

# Insert value into hash
$h3{k3} = "v3";
while (my($k, $v) = each %h3) {
    print "$k => $v\n";
}

# Check if a key is in a hash
if (exists $h3{k1}){
    print "key k1 is in the hash \%h3\n";
}

if (! exists $h3{k4}){
    print "key k4 is NOT in the hash \%h3\n";
}

# Deleting an entry for a hash
print "delete \$h3{k1}:\n";
delete $h3{k1};
while (my($k, $v) = each %h3){
    print "$k => $v\n";
}

# The environment hash
print "The %ENV:\n";
foreach my $k (keys %ENV){
    print "$k => $ENV{$k}\n";
}
