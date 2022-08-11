#!/usr/bin/env bash

SALT_GIT_TAG="{{ salt_git_tag }}"
EXPECTED_SALT_VERSION="{{ expected_salt_version }}"
SALT_VERSION="$(salt --version)"

echo "SALT_GIT_TAG: ${SALT_GIT_TAG}"
echo "EXPECTED_SALT_VERSION: ${EXPECTED_SALT_VERSION}"
echo "SALT_VERSION: ${SALT_VERSION}"

if [[ "${SALT_VERSION}" != "${EXPECTED_SALT_VERSION}" ]]; then
    curl -s -L https://bootstrap.saltproject.io | sudo sh -s -- \
							   -P \
							   -q \
          git ${SALT_GIT_TAG}
fi
