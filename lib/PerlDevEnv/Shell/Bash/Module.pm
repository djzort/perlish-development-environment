#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Shell::Bash;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages = qw/ bash /;

    if (is_redhat) {
        push @packages, qw/ bash-completion /
    }

    pkg \@packages, ensure => 'latest';
};

1;
