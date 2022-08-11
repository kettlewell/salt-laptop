/etc/cron.d/salt-masterless:
  file.managed:
    - source: salt://cron/files/salt-masterless-highstate
   