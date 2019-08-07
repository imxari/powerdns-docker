#!/bin/bash

# ========================================================================
#
# Name: verify_db.sh
# By: Holy, https://lab.lkeenan.co.uk/h0lysp4nk
#
# ========================================================================

MYSQLCMD="mysql --host=${MARIADB_HOST} --user=${MARIADB_USER} --password=${MARIADB_PASS} --port=${MARIADB_PORT} -r -N ${MARIADB_DATABASE}"
$MYSQLCMD -e 'SELECT * FROM domains ORDER BY id LIMIT 1'

if [ $? -eq 0 ]; then
    echo "[!] PowerDNS schema appears to be intact..."
else
    echo "[!] PowerDNS schema is missing! Exiting..."
    exit 1
fi
