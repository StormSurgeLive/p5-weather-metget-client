package Weather::MetGet::Client;

use strict;
use warnings;

use HTTP::Tiny ();
use Util::H2O qw/h2o/;

our $VERSION = q{0.789};

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

=head2 API Specification

L<https://app.swaggerhub.com/apis/zcobell-dev/MetGet/0.0.1#/info>

=head2 Supported Endpoints

This module is a work in progress and currently experimental. It
currently only supports C</status>, but in order to be actually
useful, will need to support the C</build> endpoint, the checking
of file C<readiness>, and the downloading of these files.

=head2 General Workflow

The process by which this service works is:

A POST request to make files available (blended or whatnot) are  made
via the C</build> endpoint. In return, JSON is returned and provides
links from which to download the readied files at some point in the
future.

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
