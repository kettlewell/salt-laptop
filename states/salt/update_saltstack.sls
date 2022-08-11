update_saltstack:
  cmd.script:
    - name: salt://salt/files/update_saltstack.sh
    - env: {{ salt['pillar.get']('default:salt_git_tag', {}) }}

