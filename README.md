# Perl-ish Development Environment

An attempt to provide a basis for standardized Perl-ish Development Environments for your organization.

Because disk space is very cheap and most tools are very small, the philosopy is:
- Prefer system packages because they will likely be signed and maintained.
- Include almost any useful tool implemented in Perl
- Include important tools that are binary
- Include very important tools that are other

The environment is intended for general development in a Perl-ish company.

Again, this is a basis point so be inspired and build something useful for your needs.

# Basic Usage

Install Rex and other deps:
```
cpanm --installdeps .
```

Populate the hostgroups.ini

```
[rhel]
rockylinux.fqdn

[freebsd]
ghostbsd.fqdn
```

Run Rex against a host.
```
rex -H ghostbsd.fqdn get_infos
```

Run Rex against a hostgroup and make changes.

```
rex -u root -G rhel rhel_development_environment
```

Review the Rexfile for tasks designed for other Distros and OS.

# Opinionated changes

The ssh daemon is configured in quite an opinionated way. Ymmv.

For editors, install some system packages but doesn't go much further. Try not to wade in to personal
preferences.

# Whats included

Editors and IDEs:
 - Emacs
 - Micro
 - Nano
 - Neovim
 - Vim
 - Vile
 - VSCode

 File managers:
 - Midnight Commander
 - Nnn

 Terminal Related:
 - mosh
 - screen
 - tmux

Tools included:
 - curl
 - git
 - jq
 - wget

Perl tools included:
 - ack
 - colordiff
 - parallel
 - rcm

Nice to have tools:
 - tldr
 - tig

Tested on:
 - Arch
 - Almalinux 8
 - CentOS 9 Stream
 - OpenSUSE 15.4
 - Rocky Linux 8
 - Rocky Linux 9
 - Ubuntu 22.10
 - FreeBSD 13.1

TODO:
 - OpenBSD
 - EternalTerminal
