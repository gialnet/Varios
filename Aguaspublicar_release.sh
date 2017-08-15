#!/bin/sh

#
# Antonio Pérez Caballero 
# 22 Diciembre 2011
# 10 marzo 2012 copiar las imagenes desde imgReleaseV2
#
#
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

sudo rm -r /var/www/html/*

# Crear la carpeta de la mancomunidad
sudo mkdir /var/www/html/mm
sudo mkdir /var/www/html/rMail

# copiar el archivo de reglas de Apache al directorio raiz

sudo cp /var/www/.htaccess /var/www/html

# Copiar la nueva versión en el home del servidor Apache

echo "Publicar el contenido de la carpeta $carpeta"

sudo cp -R $carpeta/* /var/www/html/


sudo cp -R $carpeta/* /var/www/html/mm/


# Ajustar el usuario de la conexión a la Mancomunidad
sudo sed -i 's/REGISTRO_AS/REGISTRO_MM/' /var/www/html/mm/php/config/pebi_cn.inc.php

# copiar las imagenes

sudo cp /home/ec2-user/imgRegistroV2/* /var/www/html/img/

sudo cp /home/ec2-user/imgRegistroV2/* /var/www/html/mm/img/
