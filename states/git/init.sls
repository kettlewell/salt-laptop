#!jinja|yaml
include:
  - users.create-users

{% import_yaml 'users/data/users.yaml' as users_file %}
{% for user, userattr in users_file['users'].items() %}
{% if userattr.git_repos_https is defined and userattr.git_repos_https %}

/home/{{ user }}/git:
  file.directory:
    - requires:
      - sls: users.create-users
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - makedirs: True


{% for http_repo in userattr.git_repos_https %}
git_clone_{{http_repo}}:
  git.cloned:
    - name: {{ http_repo}}
    - target: /home/{{ user }}/git
    - requires:
      - sls: users.create-users
      - file: /home/{{ user }}/git
    user: {{user}}

{% endif %}
{% endfor %}