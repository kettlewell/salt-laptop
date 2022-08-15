#!jinja|yaml
{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}
username_{{ user }}:
  user.present:
    - fullname: {{ user }}
    - name: {{ user }}

{% endfor %}