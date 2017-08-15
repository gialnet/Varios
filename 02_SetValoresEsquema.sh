#!/bin/sh

# Ajustar un esquema de usuario

# Antonio Pérez

# 19 ENERO 2012 ver 1.0

# invocar con ./02_SetValoresEsquema.sh colegio_medico_jaen 

# dependencias:

# /home/oracle/scripts/newuser/nuevo_usuario.sql
# /home/oracle/scripts/newuser/idioma_reindex.sql

clear

nuevo_usuario=$1

# Copiar las plantillas SQL

cp -f /home/oracle/scripts/newuser/plantillas/*.sql /home/oracle/scripts/newuser/



# Cambiar las ocurrencias de REGISTRO_LGS por el nuevo esquema

echo "Estableciendo nuevos calores a $nuevo_usuario"
echo ""

sed -i "s/REGISTRO_LGS/$nuevo_usuario/" /home/oracle/scripts/newuser/nuevo_usuario.sql

echo ""
echo "Crear el nuevo esquema y ajustar permisos de usuario"

sqlplus /nolog @/home/oracle/scripts/nuevo_usuario.sql


echo "Ajustar las preferencias linguisticas y reindexar"

sed -i "s/REGISTRO_LGS/$nuevo_usuario/" /home/oracle/scripts/newuser/idioma_reindex.sql

sed -i "s/IDLGS/$nuevo_usuario/" /home/oracle/scripts/newuser/idioma_reindex.sql

sed -i "s/LOGOLGS/$nuevo_usuario/" /home/oracle/scripts/newuser/idioma_reindex.sql

sqlplus /nolog @/home/oracle/scripts/newuser/idioma_reindex.sql


echo ""
echo ""
echo "preceso finalizado"
