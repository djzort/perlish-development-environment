#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Micro;

use Rex -base;

task prepare => sub {

    Rex::Logger::info('Installing Micro');

    pkg [qw/ micro /], ensure => 'latest';

};

1;
