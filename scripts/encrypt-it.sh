#!/usr/bin/env bash

RECIPIENT="SALT-MASTER-1"

while getopts 'r:f:' OPTION; do
  case "$OPTION" in
    r)
      RECIPIENT=${OPTARG}
      echo "overriding Recipient"
      ;;

    f)
      FILE="$OPTARG"
      echo "Setting File: ${FILE}"
      ;;

  esac
done

shift "$(($OPTIND -1))"

: ${FILE:?Missing -f} ${RECIPIENT:?Missing -r}

for x in "$@"
do
  echo $x
done


# make sure we're not using an alias
CAT=$(type -P cat)
GPG=$(type -P gpg)

echo "#!jinja|yaml|gpg" > ${FILE}.sls

echo "${FILE}: |" >> ${FILE}.sls
#${CAT} ${FILE} | ${GPG} --output ${FILE}.asc --armor --encrypt --trust-model always -r ${RECIPIENT} | sed 's/^/  /' >> ${FILE}.sls
${CAT} ${FILE} | ${GPG} --armor --encrypt --trust-model always -r ${RECIPIENT} | sed 's/^/  /' >> ${FILE}.sls