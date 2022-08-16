

# Macros are for defining re-usable snippets of a state

# https://github.com/SEJeff/salt-states/blob/master/macros.sls
# Set a key with gsettings for configuring a GNOME 3 desktop
{% macro gsettings(user, path, key, value, regex) -%} 
gsettings set {{ path }} {{ key }} {{ value }}: 
  cmd.run:
    - cwd: /
    - user: {{ user }}
    - unless: gsettings get {{ path }} {{ key }} | grep -q {{ regex }} 
# TODO: Does "dconf update" need to be ran?
{%- endmacro %}
