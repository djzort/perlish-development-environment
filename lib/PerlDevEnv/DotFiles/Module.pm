#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::DotFiles;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages;

    push @packages, 'rcm'
        if is_debian or is_freebsd or is_suse;

    die "Unable to configure DotFiles for this OS\n" unless @packages;

    pkg \@packages, ensure => 'latest';

};

1;
