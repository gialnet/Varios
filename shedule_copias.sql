
--
-- Planificar copias de seguridad vía RMAN
--
-- BYHOUR
-- BYMINUTE
--
-- Esquema SERVICIOS_REDMOON
--

BEGIN
   DBMS_SCHEDULER.create_schedule(  
         schedule_name   => 'RMAN_DATABASE_BACKUP'
        ,start_date      => SYSDATE
        ,repeat_interval => 'FREQ=DAILY; BYDAY=MON,TUE,WED,THU,FRI; BYHOUR=6,15'
        ,comments        => 'trabajos de copia RMAN copia_full.sh');

   COMMIT;
END;
/


BEGIN
  DBMS_SCHEDULER.create_job(
     job_name        => 'RMAN_COPIA_COMPLETA'
    ,schedule_name   => 'RMAN_DATABASE_BACKUP'
    ,job_type        => 'EXECUTABLE'
    ,job_action      => '/home/oracle/rman/copia_full.sh'
    ,enabled         => FALSE
    ,comments        => 'trabajos de copia RMAN copia_full.sh');
  COMMIT;
END;
/

