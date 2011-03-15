#!/usr/bin/perl

use strict;
use warnings;

{

local $/=undef; # We want to slurp in the whole file.

=pod

=head1 Hoppity Hop!

To help test whether your puzzle submissions fit the guidelines, try this simple 
test puzzle. Your solution must follow the guidelines like any other puzzle. 
Write a program that takes as input a single argument on the command line. This 
argument must be a file name, which contains a single positive integer. The 
program should read this file and obtain the integer within, and then output a
sequence of strings based upon the number (details below). 


=head1 Input specifications

The input file will contain a single positive integer (in base 10) expressed as
a string using standard ASCII text (e.g. for example, the number "15" but
without the double quotes). This number may or may not be padded on either side
with white space. There will be no commas, periods, or any other non-numeric
characters present within the number. The file may or may not terminate in a
single new line character ("\n"). 

=head2 An example input file is below.

=over 4

15

=back

=head1 Output specifications

The program should iterate over all integers (inclusive) from 1 to the number 
expressed by the input file. For example, if the file contained the number 10,
the submission should iterate over 1 through 10. At each integer value in this
range, the program may possibly (based upon the following rules) output a 
single string terminating with a newline. 

=over 4

=item * For integers that are evenly divisible by three, output the exact string B<Hoppity>, followed by a newline.

=item * For integers that are evenly divisible by five, output the exact string B<Hophop>, followed by a newline.

=item * For integers that are evenly divisible by both three and five, do not do any of the above, but instead output the exact string B<Hop>, followed by a newline.

=back

=cut

print map {
   (( $_ % 3 || $_ % 5 )?    # First let check for the case where both are true.
                             #  since perl see 0 as false, we use negated logic.
              ( $_ % 5 )?    # Next we check for the modulis 3 and 5 mostly so it
              ( $_ % 3 )? '' #  reads like the puzzle requested. At this none matched
                        : 'Hoppity' # This is for the modulis 3
                        : 'Hophop'  # This is for the modulis 5
                        : 'Hop'     # This is for both modulis 3 and 5.
    ) . "\n" # All line end with a newline.
  } 1..<>; # Read in a file containing how many line we want to print out to from 1.

=pod


=head1 Example output (newline at end of every line):

=over 4

    Hoppity
    Hophop
    Hoppity
    Hoppity
    Hophop
    Hoppity
    Hop

=back

=cut

}

