#!jinja|yaml

include:
  - users.create-users
  - users.ssh_keys
#  - users.dotfiles
  - users.bashrc
  - users.aliases
  - users.profile
  - users.functions
  - users.emacs

#test-gpg-mk_key:
#  cmd.run:
#     - name: echo {{ salt['pillar.get']('mk_key') }}

#test-gpg-freddy_key:
#  cmd.run:
#     - name: echo {{ salt['pillar.get']('github_freddy_rocky_key') }}