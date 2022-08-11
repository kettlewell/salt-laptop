#!/usr/bin/env bash

which salt > /dev/null 2>&1
SALT_INSTALLED=$?
if [[ ${SALT_INSTALLED} -eq 0 ]]; then
    SALT_VERSION=$(salt --version)
    if [[ "${SALT_VERSION}" != "${EXPECTED_SALT_VERSION}" ]]; then
	printf "VERSIONS DONT MATCH... BOOTSTRAPPING SALT\n\n"
	curl -L https://bootstrap.saltproject.io | sudo sh -s -- -x python3 \
          -P \
          git ${salt_git_tag}
	systemctl stop salt-minion
    else
	printf "VERSIONS MATCH - NOT BOOTSTRAPPING\n"
    fi
fi
