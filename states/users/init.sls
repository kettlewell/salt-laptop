#!jinja|yaml

include:
  - users.create-users
  - users.create-groups
  - users.ssh_keys
  - users.ssh_config



{#
{% set mk_key = salt['pillar.get']('mk_key', 'OOOOPS' ) %}
test-gpg:
  cmd.run:
    - name: |
        echo "{{ mk_key | indent(8) }}"
#}
