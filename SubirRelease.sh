#!/bin/sh


# copiar el comprimido en la nube
scp -i AguasMotril.pem $1 ec2-user@46.51.177.222:

echo "archivo copiado"

#ejecuta el script
ssh -t -i AguasMotril.pem ec2-user@46.51.177.222 "/home/ec2-user/subir_release.sh $1"

echo "proceso finalizado"

exit
