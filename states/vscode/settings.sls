include:
  - users.create-users
  - vscode.create-dir

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{%   if userattr.vscode_settings is defined and userattr.vscode_settings %}

/home/{{ user }}/.config/Code/User/settings.json:
  file.managed:
    - require:
      - sls: users.create-users
      - sls: vscode.create-dir
    - source: salt://vscode/files/{{user}}.vscode_settings.json
    - user: {{user}}
    - group: {{user}}
    - mode: 755

{% endif %}
{% endfor %}