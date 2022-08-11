#!/usr/bin/env bash

set -x

# started from:
# https://eitr.tech/blog/2021/11/12/salt-masterless.html

SALT_GIT_TAG="v3005rc2"
EXPECTED_SALT_VERSION="salt 3005rc2bogus"

declare -a FORMULAS
FORMULAS[0]="vscode-formula"



mkdir -p /srv

cd /srv

if [[ ! -d "/srv/salt-laptop" ]]; then
    git -C /srv clone https://github.com/kettlewell/salt-laptop.git
else
    git -C /srv/salt-laptop pull
fi


which salt > /dev/null 2>&1
SALT_INSTALLED=$?
if [[ ${SALT_INSTALLED} -eq 0 ]]; then
    SALT_VERSION=$(salt --version)
    if [[ "${SALT_VERSION}" != "${EXPECTED_SALT_VERSION}" ]]; then
	printf "VERSIONS DONT MATCH... BOOTSTRAPPING SALT\n\n"
	curl -L https://bootstrap.saltproject.io | sudo sh -s -- -x python3 \
          -P \
          git ${SALT_GIT_TAG}
	systemctl stop salt-minion
    else
	printf "VERSIONS MATCH - NOT BOOTSTRAPPING\n"
    fi
fi



#mkdir -p /srv/formulas

#cd /srv/formulas


#for formula in ${FORMULAS[@]}; do
#    if [[ ! -d "/srv/salt-laptop" ]]; then
#	git -C /srv/formulas clone  https://github.com/kettlewell/${formula}.git
#    else
#	git -C /srv/formulas/${formula} pull
#    fi
#done





	  # -j '{"master_type": "disable", \
       	  # "file_roots": \
	  # 	       { \
          #               "base": ["/srv/salt-laptop/states"] \
          #              }, \
          # "pillar_roots": \
	  # 	       { \
          #               "base": ["/srv/salt-laptop/pillars"] \
          #              }, \
          # "startup_states": "highstate", \
	  # "pub_ret": false, \
	  # "mine_enabled": false, \
	  # "return": "rawfile_json", \
	  # "top_file_merging_strategy": "merge_all", \
	  # "file_client": "local"}' \
