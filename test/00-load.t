use Mojo::Base -strict;
use Test::More;

use_ok 'PriorityEyes';
diag "Testing PriorityEyes $PriorityEyes::VERSION, Perl $], $^X";
use_ok 'Mango';
use_ok 'Minion';

done_testing();
