

# Macros are for defining re-usable snippets of a state

# https://github.com/SEJeff/salt-states/blob/master/macros.sls
# Set a key with gsettings for configuring a GNOME 3 desktop

{% macro gsettings(user, path, key, value, regex) %} 
gsettings_set_{{user}}_{{ path }}_{{ key }}_{{ value }}: 
  cmd.run:
    - name: gsettings set {{ path }} {{ key }} "{{ value }}"
    - cwd: /home/{{ user }}
    - runas: {{ user }}
    - user: {{ user }}
    
#    - unless: gsettings get {{ path }} {{ key }} | grep -q {{ regex }} 

{%- endmacro %}
