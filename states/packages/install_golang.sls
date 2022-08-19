# inspired by: https://github.com/jackscott/golang-formula

{% import_yaml 'data/system_data.yml' as system_data %}

{% set golang = system_data.system.golang %}

{% set go_version = golang.version %}


test-gpg:
  cmd.run:
    - name: echo "{{ go_version }}"
