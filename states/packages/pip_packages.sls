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
global_pip_install:
  pip.installed:
    - name: global pip installation
    - requirements: salt://packages/requirements/global_requirements.txt
    - require:
      - sls: packages.system_packages

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
{#
#{% for file in salt['cp.list_master'](prefix='generic/files') %}
#install_repo_{{ file }}:
#  file.managed:
#    - name: /etc/yum.repos.d/{{ file }}
#    - source: salt://generic/files/{{ file }}
#    - template: jinja
#{% endfor %}
#}

