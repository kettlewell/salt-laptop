include:
  - users.create-users

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{% if user_config.custom_xinitrc is defined and user_config.custom_xinitrc %}

/home/{{ user }}/.xinitrc:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://dotfiles/files/{{user}}/xinitrc
    - user: {{user}}
    - group: {{user}}
    - mode: 644

{% endif %}
{% endfor %}
