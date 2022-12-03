#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::EtcKeeper;

use Rex -base;

task prepare => sub {

    Rex::Logger::info('Installing EtcKeeper');

    my @packages;

    if (is_debian) {
        push @packages, 'etckeeper';
    }
    if (is_redhat) {
        push @packages, 'etckeeper', 'etckeeper-dnf';
    }

    die "Unable to configure EtcKeeper for this OS\n" unless @packages;

    pkg \@packages, ensure => 'latest';

    file '/etc/etckeeper/post-install.d/99git-gc',
        source => 'files/etc/etckeeper/post-install.d/99git-gc',
        mode  => 755,
        owner => 'root',
        group => 'root';

    file '/root/.gitconfig',
        content => template('files/root/dot-gitconfig.tmpl'),
        owner => 'root',
        group => 'root';


    if (!is_dir('/etc/.git')) {
        run 'etckeeper init';
    }

};

1;
