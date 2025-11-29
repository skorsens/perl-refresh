
#!/usr/bin/perl
use strict;
use warnings;

# Import the print_aligned module
require './print_aligned.pl';

# Example usage
my $sample_output = <<'EOF';
[0m
[5;1HTest Start Time[5;36H  :  2025-11-27 20:17:05
[0m
[6;1HElapsed Time[6;36H  :  0:00:05
[0m
[7;1HCPUs Active[7;36H  :  6
[0m
EOF

print "Original with escape sequences:\n";
print $sample_output;
print "\n" . "=" x 50 . "\n";
print "Processed output:\n";
print_results($sample_output);
