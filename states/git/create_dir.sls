#!jinja|yaml
include:
  - users.create-users

{% import_yaml 'data/users_data.yml' as users_data %}
{% set users  =  users_data.users  %}
{% for user, user_config in users.items() %}


{% if ( (user_config.git_repos_https is defined and user_config.git_repos_https) or
      (user_config.git_repos_ssh is defined and user_config.git_repos_ssh)  or
      (user_config.git_early_clone is defined and user_config.git_early_clone) )  %}

/home/{{ user }}/git:
  file.directory:
    - require:
      - sls: users.create-users
    - user: {{ user }}
    - group: {{ user }}
    - mode: 755
    - makedirs: True

{% endif %}

{% endfor %}
