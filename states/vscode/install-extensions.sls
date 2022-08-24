include:
  - users.create-users
  - vscode.create-dir

{% import_yaml 'data/users_data.yml' as users_data %}
{% for user, user_config in users_data['users'].items() %}

{% if user_config.vscode_extensions is defined and user_config.vscode_extensions %}

manage_file_{{ user }}-install_vscode_extensions.sh:
  file.managed:
    - name: /home/{{ user }}/.vscode/install_vscode_extensions.sh
    - user: {{ user }}
    - mode: "0755"
    - source: salt://vscode/files/install_vscode_extensions.sh.jinja
    - template: jinja
    - context:
      vscode_extensions: {{ user_config["vscode_extensions"] }}
    - require:
      - user: {{ user }}

run_script_{{ user }}-install_vscode_extensions.sh:
  cmd.run:
    - name: /home/{{ user }}/.vscode/install_vscode_extensions.sh
    - onchanges:
      - file: {{ user }}-install_vscode_extensions.sh

{% endif %}

{#


get unique list of extensions from ~/.vscode/extensions
ls -1 | grep -oP "[a-zA-Z]+\..*(?=-\d)" | sort -u



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
#}

{% endfor %}
