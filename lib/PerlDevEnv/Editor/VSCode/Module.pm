#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::VSCode;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    repository
      add         => 'vscode',
      description => 'Visual Studio Code ',
      url         => 'https://packages.microsoft.com/yumrepos/vscode',
      key_url     => 'https://packages.microsoft.com/keys/microsoft.asc'
      if is_redhat;

    if (is_debian) {

        pkg [qw/ apt-transport-https /], ensure => 'present';

        repository
          add        => 'vscode',
          arch       => 'amd64,arm64,armhf',
          url        => 'https://packages.microsoft.com/repos/code',
          distro     => 'stable',
          repository => 'main',
          key_url    => 'https://packages.microsoft.com/keys/microsoft.asc';

    }

    update_package_db();

    pkg ['code'], ensure => 'latest';

    # code --install-extensions  bscan.perlnavigator

};

1;
