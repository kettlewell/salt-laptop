#!/usr/bin/env bash

SALT_GIT_TAG={{ salt_git_tag }}
EXPECTED_SALT_VERSION="salt ${SALT_GIT_TAG}"
echo "SALT_GIT_TAG: ${SALT_GIT_TAG}"
echo "EXPECTED_SALT_VERSION: ${EXPECTED_SALT_VERSION}"

which salt > /dev/null 2>&1
SALT_INSTALLED=$?
echo "SALT_INSTALLED: ${SALT_INSTALLED}"
if [[ ${SALT_INSTALLED} -eq 0 ]]; then
    SALT_VERSION=$(salt --version)
    echo "SALT_VERSION: ${SALT_VERSION}"
    if [[ "${SALT_VERSION}" != "${EXPECTED_SALT_VERSION}" ]]; then
	curl -s -L https://bootstrap.saltproject.io | sudo sh -s -- \
							   -P \
							   -q \
          git ${SALT_GIT_TAG}
    fi
fi
