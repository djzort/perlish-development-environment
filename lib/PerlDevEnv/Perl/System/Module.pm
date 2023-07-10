#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Perl::System;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages;
    push @packages, 'perl' if is_linux;
    push @packages, 'perl5' if is_freebsd;

    pkg \@packages, ensure => 'latest';

};

1;
