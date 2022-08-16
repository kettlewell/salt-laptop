include:
  - users.create-users
  - vscode.create-dir

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% set custom_bashrc = user  if userattr.custom_bashrc is defined and userattr.custom_bashrc else 'default' %}

/home/{{ user }}/.bashrc:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{custom_bashrc}}/bashrc
    - user: {{user}}
    - group: {{user}}
    - mode: 644


{% endfor %}