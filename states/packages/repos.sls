vscode_repo:
  pkgrepo.managed:
    - humanname: VS Code REPO
    - name: vscode
    - baseurl: https://packages.microsoft.com/yumrepos/vscode/
    - enabled: 1
    - gpgcheck: 1
    - repo_gpgcheck: 1
    - gpgkey: https://packages.microsoft.com/keys/microsoft.asc
    - metadata_expire: 1h
    - gpgautoimport: 1


# docker workarounds found in this gist:
# https://gist.github.com/ScriptAutomate/77775f26c6640d184b0574065ff94d64
docker_repo:
  cmd.run:
    - name: |
        yum install -y yum-utils
        yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo


enable_rocky_crb_repo:
  cmd.run:
    - name: |
        dnf config-manager --set-enabled crb



# PGADMIN4

# PGDG

# SLACK

# SPOTIFY

# VIRTUALBOX
