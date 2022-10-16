epel_release:
  pkg.installed:
    - pkgs:
      - epel-release

disable_epel_next_repo:
  cmd.run:
    - name: |
        dnf config-manager --disable epel-next
