#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Basics;

use Rex -base;

task dnf => sub {

    return if not is_redhat;

    my $updaterepo;

    if ( int( operating_system_release() ) == 9 ) {
        Rex::Logger::info('RedHat-ish 9');
    }
    if ( int( operating_system_release() ) == 8 ) {
        Rex::Logger::info('RedHat-ish 8');

        # Rocky Linux
        my @files = (
            '/etc/yum.repos.d/almalinux-powertools.repo',
            '/etc/yum.repos.d/Rocky-PowerTools.repo'
        );
        for my $file (@files) {
            if ( is_file($file) ) {
                sed qr|^enabled=.*|,
                  'enabled=1',
                  $file, on_change => sub { $updaterepo++ };
            }
        }
    }

    update_package_db
      if $updaterepo;

    pkg [qw/ epel-release /],
      ensure    => 'latest',
      on_change => sub { update_package_db };

    # pkg [qw/ dnf-plugins-core /], ensure => 'present';
    # dnf config-manager --set-enabled crb
    # dnf install epel-release

};

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    my @packages;

    if (is_arch) {

        # needed for Rex to work
        push @packages, qw/ which net-tools /;

        # absolute minimum
        push @packages, qw/ curl git jq tar wget /;

        # tools in perl
        push @packages, qw/ ack colordiff parallel /;

        # other good to have
        push @packages, qw/ dos2unix tldr tig /;
    }
    if (is_freebsd) {

        # absolute minimum
        push @packages, qw/ curl git jq gtar wget /;

        # tools in perl
        push @packages, qw/ p5-ack colordiff parallel /;

        # other good to have
        push @packages, qw/ tig /;
    }
    if (is_redhat) {

        # needed for Rex to work
        push @packages, qw/ which net-tools /;

        # absolute minimum
        push @packages, qw/ curl git jq tar wget /;

        # tools in perl
        push @packages, qw/ ack colordiff parallel /;

        # other good to have
        push @packages, qw/ dos2unix tldr tig /;
        dnf();
    }
    if (is_suse) {
        push @packages, qw/ curl git jq net-tools tar wget /;
    }

    die "Basics not supported for OS\n"
      unless @packages;

    pkg \@packages, ensure => 'latest';

};

1;
