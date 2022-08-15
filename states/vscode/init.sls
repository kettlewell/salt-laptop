#!jinja|yaml
include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% set users = users_file['users'] %}

# create Code directory for each user
{% for my_user in users %}
/home/{{ my_user }}/.config/Code:
  file.directory:
    - user: {{ my_user }}
    - group: {{ my_user }}
    - mode: 700
    - makedirs: True

{%# for my_extensions in my_user['vscode_extensions'] %}
{% for my_extension in my_extensions %}

test.show_notification:
  name: vscode_extension_{{ my_extensions}}
  text: {{ my_extensions }}
{% endfor %}
{% endfor #%}
{% endfor %}


# install extensions for each user

# install settings.json per user ?

# install keybindings.json per user?

# install ~/.vscode/argv.json ?


