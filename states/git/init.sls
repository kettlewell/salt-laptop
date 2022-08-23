#!jinja|yaml
include:
  - users.create-users

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{% if ( (user_config.git_repos_https is defined and user_config.git_repos_https) or
      (user_config.git_repos_ssh is defined and user_config.git_repos_ssh) )  %}

/home/{{ user }}/git:
  file.directory:
    - require:
      - sls: users.create-users
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - makedirs: True

{% endif %}

{% if (user_config.git_repos_https is defined and user_config.git_repos_https) %}
{% set http_repo = user_config.git_repos_https %}

{% for repo in http_repo %}

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
{% endif %}

{% if (user_config.git_repos_ssh is defined and user_config.git_repos_ssh) %}
{% set ssh_repo = user_config.git_repos_ssh %}

{% for repo in ssh_repo %}
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
{% endif %}

{% set user_name = user  if user_config.custom_gitignore is defined and user_config.custom_gitignore else 'default' %}

{% if user_name != 'default' %}

/home/{{ user }}/.gitignore_global:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{user}}/gitignore_global
    - user: {{user}}
    - group: {{user}}
    - mode: 644

{% endif %}

{% set user_name = user  if user_config.custom_gitconfig is defined and user_config.custom_gitconfig else 'default' %}
{% if user_name != 'default' %}

/home/{{ user }}/.gitconfig:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{user}}/gitconfig
    - user: {{user}}
    - group: {{user}}
    - mode: 644
{% endif %}

{% endfor %}
