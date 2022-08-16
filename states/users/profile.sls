include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% set dir_name = user  if userattr.custom_profile is defined and userattr.custom_profile else 'default' %}

/home/{{ user }}/.bash_profile:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{dir_name}}/bash_profile
    - user: {{user}}
    - group: {{user}}
    - mode: 644


{% endfor %}