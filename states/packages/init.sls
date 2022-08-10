include:
  - packages.repos

system_packages:
  pkg.installed:
    - refresh: True
    - pkgs:
      - code: '1.70*'
      - curl
      - git
      - mtr
      - pigz
      - pinentry
      - pinentry-tty
      - postgresql
      - procps-ng
      - rsync
      - socat
      - strace
      - sysfsutils
      - tig
      - tmux
      - traceroute
      - tree
      - wget
      - whois
      - wireshark
      - zip

#      - packer
#      - yq
#      - wpasupplicant
#      - google-chrome-stable
#      - ykls
#      - xz-utils
#      - sqlite3
#      - uuid-runtime

