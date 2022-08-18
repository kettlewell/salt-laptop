#!/usr/bin/env bash

# backup the saltmaster private key as part of the 
# maintenance process for later recoverablity, if ever needed.

# NOTE: the master keys should NEVER be committed to the repository
# NOTE2: the master keys should be stored in at least 2 locations


# Assume that the saltmaster gpg directory is in a static location.
GPG_DIR="${HOME}/gpgkeys"
GPG_BIN=$(type -P gpg)
GPG="${GPG_BIN} --homedir ${GPG_DIR}"
GPG_TMP_DIR=${GPG_DIR}/tmp

usage () {
    echo "usage"
}

verify() {
    ${GPG} --list-keys
    ${GPG} --list-secret-keys
}

while getopts 'vf:' OPTION; do
  case "$OPTION" in
    v)
      verify; exit
      ;;

  esac
done

shift "$(($OPTIND -1))"

#: ${FILE:?Missing -f} ${RECIPIENT:?Missing -r}

for x in "$@"
do
  echo $x
done

mkdir -p ${GPG_TMP_DIR}

# export public keys
 ${GPG} -a --export > ${GPG_TMP_DIR}/mypubkeys.asc

# export private keys
 ${GPG} -a --export-secret-keys > ${GPG_TMP_DIR}/myprivatekeys.asc

 ${GPG} --export-ownertrust > ${GPG_TMP_DIR}/otrust.txt
