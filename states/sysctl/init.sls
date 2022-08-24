{% import_yaml 'data/system_data.yml' as system_data %}

{% set sysctl  =  system_data.system.sysctl  %}


{% if sysctl is defined and sysctl %}
{% for k, v in sysctl.items() %}

{{ k }}:
  sysctl.present:
    - value: {{ v }}
    - config: /etc/sysctl/salted_sysctl.conf

{% endfor %}
{% endif %}
