#!/usr/bin/env perl

use strict;
use warnings;

use Tickit;
use Tickit::Widget::Number;

# Number widget.
my $number = Tickit::Widget::Number->new(
        'number' => 5,
);

# Loop.
Tickit->new('root' => $number)->run;

# Output like:
# ██████
# ██
# ██████
#     ██
# ██████