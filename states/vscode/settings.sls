include:
  - users.create-users
  - vscode.create-dir

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{%   if user_config.vscode_settings is defined and user_config.vscode_settings %}

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
