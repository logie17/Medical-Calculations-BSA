use strict;
use warnings;
use Test::More;
use Test::Exception;

use_ok('Medical::Calculations::BSA'); 

my $subject = Medical::Calculations::BSA->new;

is $subject->calculate('height' => '72in', weight => '200lbs'), 2.13228345411884;

dies_ok { $subject->calculate('height' => '72', weight => '200') } 'Unable to parse units';

dies_ok { $subject->calculate('height' => '72ack', weight => '200adlksfj') } 'Unable to parse units';

is $subject->calculate('height' => '72in', weight => '90.90kg'), 2.13219282946652;

is $subject->calculate('height' => '182.88cm', weight => '90.90kg'), 2.13219282946652;

done_testing;

1;
