include:
  - salt.sync_states

/srv/salt-laptop:
  file.directory:
    - user: root
    - group: root
    - mode: 700
    - makedirs: True

salt-minion:
  service.dead:
    - enable: False
    - name: salt-minion
    