include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% if userattr.custom_xinitrc is defined and userattr.custom_xinitrc %}

/home/{{ user }}/.xinitrc:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{user}}/xinitrc
    - user: {{user}}
    - group: {{user}}
    - mode: 644

{% endif %}
{% endfor %}