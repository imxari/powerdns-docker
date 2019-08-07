#!/bin/bash

# ========================================================================
#
# Name: install_db.sh
# By: Holy, https://lab.lkeenan.co.uk/h0lysp4nk
#
# ========================================================================

set -e
sed -i s/PDNSSOAMAIL/"$PDNS_SOA_MAIL"/ /etc/powerdns/pdns.conf
sed -i s/PDNSSOANAME/"$PDNS_SOA_NAME"/ /etc/powerdns/pdns.conf
sed -i s/PDNSAPIKEY/"$PDNS_API_KEY"/ /etc/powerdns/pdns.conf
sed -i s/MARIADBHOST/"$MARIADB_HOST"/ /etc/powerdns/pdns.d/pdns.local.gmysql.conf
sed -i s/MARIADBPORT/"$MARIADB_PORT"/ /etc/powerdns/pdns.d/pdns.local.gmysql.conf
sed -i s/MARIADBUSER/"$MARIADB_USER"/ /etc/powerdns/pdns.d/pdns.local.gmysql.conf
sed -i s/MARIADBPASS/"$MARIADB_PASS"/ /etc/powerdns/pdns.d/pdns.local.gmysql.conf
sed -i s/MARIADBNAME/"$MARIADB_DATABASE"/ /etc/powerdns/pdns.d/pdns.local.gmysql.conf

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

# Run install_db.sh
bash /bootstrap/install_db.sh

if [ ! $? -eq 0 ]; then
    echo "[!] install_db.sh failed!"
    exit 1
fi

# Run verify_db.sh
bash /bootstrap/verify_db.sh
if [ ! $? -eq 0 ]; then
    echo "[!] verify_db.sh failed!"
    exit 1
fi

# Run PowerDNS
/usr/sbin/pdns_server --guardian=no --daemon=no --disable-syslog --log-timestamp=no --write-pid=no
