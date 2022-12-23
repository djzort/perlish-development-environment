#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::Vim;

use Rex -base;
use Rex::Commands::SCM;

set repository => "spacevim",
    url => 'https://github.com/SpaceVim/SpaceVim.git';

task prepare => sub {

    Rex::Logger::info('Installing Vim');

    my @packages;

    if (is_debian) {
        push @packages, qw/ vim /;
    }
    if (is_redhat) {
        push @packages, qw/ vim-enhanced /;
    }
    if (is_suse) {
        push @packages, qw/ vim /;
    }

    die "Unable to configure Vim for this OS\n" unless @packages;

    pkg \@packages, ensure => 'latest';

    checkout 'spacevim', path => '/home/dean/.SpaceVim';

};

1;
