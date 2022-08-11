update_saltstack:
  cmd.run:
    - name: salt://salt/files/update_saltstack.sh
    - env: {{ salt['pillar.get']('default:salt_git_tag', {}) }}

