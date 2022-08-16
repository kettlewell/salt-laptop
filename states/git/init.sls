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


{% for http_repo_name,http_repo_dir in userattr['git_repos_https'].items() %}
git_clone_{{http_repo_name}}:
  git.cloned:
    - name: {{ http_repo_name}}
    - target: /home/{{ user }}/git/{{http_repo_dir }}
    - require:
      - sls: users.create-users
      - file: /home/{{ user }}/git
    - user: {{user}}
{% endfor %}

{% endif %}
{% endfor %}