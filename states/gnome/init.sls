# https://github.com/SEJeff/salt-states/blob/master/roles/desktop/gnome-settings.sls
{% from "macros.sls" import gsettings %}

include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}
{% if userattr.gnome_launcher_apps is defined and userattr.gnome_launcher_apps %}
{% set gnome_launcher_apps = userattr.gnome_launcher_apps | join(', ')| list %}


# Make the default button layout a lot less stupid
{{ gsettings(user, "org.gnome.shell.overrides", "button-layout", ':minimize,maximize,close', "':minimize,maximize,close'") }}

{{ gsettings(user, "org.gnome.shell", "favorite-apps", "['google-chrome.desktop', 'org.gnome.Nautilus.desktop', 'org.gnome.Software.desktop', 'yelp.desktop', 'org.gnome.Terminal.desktop', 'code.desktop']"") }}


{% endif %}
{% endfor %}
