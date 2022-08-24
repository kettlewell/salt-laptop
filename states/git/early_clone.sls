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


{% if (repo_config.dir is defined and repo_config.dir) %}
{% set repo_dir = repo_config.dir %}
{% else %}
{% set repo_dir = salt['file.basename'](repo_config.url) | replace(".git", "") %}
{% endif %}

git_clone_{{ repo_config.url }}:
  git.cloned:
    - name: {{ repo_config.url }}
    - target: /home/{{ user }}/git/{{ repo_dir }}
    - require:
      - sls: users.create-users
      - file: /home/{{ user }}/git
    - user: {{user}}



{% endfor %}

{% endif %}

{% endfor %}
