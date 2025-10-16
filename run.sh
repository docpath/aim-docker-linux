#!/bin/bash

bbdd_conf='/usr/local/docpath/AccessIdentityManagement/AccessIdentityManagement/Configuration/accessidentitymanagement-db.xml'
install_props='/usr/local/docpath/AccessIdentityManagement/install.properties'
ini='/usr/local/docpath/AccessIdentityManagement/AccessIdentityManagement/Configuration/dpaim.ini'
INI_FILE="/usr/local/docpath/AccessIdentityManagement/AccessIdentityManagement/Configuration/dpaim.ini"

# Extraer la fecha del archivo, asegurando que solo tomamos la segunda línea después de #, es decir ingoramos la de author
fecha=$(grep -oP '(?<=#).+' "$install_props" | sed -n '2p' | xargs)  # Elimina espacios extra

# Convertir la fecha obtenida del install.properties a timestamp
activeDatabaseId=$(date -d "$fecha" +%s 2>/dev/null)

# Verificar si la conversión fue exitosa
if [[ -z "$activeDatabaseId" ]]; then
    echo "Error: No se pudo generar un activeDatabaseId válido."
    exit 1
fi

db_host="${DB_HOST-'localhost'}"
db_port="${DB_PORT-'3306'}"
db_user="${DB_USER-'root'}"
db_pass="${DB_PASS-'root'}"
db_name="${DB_NAME-'aim'}"
db_info="${DB_INFO:-$activeDatabaseId}"
db_info=$((db_info))


license_address="${LICENSE_ADDRESS}"
license_port="${LICENSE_PORT}"
transaction_id="${TRANSACTION_ID}"
shutdown_session="${SHUTDOWN_SESSION}"

# Usamos `awk` para modificar la sección [license] del ini sin afectar a las demas
awk -v addr="$license_address" -v port="$license_port" -v tid="$transaction_id" -v cls="$shutdown_session" '
BEGIN { inside_section=0 }
/^\[license\]/ { inside_section=1; print; next }
inside_section==1 && /^\[/ { inside_section=0 }  # Si llega otra sección, sale de [license]

inside_section==1 && /^address/ { print "address = " addr; next }
inside_section==1 && /^port/ { print "port = " port; next }
inside_section==1 && /^transaction id/ { print "transaction id = " tid; next }
inside_section==1 && /^close license session/ { print "close license session = " cls; next }

{ print }' "$INI_FILE" > temp.ini && mv temp.ini "$INI_FILE"

echo '<?xml version="1.0" encoding="UTF-8"?>' > "$bbdd_conf"
echo '<configurations>' >> "$bbdd_conf"
echo "  <activeDatabaseId>$db_info</activeDatabaseId>" >> "$bbdd_conf"
echo "  <database id=\"$db_info\">" >> "$bbdd_conf"
echo "    <databaseHost>$db_host</databaseHost>" >> "$bbdd_conf"
echo '    <databaseWinAuth>false</databaseWinAuth>' >> "$bbdd_conf"
echo "    <databasePort>$db_port</databasePort>" >> "$bbdd_conf"
echo '    <databaseType>MySQL</databaseType>' >> "$bbdd_conf"
echo "    <databaseUser>$db_user</databaseUser>" >> "$bbdd_conf"
echo "    <databasePass>$db_pass</databasePass>" >> "$bbdd_conf"
echo "    <databaseName>$db_name</databaseName>" >> "$bbdd_conf"
echo '  </database>' >> "$bbdd_conf"
echo '</configurations>' >> "$bbdd_conf"


cd /usr/local/docpath/licenseserver/licenseserver/Bin
./startServer.sh

cd /usr/local/docpath/AccessIdentityManagement/AccessIdentityManagement/Bin
exec bash startAim.sh
