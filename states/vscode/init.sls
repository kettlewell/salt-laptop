#!jinja|yaml
{% for user in pillar['users'] %}
/home/{{ user }}/.config/Code
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - makedirs: True

{% endfor %}