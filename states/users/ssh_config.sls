include:
  - users.create-users
  - users.ssh_keys

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% if userattr.custom_ssh_config is defined and userattr.custom_ssh_config %}

/home/{{ user }}/.ssh/config:
  file.managed:
    - require:
      - sls: users.create-users
      - file: {{ user }}-ssh_dir
    - source: salt://users/files/{{user}}/ssh_config
    - user: {{user}}
    - group: {{user}}
    - mode: "0600"

{% endif %}
{% endfor %}