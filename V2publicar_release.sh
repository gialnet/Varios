#!/bin/sh

#
# Antonio Pérez Caballero 
# 22 Diciembre 2011
# 22 enero publicar release version 2
# 10 marzo copiar las imagenes desde una carpeta imgRegistroV2
#
#
# descomprimir una release y copiar los archivos en las carpetas detino para Aguas y Mancomunidad
#
# ejemplo de uso: ./V2publicar_release.sh release_11_12_22.zip
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

sudo rm -r /var/www/html/rMail/*


# Copiar la nueva versión en el home del servidor Apache

echo "Publicar el contenido de la carpeta $carpeta"

sudo cp -R $carpeta/* /var/www/html/rMail

sudo cp /home/ec2-user/imgRegistroV2/* /var/www/html/rMail/img/
