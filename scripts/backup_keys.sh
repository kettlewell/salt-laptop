#!/usr/bin/env bash

# reference: https://access.redhat.com/solutions/2115511
# backup the saltmaster private key as part of the 
# maintenance process for later recoverablity, if ever needed.

# NOTE: the master keys should NEVER be committed to the repository
# NOTE2: the master keys should be stored in at least 2 locations


# Assume that the saltmaster gpg directory is in a static location.
GPG_DIR="${HOME}/gpgkeys"
GPG_BIN=$(type -P gpg)
GPG="${GPG_BIN} --homedir ${GPG_DIR}"
GPG_TMP_DIR=${GPG_DIR}/tmp
BACKUP_DIR=${HOME}/backups
mkdir -p ${BACKUP_DIR}
chmod 700 ${BACKUP_DIR}

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

sudo salt-call pillar.get ssh_keys_encrypted >  ${GPG_TMP_DIR}/ssh_keys.txt

filename="${BACKUP_DIR}/keys-$(date '+%Y-%m-%d-%H-%M-%S').tar.xz"

XZ_OPT='-4' tar -Jcvf ${filename} ${GPG_DIR}

chmod 400 ${filename}

printf "\nbackup complete.\n"
printf "file saved to ${filename}\n\n"
