# https://github.com/SEJeff/salt-states/blob/master/roles/desktop/gnome-settings.sls
{% from "macros.sls" import gsettings %}

include:
  - users.create-users
{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}

{% if user_config.gnome_launcher_apps is defined and user_config.gnome_launcher_apps %}
{% set gnome_launcher_apps = user_config.gnome_launcher_apps|tojson|replace('"', "'")%}


# Make the default button layout a lot less stupid
{{ gsettings(user, "org.gnome.desktop.wm.preferences", "button-layout", 'appmenu:minimize,maximize,close', "':minimize,maximize,close'") }}

{{ gsettings(user, "org.gnome.shell", "favorite-apps", gnome_launcher_apps , "google-chrome") }}


{% endif %}
{% endfor %}
