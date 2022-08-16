# third party packages

# google chrome RPM installs three things:
# 1) signing keys
# 2) repository files
# 3) binary packages
google_chrome_stable:
  pkg.installed:
    - pkg_verify: True
    - sources:
      - direct: https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

