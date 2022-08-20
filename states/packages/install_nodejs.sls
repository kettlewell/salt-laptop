
{% import_yaml 'data/system_data.yml' as system_data %}

{% set nodejs       =  system_data.system.nodejs  %}

{% set nodejs_version   =  nodejs.version             %}
{% set nodejs_checksum  =  nodejs.checksum            %}
{% set nodejs_filename  =  nodejs.filename            %}
{% set nodejs_url       =  nodejs.url                 %}
{% set nodejs_prefix    =  nodejs.prefix              %}

{% set nodejs_binpath   =  '%s/nodejs/node-%s-%s'|format(nodejs_prefix, nodejs_version, nodejs_distro) %}

nodejs_install:
  archive.extracted:
    - name: {{ nodejs_prefix }}
    - source: {{ nodejs_url }}
    - source_hash: {{ nodejs_checksum}}
    - archive_format: tar
    - user: root
    - group: root
    - options: v
    - trim_output: True 
    - unless:
        - node -v | grep {{ nodejs_version }}
        
# sets up the necessary environment variables required for nodejs usage
nodejs_bash_profile:
  file.managed:
    - name: /etc/profile.d/nodejs.sh
    - source:
        - salt://packages/files/nodejs_profile.jinja
    - template: jinja
    - context:
        nodejs_prefix: {{ nodejs_prefix }}
    - mode: 644
    - user: root
    - group: root



test-nodejs-binpath:
  cmd.run:
    - name: echo {{ nodejs_binpath }}
    - unless:
        - node -v | grep {{ nodejs_version }}
