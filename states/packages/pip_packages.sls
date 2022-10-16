# pip packages

include:
  - packages.system_packages

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users       =  users_data.users  %}


# pip packages aren't normally global, so this should just be for global packages,
# and then each project can manage their own pip packages in a venv of some sort

 # initial plan: read system_data for global pip packages
 #               read users_data for user venv pip packages

# global package installation
# TODO: cleanup the requirements file... lots of non-global stuff there


update_pip_cffi:
  pip.installed:
    - name: cffi
    - reload_modules: True
    - require:
      - sls: packages.system_packages
    - upgrade: True
    - user: root

update_pip_pip:
  pip.installed:
    - name: pip
    - reload_modules: True
    - require:
      - pip: update_pip_cffi
    - upgrade: True
    - user: root

update_pip_setuptools:
  pip.installed:
    - name: setuptools >= 65.0
    - reload_modules: True
    - require:
      - pip: update_pip_pip
    - upgrade: True
    - user: root


global_pip_install:
  pip.installed:
    - name: global pip installation
    - requirements: salt://packages/requirements/global_requirements.txt
    - reload_modules: True
    - user: root
    - require:
      - sls: packages.system_packages
      - pip: update_pip_setuptools


{% for user, user_config in users.items() %}
{% if user_config.venv_projects is defined and user_config.venv_projects %}

/home/{{user}}/venv:
  file.directory:
    - user: {{user}}
    - group: {{user}}
    - mode: "0755"

{% for project in user_config.venv_projects %}

/home/{{user}}/venv/{{project}}:
  virtualenv.managed:
    - system_site_packages: False
    - requirements: salt://packages/requirements/{{user}}/{{project}}_requirements.txt
    - require:
      - file: /home/{{user}}/venv
    - user: {{user}}

{% endfor %}
{% endif %}
{% endfor %}
