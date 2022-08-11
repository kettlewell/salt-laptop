sync_states:
  git.latest:
    - name: https://github.com/kettlewell/salt-laptop.git
    - target: /srv/salt-laptop
    - force_checkout: True
    - force_clone: True
    - force_fetch: True
    - force_reset: True
    - submodules: False
    - order: 1
    - require:
      - file: /srv/salt-laptop

sync_all_modules:
  saltutil.sync_all:
    - refresh: True
    - order: 1
    - onchanges:
      - git: sync_states
