#!/usr/bin/env perl
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

use warnings;
use strict;

use Rex -feature => [qw/ 1.4 use_server_auth /];
use Rex::Group::Lookup::INI;
use Rex::Commands::Inventory;
use Rex::Commands::User;

use Data::Printer;

include qw/
  PerlDevEnv::Basics
  PerlDevEnv::DotFiles
  PerlDevEnv::Editor::Emacs
  PerlDevEnv::Editor::Micro
  PerlDevEnv::Editor::Nano
  PerlDevEnv::Editor::Neovim
  PerlDevEnv::Editor::Vim
  PerlDevEnv::Editor::VSCode
  PerlDevEnv::Editor::VSCodeServer
  PerlDevEnv::Misc::MidnightCommander
  PerlDevEnv::Misc::Nnn
  PerlDevEnv::Shell::Bash
  PerlDevEnv::Shell::Fish
  PerlDevEnv::Shell::Tcsh
  PerlDevEnv::Shell::Zsh
  PerlDevEnv::Terminal::Screen
  PerlDevEnv::Terminal::Tmux
  PerlDevEnv::Perl::Perlbrew
  PerlDevEnv::Perl::System
  /;

groups_file 'hostgroups.ini';

## Used to get a quick overview of the system
task 'get_infos' => sub {

    if (is_arch) {
        pkg [ 'net-tools', 'which' ], ensure => 'present';
    }
    if (is_redhat or is_debian) {
        pkg 'net-tools', ensure => 'present';
    }
    if (is_suse) {
        pkg 'net-tools-deprecated', ensure => 'present';
    }

    my $inv = inventory();

    $inv->{configuration}->{network}->{current_connections} = undef;
    print "inventory()\n";
    p $inv;

    print "dump_system_information()\n";
    dump_system_information;
    print "rex thinks this is arch\n"    if is_arch;
    print "rex thinks this is debian\n"  if is_debian;
    print "rex thinks this is freebsd\n" if is_freebsd;
    print "rex thinks this is redhat\n"  if is_redhat;
    print "rex thinks this is suse\n"    if is_suse;
    printf
"operating_system: %s operating_system_version: %s operating_system_release: %s\n",
      get_operating_system, operating_system_version, operating_system_release;
};

task 'updatesystem', sub {
    Rex::Logger::info( 'OS version: ' . operating_system_release() );
    update_system;
};

task 'install_openssh' => sub {

    # sshd part of FreeBSD
    return if is_freebsd;

    my $sshpkg;

    $sshpkg = 'openssh-server' if is_debian;
    $sshpkg = 'openssh-server' if is_redhat;
    $sshpkg = 'openssh'        if is_suse or is_arch;

    die "Dont know how to configure sshd for this OS\n"
      unless $sshpkg;

    pkg $sshpkg, ensure => 'present';

};

