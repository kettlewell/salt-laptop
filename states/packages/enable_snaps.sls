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

