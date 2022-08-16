#!jinja|yaml
include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}
{% if userattr.git_repos_https is defined and userattr.git_repos_https %}

/home/{{ user }}/git:
  file.directory:
    - require:
      - sls: users.create-users
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - makedirs: True


{% set http_repo = userattr.git_repos_https %}
{% for repo in http_repo %}
{% set git_url = repo.url + '/' + repo.dir + '.git' %}


git_clone_:
  git.cloned:
    - name: {{ git_url }}
    - target: /home/{{ user }}/git/{{ repo.dir }}
    - require:
      - sls: users.create-users
      - file: /home/{{ user }}/git
    - user: {{user}}

{% endfor %}
{% endif %}
{% endfor %}