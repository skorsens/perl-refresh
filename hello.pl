use v5.10;
print "Hello from Perl\n";
say "Hello from Perl by say";

@perldocLines = `perldoc -u -f atan2`;

foreach (@perldocLines){
    s/\w<(.+?)>/\U$1/g;
    print;
}
