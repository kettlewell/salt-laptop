# third party packages

# google chrome RPM installs three things:
# 1) signing keys
# 2) repository files
# 3) binary packages
#google_chrome_stable:
#  pkg.installed:
#    - pkg_verify: True
#    - sources:
#      - https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

google_chrome_stable:
  pkg.installed:
    - sources:
      - google-chrome-stable: https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
    - skip_verify: false
    - pkg_verify: true
    - reload_modules: true
