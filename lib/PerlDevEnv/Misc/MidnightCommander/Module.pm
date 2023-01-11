#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Misc::MidnightCommander;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    pkg [qw/ mc /], ensure => 'latest';

};

1;
