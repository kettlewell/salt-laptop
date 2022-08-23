include:
  - users.create-users

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{% set dir_name = user  if user_config.custom_emacs is defined and user_config.custom_emacs else 'default' %}

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
    - source: salt://users/files/{{user}}/emacs-init.el
    - user: {{user}}
    - group: {{user}}
    - mode: 700

{% endif %}
{% endfor %}
