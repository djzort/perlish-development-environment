#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::Neovim;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages = qw/ neovim /;

    die "Unable to configure Neovim for this OS\n"
        unless @packages;

    pkg \@packages, ensure => 'latest';

};

1;
