update_saltstack:
  cmd.script:
    - name: salt://salt/files/update_saltstack.sh
    - template: jinja
    - shell: /bin/bash
    - context:
      salt_git_tag: {{ pillar['salt_git_tag'] }}
      expected_salt_version: {{ pillar['expected_salt_version'] }}