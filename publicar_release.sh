#!/bin/sh

#
# Antonio Pérez Caballero 
# 22 Diciembre 2011
# descomprimir una release y copiar los archivos en las carpetas detino para Aguas y Mancomunidad
#
# ejemplo de uso: ./subir_release.sh release_11_12_22.zip
#

clear

nombre_file=$1

if [ -n "$nombre_file" ]
then
   echo 'existe, voy a borrar la versión anterior'
   carpeta="${nombre_file%.[^.]*}"
   sudo rm -r $carpeta
else
   echo 'Not found directory'
fi

# descomprimir archivo
echo "descomprimir $nombre_file"
sudo unzip -q $nombre_file

# eliminar la versión anterior del servidor WEB
# se eliminan todos los archivos y carpetas

sudo rm -r /var/www/coiiaor/*

# Copiar la nueva versión en el home del servidor Apache

echo "Publicar el contenido de la carpeta $carpeta"

sudo cp -R $carpeta/* /var/www/coiiaor/

