#!/usr/bin/env bash

# started from:
# https://eitr.tech/blog/2021/11/12/salt-masterless.html

#rpm --import https://repo.saltproject.io/py3/redhat/8/x86_64/latest/SALTSTACK-GPG-KEY.pub
#curl -fsSL https://repo.saltproject.io/py3/redhat/8/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo

mkdir -p /srv

cd /srv

if [[ ! -d "/srv/salt-laptop" ]]; then
    git clone -f https://github.com/kettlewell/salt-laptop.git
else
    git -C /srv/salt-laptop pull
fi


curl -L https://bootstrap.saltproject.io | sudo sh -s -- -x python3 \
    -j '{"master_type": "disable", \
       	 "file_roots": \
	 	       { \
                        "base": ["/srv/salt-laptop/states"] \
                       }, \
         "pillar_roots": \
	 	       { \
                        "base": ["/srv/salt-laptop/pillars"] \
                       }, \
         "startup_states": "highstate", \
	 "pub_ret": false, \
	 "mine_enabled": false, \
	 "return": "rawfile_json", \
	 "top_file_merging_strategy": "merge_all", \
	 "file_client": "local"}' \
    -P \
    git v3005rc2

systemctl stop salt-minion



