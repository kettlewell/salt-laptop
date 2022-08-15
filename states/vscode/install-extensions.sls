include:
  - users.create-users
  - vscode.create-dir

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{%   if userattr.vscode_extensions is defined and userattr.vscode_extensions %}

{% for extension in userattr.vscode_extensions %}


{{user}}_code_install_{{extension}}:
  cmd.run:
    - require:
      - sls: users.create-users
      - sls: vscode.create-dir
    - name: code  --install-extension {{extension}} > /dev/null
    - cwd: /home/{{user}}
    - runas: {{user}}

{% endfor %}
{% endif %}
{% endfor %}