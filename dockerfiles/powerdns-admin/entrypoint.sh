#!/bin/bash

# ========================================================================
#
# Name: install_db.sh
# By: Holy, https://lab.lkeenan.co.uk/h0lysp4nk
#
# ========================================================================

set -e
sed -i s/MARIADBHOST/"$MARIADB_HOST"/ /powerdns-admin/config.py
sed -i s/MARIADBPORT/"$MARIADB_PORT"/ /powerdns-admin/config.py
sed -i s/MARIADBUSER/"$MARIADB_USER"/ /powerdns-admin/config.py
sed -i s/MARIADBPASS/"$MARIADB_PASS"/ /powerdns-admin/config.py
sed -i s/MARIADBNAME/"$MARIADB_DATABASE"/ /powerdns-admin/config.py

# Wait for MariaDB to start...
MYSQLCMD="mysql --host=${MARIADB_HOST} --user=${MARIADB_USER} --password=${MARIADB_PASS} --port=${MARIADB_PORT} -r -N"

# wait for Database come ready
dbOnline () {
	echo "SHOW STATUS" | $MYSQLCMD 1>/dev/null
	echo $?
}

RETRY=15
until [ `dbOnline` -eq 0 ] || [ $RETRY -le 0 ] ; do
	echo "[!] Waiting for MariaDB to start..."
	sleep 5
	RETRY=$(expr $RETRY - 1)
done
if [ $RETRY -le 0 ]; then
	>&2 echo "[!] ERROR! MariaDB isn't accessible!"
	exit 1
fi

cd /powerdns-admin/

export FLASK_APP=app/__init__.py
flask db upgrade
yarn install --pure-lockfile
flask assets build

# Run PowerDNS-Admin
/powerdns-admin/run.py
