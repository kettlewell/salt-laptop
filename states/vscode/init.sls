{% for user in salt['pillar.get']('users') %}
/home/{{ user }}/.config/Code
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - makedirs: True

{% endfor %}