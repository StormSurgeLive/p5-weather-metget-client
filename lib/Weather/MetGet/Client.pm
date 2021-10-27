package Weather::MetGet::Client;

use strict;
use warnings;

use HTTP::Tiny ();
use Util::H2O qw/h2o/;

sub new {
    my $pkg  = shift;
    my %self = @_;
    my $self = bless \%self, $pkg;

    # 'x-api-key' is how authentication happens at API request time
    $self->{__ua} = HTTP::Tiny->new( default_headers => { q{x-api-key} => $self->{apikey} } );
    return $self;
}

sub status {
    my $self     = shift;
    my $url      = sprintf( "%s%s", $self->{baseurl}, q{/status} );
    my $response = h2o $self->{__ua}->get($url);
    if ( not $response->success ) {
        die sprintf( qq{%s %s}, $response->status, $response->reason );
    }
    return $response->content;
}

1;
__END__
=head1 NAME

Weather::MetGet::Client - Perl client for C<MetGet> service. 

=head1 SYNOPSIS

  use Weather::MetGet::Client;
  my @OPTIONS = ( apikey => $mykey, baseurl => $baseurl );
  my $metget  = Weather::MetGet::Client->new(@OPTIONS);
  
  # call /status end point
  my $status = $metget->status;

=head1 DESCRIPTION

API client implementing some set of C<MetGet> service calls,
used primarily to support the commandline client included in
this distribution, C<mg>.

=head1 LICENSE AND COPYRIGHT

This file is part of the ADCIRC Surge Guidance System (ASGS).

The ASGS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ASGS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the ASGS.  If not, see <http://www.gnu.org/licenses/>.
