#!/usr/bin/perl

use strict;
use warnings;
use IO::File;
use Data::Dumper;

MAIN:{

use Pod::Usage;

=head1 NAME

  liar-liar.pl

=head1 SYNOPSIS


  liar-liar.pl INPUT_FILE

=head1 DESCRIPTION

As a newbie on a particular internet discussion board, you notice a distinct trend among its veteran members; everyone seems to be either unfailingly honest or compulsively deceptive. You decide to try to identify the members of the two groups, starting with the assumption that every senior member either never lies or never tells the truth. You compile as much data as possible, asking each person for a list of which people are liars. Since the people you are asking have been around on the board for a long time, you may assume that they have perfect knowledge of who is trustworthy and who is not. Each person will respond with a list of people that they accuse of being liars. Everyone on the board can see that you are a tremendous n00b, so they will grudgingly give you only partial lists of who the liars are. Of course these lists are not to be taken at face value because of all the lying going on. 

You must write a program to determine, given all the information you've collected from the discussion board members, which members have the same attitude toward telling the truth. It's a pretty popular discussion board, so your program will need to be able to process a large amount of data quickly and efficiently. 


=head2 Input Specifications

Your program must take a single command line argument; the name of a file. It must then open the file and read out the input data. The data begins with the number of veteran members n followed by a newline. It continues with n chunks of information, each defining the accusations made by a single member. Each chunk is formatted as follows:
 <accuser name> <m>
followed by m lines each containing the name of one member that the accuser says is a liar. accuser name and m are separated by some number of tabs and spaces. m will always be in [0, n]. All member names contain only alphabetic characters and are unique and case-sensitive. 


=head3 Example input file:

=over 4

    5
   Stephen   1
   Tommaso
   Tommaso   1
   Galileo
   Isaac     1
   Tommaso
   Galileo   1
   Tommaso
   George    2
   Isaac
   Stephen

=back

=head2 Output Specifications

Your output must consist of two numbers separated by a single space and followed by a newline, printed to standard out. The first number is the size of the larger group between the liars and the non-liars. The second number is the size of the smaller group. You are guaranteed that exactly one correct solution exists for all test data. 

=head3 Example output:

=over 4

   3 2

=back

=cut

sub main
{

   my ($filename) = @_;
   pod2usage({ 
        -message => "Input file needed." ,
        -exitval => 2,
        -verbose => 2
   }) if !$filename || $filename =~m/^\s*$/;
   my $fh = IO::File->new( "< $filename");
   pod2usage({ 
        -message => "Unable to read input file $filename" ,
        -exitval => 2,
        -verbose => 2
   }) unless $fh;

   my %accusition_table;
   my $number_entries = <$fh>;
   chomp($number_entries);

   while( my $line = <$fh> ){
      next if $line =~/^\s*$/;
      my ($name, $number_accused) = $line =~ m/^\s*(\w+)\s+(\d+)\s*$/;
      $accusition_table{$name} = {};
      for( my $i = 0; $i < $number_accused; $i++ ){
         my $the_accused = <$fh>;
         chomp($the_accused);
         $accusition_table{$name}->{$the_accused} = 1;
      }
   }
   undef $fh; #auto close out file.

   foreach my $key (keys %accusition_table ){
      my $sub_hash = $accusition_table{$key};
      foreach my $sub_key (keys %$sub_hash){
         $accusition_table{$sub_key}->{$key} = 1;
      }
   }

   my %friends;

   foreach my $key (keys %accusition_table ){
      my $sub_hash = $accusition_table{$key};
      $friends{$key} = {};
      foreach my $sub_key (keys %$sub_hash){
         my $esub_hash = $accusition_table{$sub_key};
         foreach my $esub_key (keys %$esub_hash){
            $friends{$key}->{$esub_key} = 1;
         }
      }
   }


   foreach my $key (keys %friends ) {

      my $sub_hash = $friends{$key};
      my %foo = 
       map{ $_ => 1 }
       map{ keys %{$friends{$_}} } keys %$sub_hash;
      $friends{$key} = \%foo;
   }

   my @groups;
   foreach my $key (keys %friends ){
      next unless defined $friends{$key};

      my $sub_hash = $friends{$key};
      push( @groups, scalar(keys %$sub_hash));

      delete $friends{$_} foreach (keys %$sub_hash);
      
   }

   print join( ' ', sort { $b <=> $a } @groups)."\n";

}


main(@ARGV);


}
