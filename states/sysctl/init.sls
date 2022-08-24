include:
  - users.create-users

{% import_yaml 'data/system_data.yml' as system_data %}

{% set systemctl       =  system_data.system.systemctl  %}


{% if systemctl is defined and systemctl %}
{% for k, v in systemctl.items() %}


test_{{ k }}_{{ v }}:
  cmd.run:
    - name: echo {{ k }}_{{ v }}

{% endif %}

{% endfor %}