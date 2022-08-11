#!/usr/bin/env bash

SALT_GIT_TAG={{ salt_git_tag }}
EXPECTED_SALT_VERSION="salt ${SALT_GIT_TAG}"

which salt > /dev/null 2>&1
SALT_INSTALLED=$?
if [[ ${SALT_INSTALLED} -eq 0 ]]; then
    SALT_VERSION=$(salt --version)
    if [[ "${SALT_VERSION}" != "${EXPECTED_SALT_VERSION}" ]]; then
	curl -s -L https://bootstrap.saltproject.io | sudo sh -s -- -x python3 \
          -P \
          git ${SALT_GIT_TAG}
    fi
fi
