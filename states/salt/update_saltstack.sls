update_saltstack:
  cmd.script:
    - name: salt://salt/files/update_saltstack.sh
    - template: jinja
    - context:
      salt_git_tag: {{ pillar['salt_git_tag'] }}