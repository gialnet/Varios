#!/bin/sh

# Exporta la última versión de desarrollo, primero comprueba que exista una disponible ya en el disco duro
# en la carpeta 'copias' /home/oracle/datapum/lgs_dumpv1.dmp

# Importa a un nuevo esquema de usuario previamente creado 

# Antonio Pérez

# 19 ENERO 2012 ver 1.0

# invocar con ./clonar_usuario 

# necesita que el usuario system pueda acceder al oracle directory COPIAS

# Este es el primer script con el que comienza la secuencia de crear un nuevo cliente
# despues va el script crear_esquema.sh

clear

nuevo_usuario=$1

echo "Exportando el esquema registro_lgs"

echo ""

# si ya existe un archivo con el mismo nombre en el directorio

$nombre_file="lgs_dump.dmp"

if [ -n "$nombre_file" ]
then
   echo 'existe, se mantniene la versión'
else
   echo 'No existe la versión voy a leerla de la plantilla en la base de datos vía expdp'
expdp system/Ch1r1m0y0_Pl4y3r0 schemas=registro_lgs directory=copias dumpfile=lgs_dumpv1.dmp logfile=lgsexpv1.log
fi


echo ""
echo ""
echo "Importando el esquema patrón registro_lgs en el nuevo esquema $nuevo_usuario"

echo ""

impdp system/Ch1r1m0y0_Pl4y3r0 schemas=registro_lgs directory=copias dumpfile=lgs_dumpv1.dmp logfile=lgsimpv1.log  remap_schema=registro_lgs:$nuevo_usuario

echo ""
echo ""
echo "preceso finalizado"
