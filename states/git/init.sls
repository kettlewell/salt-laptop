#!jinja|yaml
include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}

{% if ( (userattr.git_repos_https is defined and userattr.git_repos_https) or 
      (userattr.git_repos_ssh is defined and userattr.git_repos_ssh) )  %}

/home/{{ user }}/git:
  file.directory:
    - require:
      - sls: users.create-users
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - makedirs: True

{% endif %}

{% if (userattr.git_repos_https is defined and userattr.git_repos_https) %}
{% set http_repo = userattr.git_repos_https %}

{% for repo in http_repo %}
{% set git_url = repo.url + '/' + repo.dir + '.git' %}

git_clone_{{ git_url }}:
  git.cloned:
    - name: {{ git_url }}
    - target: /home/{{ user }}/git/{{ repo.dir }}
    - require:
      - sls: users.create-users
      - file: /home/{{ user }}/git
    - user: {{user}}

{% endfor %}
{% endif %}

{% if (userattr.git_repos_ssh is defined and userattr.git_repos_ssh) %}
{% set ssh_repo = userattr.git_repos_ssh %}

{% for repo in ssh_repo %}
{% set git_url = repo.url + '/' + repo.dir + '.git' %}

git_clone_{{ git_url }}:
  git.cloned:
    - name: {{ git_url }}
    - target: /home/{{ user }}/git/{{ repo.dir }}
    - require:
      - sls: users.create-users
      - file: /home/{{ user }}/git
    - user: {{user}}

{% endfor %}
{% endif %}

{% set user_name = user  if userattr.custom_gitignore is defined and userattr.custom_gitignore else 'default' %}

{% if user_name != 'default' %}

/home/{{ user }}/.gitignore_global:
  file.managed:
    - require:
      - sls: users.create-users
    - source: salt://users/files/{{user}}/gitignore
    - user: {{user}}
    - group: {{user}}
    - mode: 644

{% endif %}

{% set user_name = user  if userattr.custom_gitconfig is defined and userattr.custom_gitconfig else 'default' %}
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