#!/bin/sh

clear

FICHERO=expdpAGUAS-`date '+%Y%m%d'`.dmp


#ejecuta el script

echo "Lanzar el script de exportación de Aguas y Servicios"

ssh -t -i EuropaMaria.pem root@46.137.177.203 "su - oracle /home/oracle/copiaAguas.sh"

echo "EXPORT REALIZADO"

scp -i EuropaMaria.pem root@46.137.177.203:/home/oracle/exportaciones/$FICHERO $FICHERO

echo "proceso finalizado"

exit
