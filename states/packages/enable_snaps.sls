include:
  - packages.system_packages

# enable and start snapd
systemctl_enable_snapd_socket:
  service.running:
    - name: systemctl enable --now snapd.socket
    - enable: True
    - requires:
      - sls: packages.system_packages


{% if not salt['file.file_exists' ]('/snap') %}
snapd_symlink:
  file.symlink:
    - name: /var/lib/snapd/snap
    - target: /snap
    - requires:
      - sls: packages.system_packages
{% endif %}