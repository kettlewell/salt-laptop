#!jinja|yaml
{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}

username_{{ user }}:
  user.present:
    - fullname: {{ user }}
    - name: {{ user }}

{% endfor %}
