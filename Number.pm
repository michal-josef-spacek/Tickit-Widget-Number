package Tickit::Widget::Number;

use base qw(Tickit::Widget);
use strict;
use warnings;

use Class::Utils qw(set_params split_params);
use Readonly;
use Unicode::UTF8 qw(decode_utf8);

# Constants.
Readonly::Scalar our $BLANK_PIXEL => q{  };
Readonly::Scalar our $EMPTY_STR => q{};
Readonly::Scalar our $PIXELS => 14;
Readonly::Scalar our $PIXELS_ON_LINE => 3;

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Get object constructor parameters and other parameters for inherited
	# object.
	my ($object_params_ar, $other_params_ar) = split_params(
                ['fill_char', 'number'], @params);

	# Create object.
	my $self = $class->SUPER::new(@{$other_params_ar});

	# Fill character.
	$self->{'fill_char'} = decode_utf8('█');

	# Number in widget.
	$self->{'number'} = '0';

	# Process.
	set_params($self, @{$object_params_ar});

	# Return object.
	return $self;
}

sub cols {
	return 6;
}

sub lines {
	return 5;
}

sub render_to_rb {
	my ($self, $rb, $rect) = @_;

	$rb->eraserect($rect);

	$self->_text($rb);

	return;
}

# Return structure of pixels.
sub _num {
	my $number = shift;

	return [
		[1,1,1,1,0,1,1,0,1,1,0,1,1,1,1], # 0
		[0,0,1,0,0,1,0,0,1,0,0,1,0,0,1], # 1
		[1,1,1,0,0,1,1,1,1,1,0,0,1,1,1], # 2
		[1,1,1,0,0,1,1,1,1,0,0,1,1,1,1], # 3
		[1,0,1,1,0,1,1,1,1,0,0,1,0,0,1], # 4
		[1,1,1,1,0,0,1,1,1,0,0,1,1,1,1], # 5
		[1,1,1,1,0,0,1,1,1,1,0,1,1,1,1], # 6
		[1,1,1,0,0,1,0,0,1,0,0,1,0,0,1], # 7
		[1,1,1,1,0,1,1,1,1,1,0,1,1,1,1], # 8
		[1,1,1,1,0,1,1,1,1,0,0,1,1,1,1], # 9
	]->[$number];
}

# Convert number to text.
sub _text {
	my ($self, $rb) = @_;

	my $text = $EMPTY_STR;
	my $num_ar = _num($self->{'number'});
	my $line = 0;
	foreach my $i (0 .. $PIXELS) {
		if ($num_ar->[$i]) {
			$text .= $self->{'fill_char'} x 2;
		} else {
			$text .= $BLANK_PIXEL;
		}
		if ($i == $PIXELS || ($i + 1) % $PIXELS_ON_LINE == 0) {
			$rb->text_at($line, 0, $text);
			$line++;
			$text = $EMPTY_STR;
		}
	}

	return $text;
}

1;

__END__

=pod

=encoding utf8

=head1 NAME

Tickit::Widget::Number - Tickit Widget for number.

=head1 SYNOPSIS

 use Tickit;
 use Tickit::Widget::Number;

 my $number = Tickit::Widget::Number->new(
         'number' => 7,
 );
 Tickit->new('root' => $number)->run;

=head1 DESCRIPTION

This is a widget that shows a number in graphic form. Minimal size of widget is 6x5.

=head1 METHODS

=head2 C<new>

 my $obj = Tickit::Widget::Number->new(%params);

Constructor.

Widget uses parameters from L<Tickit::Widget>.

=head3 Specific parameters for this Widget

=over 8

=item * C<fill_char>

Fill character.

Default value is '█'.

=item * C<number>

Number to view.

Default value is 0.

=back

=head2 C<cols>

Number of columns.

Returns 6.

=head2 C<lines>

Number of lines.

Returns 5.

=head2 C<render_to_rb>

Render the number.

Returns undef.

=head1 EXAMPLE

=for comment filename=tickit_widget_five.pl

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

=head1 DEPENDENCIES

L<Class::Utils>,
L<Tickit::Widget>,
L<Readonly>,
L<Unicode::UTF8>.

=head1 SEE ALSO

=over

=item L<Curses::UI::Number>

Create and manipulate number widgets.

=back

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Tickit-Widget-Number>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2020-2024 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.01

=cut
