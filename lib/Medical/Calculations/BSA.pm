package Medical::Calculations::BSA;
use Moo;
use Carp qw(croak carp);

sub calculate
{
    my ( $self, %params) = @_;
    
    $params{type} ||= 'dubois';

    my ($w_type,$weight) = $self->_parse_input($params{weight});
    my ($h_type,$height) = $self->_parse_input($params{height});

    $weight = $w_type eq 'lbs' ? $self->_pound2kilo($weight) : $weight;
    $height = $h_type eq 'in' ? $self->_inches2cm($height) : $height;

    if ( $params{type} eq 'dubois' ) 
    {
        return (($weight**0.425) * ($height**0.725)) * 0.007184;
    }
    elsif ( $params{type} eq 'haycock' )
    {
        return (0.024265 * ($weight**0.5378) * ($height**0.3964));
    }
}

sub _parse_input
{
    my ( $self, $string ) = @_;

    my $type    = $string =~ s/^([\d\.]+?)(lbs|in|cm|kg)?$/$1 && $2 ? $2 : ''/re;
    my $units   = $string =~ s/^([\d\.]+?)(lbs|in|cm|kg)?$/$1/r;

    croak "Unable to parse units" if !$type;

    return ($type, $units);
}

sub _inches2cm
{
    return $_[1]*2.54;
}

sub _pound2kilo
{
    return $_[1]/2.2;
}

1;

# ABSTRACT: Calculate the BSA ( Body Surface Area)

=head1 SYNOPSIS
    
    use Medical::Calculations::BSA;
    my $bsa_object = Medical::Calculations::BSA->new;
    
    my $bsa = $bsa_object->calculate( weight => '180lbs', height => '72in' );

    print $bsa;

=head1 DESCRIPTION

Calculate the BSA (Body Surface Area). The default method of calculation is
"Dubois formula".

Other supported methods include: Mosteller, Haycock, and Grehan.

=head1  METHODS

=item calulate

This method does the actual BSA calculation. 
Parameters: weight, height.

=cut

