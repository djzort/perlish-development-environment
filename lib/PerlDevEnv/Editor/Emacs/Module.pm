#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::Emacs;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages;

    if (is_arch) {
        push @packages, qw/ emacs-nox /;
    }
    if (is_debian) {
        push @packages, qw/ emacs /;
    }
    if (is_redhat) {
        push @packages, qw/ emacs-nox /;
    }
    if (is_suse) {
        push @packages, qw/ emacs /;
    }

    die "Unable to configure Emacs for this OS\n" unless @packages;

    pkg \@packages, ensure => 'latest';

};

1;
