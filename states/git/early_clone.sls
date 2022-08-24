#!jinja|yaml
include:
  - users.create-users
  - git.create_dir

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{% if (user_config.git_early_clone is defined and user_config.git_early_clone) %}
{% set early_clone_repo = user_config.git_early_clone %}
{% for repo_name,repo_config in early_clone_repo.items() %}

repo_name-{{repo_name}}:
  cmd.run:
    - name: echo {{ repo_name }}

repo_config_dir-{{repo_config.dir}}:
  cmd.run:
    - name: echo {{ repo_config.dir }}

{#

{% for repo in repo_config %}

{% if (repo.dir is defined and repo.dir) %}
{% set repo_dir = repo.dir %}
{% else %}
{% set repo_dir = salt['file.basename'](repo.url) | replace(".git", "") %}
{% endif %}

git_clone_{{ repo.url }}:
  git.cloned:
    - name: {{ repo.url }}
    - target: /home/{{ user }}/git/{{ repo_dir }}
    - require:
      - sls: users.create-users
      - file: /home/{{ user }}/git
    - user: {{user}}

{% endfor %}

#}

{% endfor %}

{% endif %}


{% endfor %}
