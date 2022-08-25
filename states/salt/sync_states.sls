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
    - onchanges:
      - git: sync_states


set_minion_config:
  file.managed:
    - name: /etc/salt/minion.d/masterless.conf
    - source: salt://salt/config/etc/salt/minion.d/masterless.conf
    - changes:
      - saltutil: sync_all_modules
