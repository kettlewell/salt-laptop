include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}
{% if userattr.gnome_launcher_apps is defined and userattr.gnome_launcher_apps %}


{% set gnome_launcher_apps = userattr.gnome_launcher_apps | join(', ')| list %}


gnome_launcher_apps:
  gnome.set:
    - user: {{ user }}
    - schema: org.gnome.shell
    - key: favorite-apps
    - value: {{ gnome_launcher_apps }}


{% endif %}
{% endfor %}


