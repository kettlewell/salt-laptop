#!jinja|yaml
include:
  - users.create-users

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


/home/{{ user }}/.config/Code:
  file.directory:
    - requires:
      - sls: users.create-users
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - makedirs: True


/home/{{ user }}/.vscode:
  file.directory:
    - requires:
      - sls: users.create-users
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - makedirs: True

{% endfor %}


