 Defina as variáveis para os valores necessários

PFSENSE_URL="https://172.16.20.1"

PFSENSE_USER=""

PFSENSE_PASS=""



# Defina os parâmetros da regra de firewall

SOURCE="lan"

DESTINATION="any"

PROTOCOL="tcp"

SOURCE_PORT="any"

DEST_PORT="9213"

TYPE="pass"





# Use o comando curl para autenticar e adicionar a regra de firewall

curl -k -L --request POST --url "${PFSENSE_URL}/api/v1/firewall/rule/" \

     --header 'Content-Type: application/json' \

     --data '{

       "interface": "lan",

       "ipprotocol": "inet",

       "protocol": "'"$PROTOCOL"'",

       "descr": "Regra de firewall adicionada via API",

       "src": "'"$SOURCE"'",

       "dst": "'"$DESTINATION"'",

       "dstport": "'"$DEST_PORT"'",

       "srcport": "'"$SOURCE_PORT"'",

       "apply": "true",

       "type": "'"$TYPE"'"

     }' \

     --user "${PFSENSE_USER}:${PFSENSE_PASS}"
