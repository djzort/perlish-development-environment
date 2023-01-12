#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::Micro;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    die "Unable to configure Micro for this OS\n"
        unless is_arch or is_debian or is_suse;

    pkg [qw/ micro /], ensure => 'latest';

};

1;
