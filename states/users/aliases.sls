include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% set dir_name = user  if userattr.custom_aliases is defined and userattr.custom_aliases else 'default' %}

{% if dir_name != 'default' %}

/home/{{ user }}/.bash_aliases:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{user}}/bash_alias
    - user: {{user}}
    - group: {{user}}
    - mode: 644

{% endif %}
{% endfor %}