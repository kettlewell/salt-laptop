include:
  - users.create-users
  - vscode.create-dir

{% import_yaml 'data/users_data.yml' as users_data %}
{% for user, user_config in users_data['users'].items() %}


{#


get unique list of extensions from ~/.vscode/extensions
ls -1 | grep -oP "[a-zA-Z]+\..*(?=-\d)" | sort -u

#}

{% if user_config.vscode_extensions is defined and user_config.vscode_extensions %}

{% for extension in user_config.vscode_extensions %}


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
