include:
  - users.create-users

 {% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{% if user_config.custom_tmux is defined and user_config.custom_tmux %}

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
