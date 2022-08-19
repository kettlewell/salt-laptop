# inspired by: https://github.com/jackscott/golang-formula
# official install instructions: https://go.dev/doc/install

{% import_yaml 'data/system_data.yml' as system_data %}

{% set golang       =  system_data.system.golang  %}
{% set go_version   =  golang.version             %}
{% set go_checksum  =  golang.checksum            %}
{% set go_filename  =  golang.filename            %}
{% set go_url       =  golang.url                 %}
{% set go_prefix    =  golang.prefix              %}


golang_install:
  archive.extracted:
    - name: {{ go_prefix }}
    - source: {{ go_url }}
    - source_hash: {{ go_checksum}}
    - archive_format: tar
    - user: root
    - group: root
    - options: v
    - trim_output: True 
    - unless:
        - go version | grep {{ go_version }}



# sets up the necessary environment variables required for golang usage
golang_bash_profile:
  file.managed:
    - name: /etc/profile.d/golang.sh
    - source:
        - salt://packages/files/golang_profile.jinja
    - template: jinja
    - context:
        go_prefix: {{ go_prefix }}
    - mode: 644
    - user: root
    - group: root


{% set go_basedir = '%s/golang/%s'|format(go_prefix, go_version) %}

test-go-basedir:
  cmd.run:
    - name: echo {{ go_basedir }}
