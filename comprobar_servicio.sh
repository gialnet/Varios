#!/bin/sh

# se le pasa como argumento el pid y nos dice si esta activo o no
# se ha aprendido del ataque, esto no se encuentra muy documentado en la red

pid=$1

if $(kill -CHLD $pid >/dev/null 2>&1)
then
echo 'El servicio existe'
else
echo 'No Existe el servicio'
fi

