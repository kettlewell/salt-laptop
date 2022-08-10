include:
  - packages.epel-release

system_packages:
  pkg.installed:
    - pkgs:
      - curl
      - wget
      - git
      - yq
      - zip
      - ykls
      - xz-utils
      - wpasupplicant
      - wireshark
      - whois
      - uuid-runtime
      - tig
      - tmux
      - traceroute
      - mtr
      - tree
      - sysfsutils
      - sqlite3
      - strace
      - socat
      - rsync
      - postgresql
      - procps
      - pigz
      - pinentry-curses
      - packer
      - google-chrome-stable
      