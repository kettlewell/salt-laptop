group_docker:
  group.present:
    - name: docker
    - system: True
    - addusers:
      - matt
