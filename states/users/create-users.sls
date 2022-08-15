#!jinja|yaml

{% import_yaml 'users/data/users.yaml' as users_file %}
{% set users = users_file['users'] %}


# create user directory for each user
{% for this_user in users %}
{{ this_user }}:
  user.present:
    - fullname: {{ this_user }}
    - user: {{ this_user }}
    - group: {{ this_user }}
{% endfor %}