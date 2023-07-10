#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::Vim;

use Rex -base;
use Rex::Commands::SCM;

set repository => "spacevim",
    url => 'https://github.com/SpaceVim/SpaceVim.git';

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages;

    push @packages, qw/ vim /
        if is_arch or is_debian or is_freebsd or is_suse;
    push @packages, qw/ vim-enhanced /
        if is_redhat;

    die "Unable to configure Vim for this OS\n"
        unless @packages;

    push @packages, qw/ vim-ale vim-scripts /
        if is_debian;

    push @packages, qw/ awesome-vim-colorschemes /;

    pkg \@packages, ensure => 'latest';

    # TODO proper user
    checkout 'spacevim', path => '/home/dean/.SpaceVim';

};

1;
