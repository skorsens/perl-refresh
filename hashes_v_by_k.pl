use strict;

my %d = (
    k1 => 'v1',
    k2 => 'v2',
    k3 => 'v3',
);

print "Enter the keys (Ctrl-Z to exist):\n";
while (<STDIN>){
    chomp;
    my $v = $d{$_};
    if ($v){
        print "$_ => $v\n";
    }
    else {
        print "$_ not found\n";
    }
}
