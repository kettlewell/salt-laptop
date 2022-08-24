include:
  - users.create-users

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{% set dir_name = user  if user_config.custom_aliases is defined and user_config.custom_aliases else 'default' %}

{% if dir_name != 'default' %}

/home/{{ user }}/.bash_aliases:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://dotfiles/files/{{user}}/bash_aliases
    - user: {{user}}
    - group: {{user}}
    - mode: 644

{% endif %}
{% endfor %}
