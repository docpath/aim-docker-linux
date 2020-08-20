#!/bin/bash

bbdd_conf='/usr/local/docpath/AccessIdentityManagement/AccessIdentityManagement/Configuration/accessidentitymanagement-db.xml'
db_host="${DB_HOST-'localhost'}"
db_port="${DB_PORT-'3306'}"
db_user="${DB_USER-'root'}"
db_pass="${DB_PASS-'root'}"
db_name="${DB_NAME-'aim'}"

echo '<?xml version="1.0" encoding="UTF-8"?>' > "$bbdd_conf"
echo '<configurations>' >> "$bbdd_conf"
echo '  <activeDatabaseId>1820448134</activeDatabaseId>' >> "$bbdd_conf"
echo '  <database id="1820448134">' >> "$bbdd_conf"
echo "    <databaseHost>$db_host</databaseHost>" >> "$bbdd_conf"
echo '    <databaseWinAuth>false</databaseWinAuth>' >> "$bbdd_conf"
echo "    <databasePort>$db_port</databasePort>" >> "$bbdd_conf"
echo '    <databaseType>MySQL/MariaDB</databaseType>' >> "$bbdd_conf"
echo "    <databaseUser>$db_user</databaseUser>" >> "$bbdd_conf"
echo "    <databasePass>$db_pass</databasePass>" >> "$bbdd_conf"
echo "    <databaseName>$db_name</databaseName>" >> "$bbdd_conf"
echo '  </database>' >> "$bbdd_conf"
echo '</configurations>' >> "$bbdd_conf"

cd /usr/local/docpath/licenseserver/licenseserver/Bin
./startServer.sh

cd /usr/local/docpath/AccessIdentityManagement/AccessIdentityManagement/Bin
exec bash aim_deployer.sh

