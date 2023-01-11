#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::Micro;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    # Cant find a rhel package

    pkg [qw/ micro /], ensure => 'latest';

};

1;
