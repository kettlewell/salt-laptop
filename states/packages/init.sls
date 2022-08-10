include:
  - packages.epel-release

system_packages:
  pkg.installed:
    - pkgs:
      - curl
      - wget
      - git
      - zip
      - wireshark
      - whois
      - tig
      - tmux
      - traceroute
      - mtr
      - tree
      - sysfsutils
      - strace
      - socat
      - rsync
      - postgresql
      - procps
      - pigz
      - pinentry-curses

#      - packer
#      - yq
#      - wpasupplicant
#      - google-chrome-stable
#      - ykls
#      - xz-utils
#      - sqlite3
#      - uuid-runtime

