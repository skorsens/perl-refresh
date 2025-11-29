#!/usr/bin/perl
use strict;
use warnings;

=head1 NAME

print_aligned.pl - A Perl module for processing and displaying ANSI escape sequence formatted text

=head1 SYNOPSIS

    require './print_aligned.pl';

    my $ansi_text = "[5;1HTest Result[5;36H: PASSED\n[0m\n";
    print_results($ansi_text);

=head1 DESCRIPTION

This module provides functionality to process text containing ANSI escape sequences
and display it in a clean, aligned format without the escape codes.

=head1 SUBROUTINES

=head2 print_results($sResults)

Processes a multiline string containing ANSI escape sequences and prints it
in a clean, aligned format.

=head3 Parameters

=over 4

=item * C<$sResults> - A multiline string that may contain ANSI escape sequences

The input string can contain:

=over 8

=item * Cursor positioning sequences (e.g., C<[5;36H>)

=item * Reset sequences (C<[0m>)

=item * Color/formatting sequences (e.g., C<[1;32m>)

=item * Regular text content

=back

=back

=head3 Behavior

=over 4

=item * Converts cursor positioning sequences to appropriate spacing for alignment

=item * Strips all ANSI escape sequences from the output

=item * Skips lines containing only reset sequences (C<[0m>)

=item * Limits consecutive empty lines to maximum of 1

=item * Maintains proper column alignment as specified by cursor positioning

=back

=head3 Example

Input with escape sequences:
    [5;1HTest Start Time[5;36H  :  2025-11-27 20:17:05
    [0m
    [6;1HElapsed Time[6;36H  :  0:00:05

Output:
    Test Start Time                      :  2025-11-27 20:17:05
    Elapsed Time                         :  0:00:05

=head3 Returns

This subroutine does not return a value. It prints directly to STDOUT.

=cut

sub print_results {
    my ($sResults) = @_;

    # Split the input into lines for processing
    my @lines = split /\n/, $sResults;

    # Process lines and reduce consecutive empty lines
    my @processed_lines;
    my $consecutive_empty = 0;

    for my $line (@lines) {
        # Skip lines that contain only [0m reset sequences
        if ($line =~ /^\[0m\s*$/) {
            next;
        }

        # Process each line to handle escape sequences
        my $processed_line = process_line($line);

        # Check if this is an empty line (only whitespace or nothing)
        if ($processed_line =~ /^\s*$/) {
            $consecutive_empty++;
            # Only allow maximum 1 consecutive empty line
            if ($consecutive_empty <= 1) {
                push @processed_lines, $processed_line;
            }
        } else {
            $consecutive_empty = 0;
            push @processed_lines, $processed_line;
        }
    }

    # Print the processed lines
    for my $line (@processed_lines) {
        print $line . "\n";
    }
}

=head2 process_line($line)

Helper subroutine that processes a single line containing ANSI escape sequences
and converts it to plain text with proper spacing.

=head3 Parameters

=over 4

=item * C<$line> - A single line of text that may contain ANSI escape sequences

=back

=head3 Processing Logic

=over 4

=item * Parses escape sequences character by character

=item * Converts cursor positioning sequences (C<[ROW;COLUMNH>) to spaces

=item * Strips color and formatting sequences (C<[0m>, C<[1;32m>, etc.)

=item * Preserves regular text content

=item * Calculates proper spacing to maintain column alignment

=back

=head3 Returns

Returns a string with escape sequences removed and proper spacing applied.

=cut

sub process_line {
    my ($line) = @_;
    my $result = "";
    my $pos = 0;
    my $current_row = 1;
    my $current_col = 1;

    while ($pos < length($line)) {
        # Look for escape sequence starting with [
        if (substr($line, $pos, 1) eq '[') {
            # Find the end of the escape sequence (ends with a letter)
            my $seq_start = $pos;
            my $seq_end = $pos + 1;

            while ($seq_end < length($line)) {
                my $char = substr($line, $seq_end, 1);
                if ($char =~ /[a-zA-Z]/) {
                    last;
                }
                $seq_end++;
            }

            if ($seq_end < length($line)) {
                my $escape_seq = substr($line, $seq_start, $seq_end - $seq_start + 1);

                # Handle cursor positioning sequences like [5;1H
                if ($escape_seq =~ /^\[(\d+);(\d+)H$/) {
                    my ($row, $col) = ($1, $2);

                    # Calculate spaces needed to reach the target column
                    my $current_length = length($result);
                    if ($col > $current_length + 1) {
                        $result .= ' ' x ($col - $current_length - 1);
                    }

                    $current_row = $row;
                    $current_col = $col;
                }
                # Handle reset sequences [0m - we can ignore these for alignment
                elsif ($escape_seq eq '[0m') {
                    # Do nothing - just skip the reset sequence
                }
                # Handle other formatting sequences - ignore for now
                elsif ($escape_seq =~ /^\[\d*(;\d*)*m$/) {
                    # Skip color/formatting sequences
                }

                $pos = $seq_end + 1;
            } else {
                # No complete escape sequence found, treat as regular character
                $result .= substr($line, $pos, 1);
                $pos++;
            }
        } else {
            # Regular character, add to result
            $result .= substr($line, $pos, 1);
            $pos++;
        }
    }

    return $result;
}

=head2 test_print_results()

Test function that demonstrates the usage of C<print_results()> with sample data
containing various ANSI escape sequences typically found in MemTest86 output.

=head3 Parameters

None.

=head3 Behavior

=over 4

=item * Creates sample test data with ANSI escape sequences

=item * Calls C<print_results()> to process and display the data

=item * Shows before/after comparison of formatted output

=back

=head3 Returns

None. Prints test results to STDOUT.

=cut

# Test function to demonstrate usage
sub test_print_results {
    my $sample_data = <<'EOF';
[0m
PassMark Software
[0m
www.passmark.com
[0m

[0m
[5;1HTest Start Time[5;36H  :  2025-11-27 20:17:05
[0m
[6;1HElapsed Time[6;36H  :  0:00:05
[0m
[7;1HCPUs Active[7;36H  :  6
[0m
[8;1HCPU Temperature (Min/Max/Ave)[8;36H  :  38C/38C/38C
[0m
[9;1HRAM Temperature (Min/Max/Ave)[9;36H  :  -/-/-
[0m
[10;1HLowest memory speed[10;36H  :  N/A
[0m
[11;1HHighest memory speed[11;36H  :  N/A
[0m
[12;1H# Tests Completed[12;36H  :  1/1 (100%)
[0m
[13;1H# Tests Passed[13;36H  :  1/1 (100%)
[0m

[0m
[15;1HLowest Error Address[15;36H  :  N/A
[0m
[16;1HHighest Error Address[16;36H  :  N/A
[0m
[17;1HBits in Error Mask[17;36H  :  0000000000000000
[0m
[18;1HBits in Error[18;36H  :  Total: 0   Min: 0   Max: 0   Avg: 0
[0m
[19;1HMax Contiguous Errors[19;36H  :  0
[0m


[0m
EOF

    print "=== Testing print_results ===\n";
    print_results($sample_data);
}

# Allow the module to be used as a library or run directly for testing
if ($0 eq __FILE__) {
    test_print_results();
}

=head1 USAGE

This module can be used in two ways:

=head2 As a library

    require './print_aligned.pl';
    my $output = get_memtest_output();  # Your ANSI formatted text
    print_results($output);

=head2 Standalone testing

    perl print_aligned.pl

This will run the built-in test with sample MemTest86 output.

=head1 COMPATIBILITY

This module is compatible with Perl 5.16.3 and later versions. It uses only
core Perl functionality and has no external dependencies.

=head1 LIMITATIONS

=over 4

=item * Only processes cursor positioning sequences of the form C<[ROW;COLUMNH>

=item * Does not handle more complex ANSI sequences like cursor movement commands

=item * Assumes text flows left-to-right only

=item * Limited to processing sequences that fit in memory as strings

=back

=head1 AUTHOR

Generated for perl-refresh project.

=head1 VERSION

Version 1.0

=head1 SEE ALSO

=over 4

=item * L<perldoc perlpod> - POD documentation format

=item * ANSI escape sequence documentation

=item * MemTest86 documentation

=back

=cut

1; # Return true for module loading
