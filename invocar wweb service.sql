DECLARE
 
    req   UTL_HTTP.req := NULL;
    resp  UTL_HTTP.resp := NULL;
    respVal VARCHAR2(32000);
    reqXML VARCHAR2(32760);
 
BEGIN
 
/*Generamos un Request a la URL destino, el método debe ser POST */
    req := UTL_HTTP.begin_request('http://servidor/ConsultaClientes', 'POST');
 
/*Creamos un mensaje SOAP tal cual se define en el WSDL*/
 
/*
reqXML := '<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:m0="ConsultaClientes">
      <SOAP-ENV:Body>
            <m:ConsultaClientes xmlns:m="http://servidor/ConsultaClientes">
                  <m0:mensaje>
                        <m0:idcliente>C123452</m0:idcliente>
                  </m0:mensaje>
            </m:ConsultaClientes>
      </SOAP-ENV:Body>
</SOAP-ENV:Envelope>';
 
*/


reqXML := '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:impl="http://impl.ejemplogtt.ws.redmoon.es/">
   <soapenv:Header/>
   <soapenv:Body>
      <impl:saludoAutenticado>
         <!--Optional:-->
         <arg0>gtt</arg0>
         <!--Optional:-->
         <arg1>alicante</arg1>
         <!--Optional:-->
         <arg2>Hola compañeros de GTT</arg2>
      </impl:saludoAutenticado>
   </soapenv:Body>
</soapenv:Envelope>';



/*El contenido que enviamos es XML: */
    UTL_HTTP.set_header(req, 'Content-Type', 'text/xml');
 
/*Establecemos el SOAPAction a invocar: */
    UTL_HTTP.set_header(req, 'SOAPAction', '"rpc/http://servidor/ConsultaClientes"');
 
/*Indicamos en el header el tamańo del mensaje enviado: */
    UTL_HTTP.set_header(req, 'Content-Length', LENGTH(xml));
 
/*Escribimos el body del request */
    UTL_HTTP.write_text(req, xml);
 
/*Obtenemos la respuesta */
    resp := UTL_HTTP.get_response(req);
 
/*Cargamos en la variable respVal la devolución del servidor */
    UTL_HTTP.read_text(resp, respVal);
 
/*Finalizamos la conexión HTTP */
    UTL_HTTP.end_response(resp);
 
EXCEPTION
    WHEN UTL_HTTP.end_of_body THEN
      UTL_HTTP.end_response(resp);
END;
/
