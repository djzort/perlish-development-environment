#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Shell::Tcsh;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    # tcsh is the default in FreeBSD
    return if is_freebsd;

    pkg [qw/ tcsh /], ensure => 'latest';

};

1;
