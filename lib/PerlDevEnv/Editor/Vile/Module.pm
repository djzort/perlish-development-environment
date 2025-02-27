#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::Vile;

use Rex -base;
use Rex::Commands::SCM;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages;

    if ( is_arch or is_debian or is_freebsd or is_suse or is_redhat ) {
        push @packages, qw/ vile /;
    }

    die "Unable to configure Vile for this OS\n"
      unless @packages;

    pkg \@packages, ensure => 'latest';

};

1;
