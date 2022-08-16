# https://github.com/SEJeff/salt-states/blob/master/roles/desktop/gnome-settings.sls
{% from "macros.sls" import gsettings %}

include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}
{% if userattr.gnome_launcher_apps is defined and userattr.gnome_launcher_apps %}
{% set gnome_launcher_apps = userattr.gnome_launcher_apps | join(', ')| list %}

## could also check if we're using gnome desktop... 

# Make the default button layout a lot less stupid
{{ gsettings(user, "org.gnome.shell.overrides", "button-layout", ':minimize,maximize,close', "':minimize,maximize,close'") }}

# Make gedit a bit more fanciful
#{{ gsettings(user, "org.gnome.gedit.plugins.filebrowser", "enable-remote", "true", '^true$') }}
#{{ gsettings(user, "org.gnome.gedit.preferences.editor", "auto-save", "true", '^true$') }}
#{{ gsettings(user, "org.gnome.gedit.preferences.editor", "bracket-matching", "true", '^true$') }}
#{{ gsettings(user, "org.gnome.gedit.preferences.editor", "display-line-numbers", "true", '^true$') }}
#{{ gsettings(user, "org.gnome.gedit.preferences.editor", "highlight-current-line", "true", '^true$') }}
#{{ gsettings(user, "org.gnome.shell", "always-show-log-out", "true", '^true$') }}

# Nautilus desktop settings
#{{ gsettings(user, "org.gnome.nautilus.desktop", "background-fade", "true", '^true$') }}
#{{ gsettings(user, "org.gnome.nautilus.desktop", "network-icon-visible", "true", '^true$') }}
#{{ gsettings(user, "org.gnome.nautilus.preferences", "sort-directories-first", "true", '^true$') }}

#gnome_launcher_apps:
#  gnome.set:
#    - user: {{ user }}
#    - schema: org.gnome.shell
#    - key: favorite-apps
#    - value: {{ gnome_launcher_apps }}


{% endif %}
{% endfor %}






{% endif %}