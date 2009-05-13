#!/usr/bin/perl

use strict;
use warnings;

use File::Temp;
use File::Spec;

use Catalyst::Plugin::Session::Test::Store (
    backend => "FastMmap",
    config  => { storage => File::Temp::tempdir( 'sessionstoretestXXXX', CLEANUP => 1 ) . '/storage_file' },
    extra_tests => 1
);

{
    package SessionStoreTest;
    use Catalyst;

    sub store_scalar : Global {
        my ($self, $c) = @_;

        $c->res->body($c->session->{'scalar'} = 456);
    }

    sub get_scalar : Global {
        my ($self, $c) = @_;

        $c->res->body($c->session->{'scalar'});
    }

    __PACKAGE__->setup_actions;

}

1;

