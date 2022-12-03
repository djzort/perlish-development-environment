#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::MidnightCommander;

use Rex -base;

task prepare => sub {

    Rex::Logger::info('Installing Midnight Commander');

    pkg [qw/ mc /], ensure => 'latest';

};

1;
