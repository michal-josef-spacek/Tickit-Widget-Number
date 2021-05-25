use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;

BEGIN {

	# Test.
	use_ok('Tickit::Widget::Number');
}

# Test.
require_ok('Tickit::Widget::Number');
