#!/usr/bin/env perl

use Test::More tests => 2;

BEGIN {
    use_ok('App::ZofCMS');
	use_ok( 'App::ZofCMS::Plugin::Base' );
}

diag( "Testing App::ZofCMS::Plugin::Base $App::ZofCMS::Plugin::Base::VERSION, Perl $], $^X" );
