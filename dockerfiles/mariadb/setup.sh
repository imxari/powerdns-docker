#!/bin/bash

# ==========================================
# Name: setup.sh
# By  : H0lysp4nk
# 2019 Copyright: H0lysp4nk All Rights Reserved.
# ==========================================

set -e
sed -i "s/CLUSTERPEERS/$(echo $MARIADB_PEERS | sed -e 's/\\/\\\\/g; s/\//\\\//g; s/&/\\\&/g')/g" /etc/mysql/conf.d/galera.cnf
sed -i s/CLUSTERNAME/"$MARIADB_CNAME"/ /etc/mysql/conf.d/galera.cnf
sed -i s/NODEADDRESS/"$MARIADB_NADDRESS"/ /etc/mysql/conf.d/galera.cnf
sed -i s/NODENAME/"$MARIADB_NNAME"/ /etc/mysql/conf.d/galera.cnf

exec /usr/local/bin/docker-entrypoint.sh "$@"
