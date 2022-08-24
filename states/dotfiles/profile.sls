include:
  - users.create-users

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{% set dir_name = user  if user_config.custom_profile is defined and user_config.custom_profile else 'default' %}

/home/{{ user }}/.bash_profile:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://dotfiles/files/{{dir_name}}/bash_profile
    - user: {{user}}
    - group: {{user}}
    - mode: 644


{% endfor %}
