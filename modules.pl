use strict;
# Import all the functions from the module `File::Basename`
use File::Basename;
# Import only the `basename` function from the module `File::Basename`
# use File::Basename qw / basename /;
# Import no functions from the module `File::Basename`, but use them as e.g.
# `File::Basename::basename $sFilePath;`
# use File::Basename ();
# or
# use File::Basename qw/ /;

my $sFilePath = "/usr/local/bin/perl";
my $sFileBaseName = basename $sFilePath;
print "\$sFileBaseName == $sFileBaseName\n";

# Functions in the OO modules can be used only with the name of the module and class
use File::Spec;

my $sDirName = "/usr/local";
my $sNewFilePath = File::Spec->catfile($sDirName, $sFileBaseName);
print "\$sNewFilePath == $sNewFilePath\n";

# Needs to be installed using `cpan Path::Class`
use Path::Class;
my $dir = dir('a', 'b', 'c');
print "\$dir == $dir\n";
