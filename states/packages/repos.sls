
# virtualbox
# spotify
# slack
# pgdg
# pgadmin4
# llvm
# helm ?
# google-chrome
# docker


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

#    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc




epel_release:
  pkg.installed:
    - pkgs:
      - epel-release