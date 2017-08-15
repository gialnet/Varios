#!/bin/sh

# borrar los archivos de log con una antigüedad superior a 5 y 10 días
# En la base de datos de desarrollo y pruebas de Redmoon
# por ahora la de pruebas de aguas y servicios de la Costa Tropical

find /u03/flash_recovery_area/log/manco -name "*arc*" -atime +5 -type f -print -exec rm {} \;

find /u03/flash_recovery_area/log/aysct -name "*arc*" -atime +10 -type f -print -exec rm {} \;

find /u02/oradata/log/manco -name "*arc*" -atime +5 -type f -print -exec rm {} \;

find /u02/oradata/log/aysct -name "*arc*" -atime +10 -type f -print -exec rm {} \;
