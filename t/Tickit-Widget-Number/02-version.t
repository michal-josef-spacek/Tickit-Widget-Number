use strict;
use warnings;

use Test::More 'tests' => 2;
use Test::NoWarnings;
use Tickit::Widget::Number;

# Test.
is($Tickit::Widget::Number::VERSION, 0.01, 'Version.');
