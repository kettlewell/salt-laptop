#!jinja|yaml

include:
  - users.create-users
  - users.ssh_keys
  - users.ssh_config
  - users.dotfiles
  - users.tmux
  - users.xdefaults
  - users.bashrc
  - users.aliases
  - users.profile
  - users.functions
  - users.emacs

{% set mk_key = salt['pillar.get']('mk_key', 'OOOOPS' ) %}


#test-gpg:
#  cmd.run:
#    - name: |
#        echo "{{ mk_key | indent(8) }}"