#!/bin/bash

# ========================================================================
#
# Name: install_db.sh
# By: Holy, https://github.com/h0lysp4nk
#
# ========================================================================

MYSQLCMD="mysql --host=${MARIADB_HOST} --user=${MARIADB_USER} --password=${MARIADB_PASS} --port=${MARIADB_PORT} -r -N ${MARIADB_DATABASE}"

# Verify that the required files exist
echo "==========[ File Check ]==========="
if [ -e /bootstrap/pdns_schema.sql ]; then
    echo "[!] /bootstrap/pdns_schema.sql existance... Found"
else
    echo "[!] /bootstrap/pdns_schema.sql existance... Found"
    exit 1
fi
echo "==================================="
echo

if [ "$INSTALL_DATABASE" -eq "1" ]; then
    echo "[!] Inserting PowerDNS Schema..."
    cat /bootstrap/pdns_schema.sql | $MYSQLCMD
    if [ $? -eq 0 ]; then
        echo "[!] PowerDNS Schema inserted!"
    else
        echo "[!] PowerDNS Schema couldn't be inserted! Exiting..."
        exit 1
    fi
else
    echo "[!] Skipping steps to insert database..."
fi
