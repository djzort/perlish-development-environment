#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::Emacs;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages;

    push @packages, qw/ emacs-nox /
        if is_arch or is_freebsd or is_redhat;
    push @packages, qw/ emacs /
        if is_debian or is_suse;

    die "Unable to configure Emacs for this OS\n"
        unless @packages;

    pkg \@packages, ensure => 'latest';

};

1;
