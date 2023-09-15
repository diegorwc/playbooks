@echo off
rem Defina as variáveis para os valores necessários

set PFSENSE_URL=https://192.168.1.9
set PFSENSE_USER=
set PFSENSE_PASS=

:: Defina os parâmetros da regra de firewall
set SOURCE=lan
set DESTINATION=any
set PROTOCOL=tcp
set SOURCE_PORT=any
set DEST_PORT=8000
set TYPE=pass

:: Crie um arquivo JSON temporário
(
echo {
echo   "interface": "lan",
echo   "ipprotocol": "inet",
echo   "protocol": "%PROTOCOL%",
echo   "descr": "Regra de firewall adicionada via API",
echo   "src": "%SOURCE%",
echo   "dst": "%DESTINATION%",
echo   "dstport": "%DEST_PORT%",
echo   "srcport": "%SOURCE_PORT%",
echo   "apply": true,
echo   "type": "%TYPE%"
echo }
) > temp.json

:: Use o comando curl para autenticar e adicionar a regra de firewall
curl -k -L --request POST --url "%PFSENSE_URL%/api/v1/firewall/rule/" ^
     --header "Content-Type: application/json" ^
     --data @temp.json ^
     --user "%PFSENSE_USER%:%PFSENSE_PASS%"

:: Exclua o arquivo JSON temporário
@REM del temp.json

endlocal
