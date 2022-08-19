docker:
  pkg.installed:
    - refresh: True
    - pkgs:
      - docker-ce
      - docker-ce-cli
      - containerd.io
    - require:
      - cmd: docker_repo
    - aggregate: False

#  service.running:
#    - enable: True
#    - require:
#      - pkg: docker
