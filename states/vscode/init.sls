#!jinja|yaml
{% for my_user in pillar['users'] %}
/home/{{ my_user }}/.config/Code
  file.directory:
    - user: {{ my_user }}
    - group: {{ my_user }}
    - mode: 700
    - makedirs: True
{% endfor %}
