include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% if userattr.custom_xresources is defined and userattr.custom_xresources %}

/home/{{ user }}/.Xresources:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{user}}/Xresources
    - user: {{user}}
    - group: {{user}}
    - mode: 644

{% endif %}
{% endfor %}