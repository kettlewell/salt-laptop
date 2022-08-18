include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

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

{%   if userattr.ssh_keys is defined and userattr.ssh_keys %}

{{ user }}-ssh_key:
  file.managed:
    - name: /home/{{ user }}/.ssh/authorized_keys
    - user: {{ user }}
    - mode: "0600"
    - source: salt://users/config/authorized_keys.jinja
    - template: jinja
    - context:
      ssh_keys: {{ userattr["ssh_keys"] }}
    - require:
      - user: {{ user }}
      - file: {{ user }}-ssh_dir

{% endif %}

{%   if userattr.ssh_keys_encrypted is defined and userattr.ssh_keys_encrypted %}

{% for ssh_key in userattr.ssh_keys_encrypted %}

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