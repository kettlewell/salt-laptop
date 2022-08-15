#!jinja|yaml

{% import_yaml 'users/data/users.yaml' as users_file %}
{% set users = users_file['users'] %}


# create user directory for each user
{% for user in users %}
{{ user }}:
  user.present:
    - fullname: {{ user }}
    - user: {{ user }}
    - group: {{ user }}
{% endfor %}