## Configure the ssh daemon
task 'configure_sshd' => sub {

    Rex::Logger::info('Configuring sshd');

    install_openssh();

    my %settings = (
        'Banner'                 => 'none',
        'LoginGraceTime'         => 15,
        'PrintMotd'              => 'no',
        'PermitRootLogin'        => 'without-password',
        'PermitUserRC'           => 'no',
        'PubkeyAuthentication'   => 'yes',
        'PasswordAuthentication' => 'no',
        'TCPKeepAlive'           => 'yes',
        'ClientAliveInterval'    => 5,
        'ClientAliveCountMax'    => 30,
        'MaxStartups'            => '10:30:60',
    );

    my $restart;
    my $file = '/etc/ssh/sshd_config';

    if ( is_dir('/etc/ssh/sshd_config.d') ) {
        $file = '/etc/ssh/sshd_config.d/Rex.conf';
        file $file,
          content => "# Managed by Rex\n"
          . join( "\n", map { "$_ $settings{$_}" } sort keys %settings ),
          owner     => 'root',
          group     => 'root',
          on_change => sub { $restart++ };

    }
    else {
        while ( my ( $k, $v ) = each %settings ) {
            append_or_amend_line $file,
              line      => sprintf( q|%s %s|, $k, $v ),
              regexp    => qr{^#?$k\s},
              on_change => sub { $restart++ };
        }
    }

    # It's passed time to remove rsa keys
    file '/etc/ssh/ssh_host_dsa_key',     ensure => 'absent';
    file '/etc/ssh/ssh_host_dsa_key.pub', ensure => 'absent';

    append_or_amend_line $file,
      line      => '#HostKey /etc/ssh/ssh_host_dsa_key',
      regexp    => qr{^#HostKey /etc/ssh/ssh_host_dsa_key$},
      on_change => sub { $restart++ };

    service 'sshd' => 'restart'
      if $restart;

};

task 'install_vscode' => sub {
    PerlDevEnv::Editor::VSCode::prepare();
};

task 'install_vscode_server' => sub {
    PerlDevEnv::Editor::VSCodeServer::prepare();
};

task 'arch_development_environment',
  group => 'arch',
  sub {
    PerlDevEnv::Perl::System::prepare();
    configure_sshd();

    PerlDevEnv::Basics::prepare();
    PerlDevEnv::Perl::Perlbrew::prepare();

    PerlDevEnv::Shell::Bash::prepare();
    PerlDevEnv::Shell::Fish::prepare();
    PerlDevEnv::Shell::Tcsh::prepare();
    PerlDevEnv::Shell::Zsh::prepare();

    PerlDevEnv::Misc::MidnightCommander::prepare();
    PerlDevEnv::Misc::Nnn::prepare();

    #PerlDevEnv::DotFiles::prepare();

    PerlDevEnv::Editor::Emacs::prepare();
    PerlDevEnv::Editor::Micro::prepare();
    PerlDevEnv::Editor::Nano::prepare();
    PerlDevEnv::Editor::Vim::prepare();
    PerlDevEnv::Editor::Neovim::prepare();
  };

task 'freebsd_development_environment',
  group => 'freebsd',
  sub {
    PerlDevEnv::Perl::System::prepare();
    configure_sshd();

    PerlDevEnv::Basics::prepare();
    PerlDevEnv::Perl::Perlbrew::prepare();

    PerlDevEnv::Shell::Bash::prepare();
    PerlDevEnv::Shell::Fish::prepare();
    PerlDevEnv::Shell::Tcsh::prepare();
    PerlDevEnv::Shell::Zsh::prepare();

    PerlDevEnv::Misc::MidnightCommander::prepare();
    PerlDevEnv::Misc::Nnn::prepare();
    PerlDevEnv::DotFiles::prepare();

    PerlDevEnv::Editor::Emacs::prepare();
    PerlDevEnv::Editor::Nano::prepare();
    PerlDevEnv::Editor::Vim::prepare();
    PerlDevEnv::Editor::Neovim::prepare();
  };

task 'rhel_development_environment',
  group => 'rhel',
  sub {

    PerlDevEnv::Perl::System::prepare();
    configure_sshd();

    PerlDevEnv::Basics::prepare();

    PerlDevEnv::Shell::Bash::prepare();
    PerlDevEnv::Shell::Fish::prepare();
    PerlDevEnv::Shell::Tcsh::prepare();
    PerlDevEnv::Shell::Zsh::prepare();

    PerlDevEnv::Misc::MidnightCommander::prepare();
    PerlDevEnv::Misc::Nnn::prepare();
    PerlDevEnv::Terminal::Screen::prepare();
    PerlDevEnv::Terminal::Tmux::prepare();

    # PerlDevEnv::DotFiles::prepare();

    PerlDevEnv::Editor::Emacs::prepare();

    PerlDevEnv::Editor::Nano::prepare();
    PerlDevEnv::Editor::Vim::prepare();
    PerlDevEnv::Editor::Neovim::prepare();
  };

task 'suse_development_environment',
  group => 'suse',
  sub {
    PerlDevEnv::Perl::System::prepare();
    configure_sshd();

    PerlDevEnv::Basics::prepare();
    PerlDevEnv::Perl::Perlbrew::prepare();

    PerlDevEnv::DotFiles::prepare();
    PerlDevEnv::Misc::MidnightCommander::prepare();
    PerlDevEnv::Misc::Nnn::prepare();
    PerlDevEnv::DotFiles::prepare();

    PerlDevEnv::Editor::Emacs::prepare();
    PerlDevEnv::Editor::Nano::prepare();
    PerlDevEnv::Editor::Vim::prepare();
    PerlDevEnv::Editor::Neovim::prepare();
  };

1;
