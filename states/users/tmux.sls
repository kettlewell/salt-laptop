include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% if userattr.custom_tmux is defined and userattr.custom_tmux %}

/home/{{ user }}/.tmux.conf:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{user}}/tmux_conf
    - user: {{user}}
    - group: {{user}}
    - mode: 644

{% endif %}
{% endfor %}