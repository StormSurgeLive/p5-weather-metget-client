package Weather::MetGet::Client;

use strict;
use warnings;

use HTTP::Tiny ();
use Util::H2O qw/h2o/;

sub new {
    my $pkg  = shift;
    my %self = @_;
    my $self = bless \%self, $pkg;
    $self->{__ua} = HTTP::Tiny->new( default_headers => { q{x-api-key} => $self->{apikey} } );
    return $self;
}

sub status {
    my $self     = shift;
    my $url      = sprintf( "%s%s", $self->{baseurl}, q{/status} );
    my $response = $self->{__ua}->get($url);
    return $response->{content};
}

1;
__END__
=head1 NAME

Weather::MetGet::Client - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Weather::MetGet::Client;
  blah blah blah

=head1 DESCRIPTION

=head1 SEE ALSO

=head1 COPYRIGHT AND LICENSE

=cut
