use strict;
use warnings;

use Test::NoWarnings;
use Test::Pod::Coverage 'tests' => 2;

# Test.
pod_coverage_ok('Tickit::Widget::Number', 'Tickit::Widget::Number is covered.');
