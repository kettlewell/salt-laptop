include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% set dir_name = user  if userattr.custom_functions is defined and userattr.custom_functions else 'default' %}

{% if dir_name != 'default' %}

/home/{{ user }}/.bash_functions:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{user}}/bash_functions
    - user: {{user}}
    - group: {{user}}
    - mode: 644

{% endif %}
{% endfor %}