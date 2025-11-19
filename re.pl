use strict;
use warnings FATAL => 'all';


# . == \N matches aby character except newline
$_ = "abc";

if (/a.c/){
    print "$_ matches pattern a.c\n";
}
else {
    print "$_ does not match pattern a.c\n";
}
if (/a\Nc/){
    print "$_ matches pattern a\\Nc same as a.c\n";
}
else {
    print "$_ does not match pattern a\\Nc\n";
}


# Grouping and back references
$_ = 'abcabc';

my $sResult = '';
$sResult= (/(abc)+/) ? "$_ matches (abc)+\n" : "$_ does not match (abc)+\n";
print "$sResult";

$_ = 'abbcbbd';
$sResult = (/(..)c\1/) ? "$_ matches /(..)c\\1/\n" : "$_ does not match /(..)c\\1/\n";
print "$sResult";

# Denoting groups with \g{N} syntax dis-ambiguates the \N syntax
$_ = 'abbcbbd';
$sResult= (/(..)c\g{1}/) ? "$_ matches /(..)c\\g\{1\}/\n" : "$_ does not match /(..)c\\g\{1\}/\n";
print "$sResult";

# Negative group number refers to the previous group
$_ = 'abbcbbd';
$sResult= (/(..)c\g{-1}/) ? "$_ matches /(..)c\\g\{-1\}/\n" : "$_ does not match /(..)c\\g\{-1\}/\n";
print "$sResult";

# ######################################################
# Anchors:
# String boundary anchors: \A (or ^) - string beginning; \z (or $) - string end; \Z - string end or optional new line
$_ = 'https://abc';
$sResult= (/\Ahttps/) ? "$_ matches /\\Ahttps/\n" : "$_ does not match /\\Ahttps/\n";
print "$sResult";
$_ = '://abchttps';
$sResult= (/\Ahttps/) ? "$_ matches /\\Ahttps/\n" : "$_ does not match /\\Ahttps/\n";
print "$sResult";
$sResult= (/https\z/) ? "$_ matches /https\\z/\n" : "$_ does not match /https\\z/\n";
print "$sResult";
$_ = 'https://abc';
$sResult= (/https\z/) ? "$_ matches /https\\z/\n" : "$_ does not match /https\\z/\n";
print "$sResult";

# Word anchors: \b matches word boundaries, e.g. /\bbbc\b/ matches "the bbc news"m but not "thebbcnews"
# \B is the opposite of \b

# The match operator: // is the shortcut for m//; any delimiter can be used, e.g. m{}

system("dir");
