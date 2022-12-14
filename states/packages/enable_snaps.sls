include:
  - packages.system_packages

# enable and start snapd
systemctl_enable_snapd_socket:
  service.running:
    - name: snapd.socket
    - enable: True
    - requires:
      - sls: packages.system_packages
    - reload: True


{% if not salt['file.file_exists' ]('/snap') %}
snapd_symlink:
  file.symlink:
    - name: /snap
    - target: /var/lib/snapd/snap
    - requires:
      - sls: packages.system_packages
{% endif %}

install_snap_snap-store:
    cmd.run:
      - name: snap install snap-store

install_snap_slack:
    cmd.run:
      - name: snap install slack     

install_snap_spotify:
    cmd.run:
      - name: snap install spotify           