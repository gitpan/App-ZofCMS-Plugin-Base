package App::ZofCMS::Plugin::Base;

use warnings;
use strict;

our $VERSION = '0.0101';

sub new { bless {}, shift }

sub process {
    my ( $self, $template, $query, $config ) = @_;

    my $key = $self->_key;
    return
        unless $template->{$key}
            or $config->conf->{$key};

    my %conf = (
        $self->_defaults,
        %{ delete $config->conf->{$key} || {} },
        %{ delete $template->{$key}     || {} },
    );

    $self->_do( \%conf, $template, $query, $config );
}

sub _key { 'base' }
sub _defaults { () }

1;
__END__

=head1 NAME

App::ZofCMS::Plugin::Base - base class for App::ZofCMS plugins

=head1 SYNOPSIS

    package App::ZofCMS::Plugin::Example;

    use strict;
    use warnings;
    use base 'App::ZofCMS::Plugin::Base';

    sub _key { 'plug_example' }
    sub _defaults { qw/foo bar baz beer/ }
    sub _do {
        my ( $self, $conf, $template, $query, $config ) = @_;
    }

=head1 DESCRIPTION

The module is a base class for L<App::ZofCMS> plugins. I'll safely assume that you've
already read the docs for L<App::ZofCMS>,
L<App::ZofCMS::Config> and L<App::ZofCMS::Template>

The base class (currently) is only for plugins who take their "config" as a single
first-level key in either Main Config File or ZofCMS Template. That key's value
must be a hashref.

=head1 SUBS TO OVERRIDE

=head2 C<_key>

    sub _key { 'plug_example' }

The C<_key> needs to return a scalar contain the name of first level key in ZofCMS template
or Main Config file. Study the source code of this module to find out what it's used for
if it's still unclear.

=head2 C<_defaults>

    sub _defaults { qw/foo bar baz beer/ }

The C<_defaults> sub needs to return a list of default arguments in a key/value pairs.
By default it returns an empty list.

=head2 C<_do>

    sub _do {
        my ( $self, $conf, $template, $query, $config ) = @_;
    }

The C<_do> sub is where you'd do all of your processing. The C<@_> will contain
C<$self, $conf, $template, $query and $config> (in that order) where C<$self> is your
plugin's object, C<$conf> is the plugin's configuration hashref (what the user would specify
in ZofCMS Template or Main Config File, the key of which is returned by C<_key()> sub), the
C<$template> is the hashref of ZofCMS template that is being processed, the C<$query>
is a query parameters hashref where keys are names of the params and values are their values.
Finally, the C<$config> is L<App::ZofCMS::Config> object.

=head1 MOAR!

Feel free to email me the requests for extra functionality for this base class.

=head1 AUTHOR

'Zoffix, C<< <'zoffix at cpan.org'> >>
(L<http://zoffix.com/>, L<http://haslayout.net/>, L<http://zofdesign.com/>)

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-zofcms-plugin-base at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-ZofCMS-Plugin-Base>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::ZofCMS::Plugin::Base

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-ZofCMS-Plugin-Base>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-ZofCMS-Plugin-Base>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-ZofCMS-Plugin-Base>

=item * Search CPAN

L<http://search.cpan.org/dist/App-ZofCMS-Plugin-Base>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 'Zoffix, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

