#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Misc::Nnn;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages;

    if (   is_arch
        or is_debian
        or is_freebsd
        or is_redhat
        or is_suse )
    {
        push @packages, 'nnn';
    }

    die "Unable to configure Nnn for this OS\n"
      unless @packages;

    pkg \@packages, ensure => 'latest';

};

1;
