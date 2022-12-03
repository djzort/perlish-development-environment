#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Nano;

use Rex -base;

task prepare => sub {

    Rex::Logger::info('Installing Nano');

    pkg [qw/ nano /], ensure => 'latest';

};

1;
