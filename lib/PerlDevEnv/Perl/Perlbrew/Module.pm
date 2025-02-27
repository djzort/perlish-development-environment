#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Perl::Perlbrew;

use Rex -base;

task install_perlbrew => sub {

    my @packages;

    push @packages, ( 'perlbrew', 'perl-devel-patchperl' )
      if is_arch;
    push @packages, 'p5-App-perlbrew'
      if is_freebsd;
    push @packages, ( 'perl-App-perlbrew', 'perl-Devel-PatchPerl' )
      if is_suse;

    die "Unable to install Perlbrew for this OS\n"
      unless @packages;

    pkg \@packages, ensure => 'latest';

};

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    install_perlbrew();
};

1;
