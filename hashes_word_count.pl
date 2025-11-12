use strict;

my %dWords = ();

print "Enter the words to count.\n";

print "Next word: ";
while (<STDIN>){
    chomp;
    $dWords{$_}++;
    print "Next word: ";
}

my %dWordsInversed = reverse %dWords;

print "The words count:\n";
foreach my $nCount (sort keys %dWordsInversed) {
    print "$dWordsInversed{$nCount} => $nCount\n";
}
