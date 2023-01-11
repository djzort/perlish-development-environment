#!/bin/false
# vim: softtabstop=4 tabstop=4 shiftwidth=4 ft=perl expandtab smarttab

package PerlDevEnv::Editor::VSCodeServer;

use Rex -base;

task prepare => sub {

    Rex::Logger::info(__PACKAGE__);

    pkg ['tar'], ensure => 'present';

    #
    # wget -q https://update.code.visualstudio.com/commit:$commit/server-linux-x64/stable
    # tar -xf stable
    # mkdir -p ~/.vscode-server/bin
    # mv vscode-server-linux-x64 ~/.vscode-server/bin/$commit
    #
    # code --install-extensions  bscan.perlnavigator

};

1;
