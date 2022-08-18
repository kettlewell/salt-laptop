#!jinja|yaml

include:
  - users.create-users
  - users.ssh_keys
#  - users.bashrc
#  - users.aliases
#  - users.profile
#  - users.functions
#  - users.emacs

{% set mk_key = pillar.get['mk_key'] %}


test-gpg:
  cmd.run:
    - name: echo {{ mk_key }}