--
-- Crear las preferencias linguisticas de un nuevo esquema, crear los tipos definidos por el usuario,
-- establecer el nombre del esquema y el logo en la tabla de configuración.
--
-- 19 ENERO 2012 ver 1.0
--
-- Antonio Pérez
--
-- en este caso ingles y español
--
-- Crear los tipos definidos por el usuario que la exportación no puede copiar
--

connect REGISTRO_LGS/R3dm00n3632@aysct;

--
-- Crear un Objeto Oracle
-- Maria del Mar
-- Lista de contactos entre todos los trabajadores y la agenda propia
-- UTILIZADO

CREATE TYPE row_contactos AS OBJECT (
  mail             	VARCHAR2(100),
  nombre        	VARCHAR2(256),
  tipo				CHAR(2)
);
/

--
-- Funci?n de busqueda de notificaciones
--
CREATE TYPE row_notificaciones AS OBJECT (
	rango			Integer,
	id				Integer,
	id_libro		Integer,
	fecha			varchar2(20),
	tipo			char(1),
	de				varchar2(60),
	asunto			varchar2(100),
	servicio		varchar2(50),
	enlace			char(1),
	url_lectura		varchar2(250),
	esquema			varchar2(20)
);
/

--
--  Bandeja de entrada
--

CREATE TYPE row_bandejaEntrada AS OBJECT (
	rango			Integer,
	id				Integer,
	id_libro		Integer,
	fecha			varchar2(20),
	tipo			char(1),
	de				varchar2(60),
	asunto			varchar2(100),
	servicio		varchar2(50),
	enlace			char(1),
	url_lectura		varchar2(250),
	esquema			varchar2(20),
	url_externa		varchar2(250)
);
/

-- ***********************
-- Usuarios de la agenda y mancomunidad
-- ***********************
CREATE TYPE row_agenda AS OBJECT (
  nombre 		varchar2(60),
  mail_dire 	varchar2(100),
  ncliente		varchar2(20),
  municipio		varchar2(60),
  delega		varchar2(50),
  nif			char(10),
  id_usuario	Integer
  
);
/

--
-- Contactos de la agenda(externos) y mancomunidad
-- 
CREATE TYPE row_contactosCrearRegistro AS OBJECT (
	id				INTEGER,
  	tipo           	VARCHAR2(10),
  	nombre        	VARCHAR2(100)
);
/

CREATE OR REPLACE TYPE row_registros AS OBJECT (
  rango             Integer,
  id				Integer, 
  tipo        		CHAR(1),
  nregistro			char(12),
  nregistro_g		char(12),
  fecha				date,
  extracto			varchar2(512),
  nombre 			varchar2(60),
  persona			varchar2(60),
  servicio 			varchar2(50)
  
);
/

--
-- Crear un tipo de dato
-- Maria del Mar
--
CREATE TYPE table_contactosCrearRegistro AS TABLE OF row_contactosCrearRegistro;
/

CREATE TYPE table_contactos AS TABLE OF row_contactos;
/

CREATE TYPE table_agenda AS TABLE OF row_agenda;
/

CREATE TYPE table_notificaciones AS TABLE OF row_notificaciones;
/

CREATE OR REPLACE TYPE table_registros AS TABLE OF row_registros;
/

CREATE TYPE table_bandejaEntrada AS TABLE OF row_bandejaEntrada;
/




begin
  ctx_ddl.create_preference('e_lexer','basic_lexer');
  ctx_ddl.set_attribute('e_lexer','base_letter','yes');
  ctx_ddl.create_preference('m_lexer','multi_lexer');
  ctx_ddl.add_sub_lexer('m_lexer','default','e_lexer');
  ctx_ddl.add_sub_lexer('m_lexer','spanish','e_lexer');
end;
/


begin
	ctx_ddl.create_preference('Registro_busqueda','MULTI_COLUMN_DATASTORE');
	CTX_DDL.SET_ATTRIBUTE ('Registro_busqueda', 'COLUMNS', 
				'EXTRACTO,NIF,NOMBRE,NCLIENTE,UBICACION,OBSERVACIONES,RESOLUCION,ZONA_GESTION,MUNICIPIO,MAIL_DIRE');
end;
/

begin
	ctx_ddl.create_preference('DIRECT_REGISTRO','DIRECT_DATASTORE');
end;
/

begin
	ctx_ddl.create_preference('Notificaciones_busqueda','MULTI_COLUMN_DATASTORE');
	CTX_DDL.SET_ATTRIBUTE ('Notificaciones_busqueda', 'COLUMNS', 'DESTINATARIO,EMISOR,ASUNTO,MENSAJE');
end;
/


alter index MULTI_COLUMNS_URL rebuild;
/


alter index BFILE_Registro_URL rebuild;
/


alter index MULTI_NOTIFICACIONES rebuild;
/


-- Ajustar los logos

update configuracion set DESCRIPCION='IDLGS', LOGO='LOGOLGS';
/

commit work;

quit;
