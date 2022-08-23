include:
  - users.create-users
  - users.ssh_keys

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{% if user_config.custom_ssh_config is defined and user_config.custom_ssh_config %}

/home/{{ user }}/.ssh/tmp:
  file.directory:
    - requires:
      - sls: users.create-users
      - file: {{ user }}-ssh_dir
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - makedirs: True

/home/{{ user }}/.ssh/config:
  file.managed:
    - require:
      - sls: users.create-users
      - file: {{ user }}-ssh_dir
      - file: /home/{{ user }}/.ssh/tmp
    - source: salt://users/files/{{user}}/ssh_config
    - user: {{user}}
    - group: {{user}}
    - mode: "0600"

{% endif %}
{% endfor %}
