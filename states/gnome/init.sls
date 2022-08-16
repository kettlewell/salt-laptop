# https://github.com/SEJeff/salt-states/blob/master/roles/desktop/gnome-settings.sls
{% from "macros.sls" import gsettings %}

include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}
{% if userattr.gnome_launcher_apps is defined and userattr.gnome_launcher_apps %}
{% set gnome_launcher_apps = userattr.gnome_launcher_apps|join('\', \'') %}

# Make the default button layout a lot less stupid
{{ gsettings(user, "org.gnome.desktop.wm.preferences", "button-layout", 'appmenu:minimize,maximize,close', "':minimize,maximize,close'") }}

{{ gsettings(user, "org.gnome.shell", "favorite-apps", gnome_launcher_apps|replace("\"","'") , "google-chrome") }}


{% endif %}
{% endfor %}
