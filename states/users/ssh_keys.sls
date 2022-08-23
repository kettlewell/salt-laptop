include:
  - users.create-users

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{{ user }}-ssh_dir:
  file.directory:
    - name: /home/{{ user }}/.ssh
    - user: {{ user }}
    - mode: "0700"
    - require:
      - user: {{ user }}

{{ user }}-ssh_keys_dir:
  file.directory:
    - name: /home/{{ user }}/.ssh/keys
    - user: {{ user }}
    - mode: "0700"
    - require:
      - user: {{ user }}
      - file: {{ user }}-ssh_dir

{%   if user_config.ssh_keys is defined and user_config.ssh_keys %}

{{ user }}-ssh_key:
  file.managed:
    - name: /home/{{ user }}/.ssh/authorized_keys
    - user: {{ user }}
    - mode: "0600"
    - source: salt://users/config/authorized_keys.jinja
    - template: jinja
    - context:
      ssh_keys: {{ user_config["ssh_keys"] }}
    - require:
      - user: {{ user }}
      - file: {{ user }}-ssh_dir

{% endif %}

{%   if user_config.ssh_keys_encrypted is defined and user_config.ssh_keys_encrypted %}

{% for ssh_key in user_config.ssh_keys_encrypted %}

{{ user }}-ssh_key_{{ ssh_key }}:
  file.managed:
    - name: /home/{{ user }}/.ssh/keys/{{ ssh_key }}
    - user: {{ user }}
    - mode: "0600"
    - attrs: a
    - contents_pillar: ssh_keys_encrypted:{{ ssh_key }}
    - require:
      - user: {{ user }}
      - file: {{ user }}-ssh_dir

{% endfor %}
{% endif %}
{% endfor %}
