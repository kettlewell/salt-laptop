include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% set dir_name = user  if userattr.custom_emacs is defined and userattr.custom_emacs else 'default' %}

{% if dir_name != 'default' %}
/home/{{ user }}/.emacs.d:
  file.directory:
    - requires:
      - sls: users.create-users
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700
    - makedirs: True

/home/{{ user }}/.emacs.d/init.el:
  file.managed:
    - require:
      - sls: users.create-users
      - file: /home/{{ user }}/.emacs.d
    - source: salt://users/files/{{user}}/emacs
    - user: {{user}}
    - group: {{user}}
    - mode: 700

{% endif %}
{% endfor %}