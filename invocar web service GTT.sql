DECLARE
 
    req   UTL_HTTP.req := NULL;
    resp  UTL_HTTP.resp := NULL;
    respVal VARCHAR2(32000);
    reqXML VARCHAR2(32760);
 
BEGIN
 
/*Generamos un Request a la URL destino, el método debe ser POST */
    req := UTL_HTTP.begin_request('http://46.137.177.203:8080/SaludoWS/services/SaludoImplPort', 'POST');
 
/*Creamos un mensaje SOAP tal cual se define en el WSDL*/
 
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
    UTL_HTTP.set_header(req, 'SOAPAction', '"rpc/http://46.137.177.203:8080/SaludoWS/services/SaludoImplPort"');
 
/*Indicamos en el header el tamańo del mensaje enviado: */
    UTL_HTTP.set_header(req, 'Content-Length', LENGTH(reqXML));
 
/*Escribimos el body del request */
    UTL_HTTP.write_text(req, reqXML);
 
/*Obtenemos la respuesta */
    resp := UTL_HTTP.get_response(req);
 
/*Cargamos en la variable respVal la devolución del servidor */
    UTL_HTTP.read_text(resp, respVal);

    -- imprimimos la respuesta 

    DBMS_OUTPUT.Put_Line(respVal);


/*Finalizamos la conexión HTTP */
    UTL_HTTP.end_response(resp);
 
EXCEPTION
    WHEN UTL_HTTP.end_of_body THEN
      UTL_HTTP.end_response(resp);
END;
/


/*

<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ns2:saludoAutenticadoResponse xmlns:ns2="http://impl.ejemplogtt.ws.redmoon.es/"><return>Hola compañeros de GTT</return></ns2:saludoAutenticadoResponse></soap:Body></soap:Envelope>
*/

/*

<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"><soap:Body><ns2:saludoAutenticadoResponse xmlns:ns2="http://impl.ejemplogtt.ws.redmoon.es/"><return>Los datos del usuario son incorrectos.</return></ns2:saludoAutenticadoResponse></soap:Body></soap:Envelope>
*/
