#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Basics;

use Rex -base;

task dnf => sub {

    Rex::Logger::info('Configuring DNF');

    return if not is_redhat;

    my $updaterepo;

    if (int(operating_system_release()) == 9) {
        Rex::Logger::info('RedHat-ish 9');
    }
    if (int(operating_system_release()) == 8) {
        Rex::Logger::info('RedHat-ish 8');
        # Rocky Linux
        my $file = '/etc/yum.repos.d/Rocky-PowerTools.repo';
        if (is_file($file)) {
            sed qr|^enabled=.*|,
                'enabled=1',
                $file, on_change => sub { $updaterepo++ };
        }
    }

    update_package_db
        if $updaterepo;

    pkg [qw/ epel-release /],
        ensure => 'latest',
        on_change => sub { update_package_db };

    # pkg [qw/ dnf-plugins-core /], ensure => 'present';
    # dnf config-manager --set-enabled crb
    # dnf install epel-release

};

task prepare => sub {

    Rex::Logger::info('Installing Basics');

    my @packages;

    if (is_redhat) {
        # absolute minimum
        push @packages, qw/ curl git jq net-tools tar wget /;
        # tools in perl
        push @packages, qw/ ack colordiff parallel /;
        # other good to have
        push @packages, qw/ httpie nnn tldr tig /;
        dnf();
    }
    if (is_suse) {
        push @packages, qw/ curl git jq net-tools tar wget /;
    }

    die "Basics not supported for OS\n" unless @packages;

    pkg \@packages, ensure => 'latest';

};

1;
