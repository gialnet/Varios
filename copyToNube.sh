#! /bin/sh


# Versión alfa
# copyToNube 
# uso:
# 	copyToNube.sh
# copia desde la carpeta donde se encuentra el fichero y lo pasa a la nube
# https://aguasyservicios.s3-website-eu-west-1.amazonaws.com/copias/fast_recovery/aysct
# hay que añadirle la carpeta a la que va esta copia
# carpeta de los juegos de copias de seguridad "backupset"
# /u03/flash_recovery_area/aysct/AYSCT/backupset/*.bkp
# /u03/flash_recovery_area/manco/MANCO/backupset/*.bkp

clear

#var1=$(pwd)

#echo "$var1"

# moverte a la carpeta de juegos de copias en Aguas de Motril
# cd /u03/flash_recovery_area/aysct/AYSCT/backupset/
# para pruebas


# lista de archivos en la carpeta
#litsDocs=$(ls *)

#echo "$litsDocs"

# copiar un archivo en la nube

cpFile ()
{
php copyToNube.php $1 $2
}

carpeta=$(basename `pwd`)


# creaar una lista con todos los archivos de la carpeta actual

for archivo in `ls *`
do
        if [ -f $archivo ]
        then
		cpFile $archivo $carpeta
		#echo "$archivo"
        fi
done


#echo Archivo a copiar en la nube:
#read$ARCHIVO


# bucle lista de archivos de la carpeta





#
#
#if [ $# -lt 1 ]
#then
# echo 'debe indicar el nombre del fichero a copiar'
# exit
#fi


#if [ -f $1 ]
#then
#	echo 'existe'
#	php copyToNube.php $1
#else
#	echo 'falta el fichero'
#fi 
