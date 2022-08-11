#!jinja|yaml
{% set users = salt['pillar.get']('users', []) %}
{% for my_user in users %}
/home/{{ my_user }}/.config/Code
  file.directory:
    - user: {{ my_user }}
    - group: {{ my_user }}
    - mode: 700
    - makedirs: True
{% endfor %}
