
# SYS
#CREATE OR REPLACE DIRECTORY CopiasAguas AS '/home/oracle/exportaciones/';
#GRANT READ, WRITE ON DIRECTORY CopiasAguas TO registro_as;


expdp registro_as/R3dm00n3632 schemas=registro_as directory=CopiasAguas dumpfile=Aguas8mayo2012.dmp logfile=expdpAGUAS8may.log


# borrar archivelogs antiguos

find /u03/flash_recovery_area/log/manco -name "*" -atime +4 -type f -print -exec rm {} \;

find /u03/flash_recovery_area/log/manco -name "*" -atime +4 -type f -print | sort


find /u03/flash_recovery_area/log/aysct -name "*" -atime +4 -type f -print | sort

find /u03/flash_recovery_area/log/aysct -name "*" -atime +6 -type f -print  -exec rm {} \;

find /u02/oradata/log/manco -name "*" -atime +6 -type f -print  -exec rm {} \;

find /u02/oradata/log/aysct -name "*" -atime +6 -type f -print  -exec rm {} \;

