
--
-- Planificar avisos a los usuarios
--
-- Antonio Pérez Caballero
-- Enero 2012
--
--



-- Comprobar la ejecución de los trabajos
select * from all_scheduler_job_run_details;

-- Ver las credenciales
SELECT owner, credential_name, username FROM dba_scheduler_credentials;


-- TRABAJOS PLANIFICADOS PARA UN USUARIO
SELECT * FROM user_scheduler_jobs;

-- PLANIFICADORES DEFINIDOS POR EL USUARIO
select * from USER_SCHEDULER_SCHEDULES



-- EXEC DBMS_SCHEDULER.DROP_JOB('SEND_MAIL_REMEMBER_pkAvisos')
-- EXEC DBMS_SCHEDULER.DROP_SCHEDULE('SEND_MAIL_REMEMBER');




BEGIN
   DBMS_SCHEDULER.create_schedule(  
         schedule_name   => 'SEND_MAIL_REMEMBER'
        ,start_date      =>  '01/01/2012 00:00:01'
        ,repeat_interval => 'FREQ=DAILY; BYDAY=MON,TUE,WED,THU,FRI; BYHOUR=5'
        ,comments        => 'Enviar resumen de tareas del día');

   COMMIT;
END;
/


BEGIN
  DBMS_SCHEDULER.create_job(
     job_name        => 'SEND_MAIL_REMEMBER_pkAvisos'
    ,schedule_name   => 'SEND_MAIL_REMEMBER'
    ,job_type        => 'STORED_PROCEDURE'
    ,job_action      => 'pkAvisos.DAILY_MAIL'
    ,enabled         => TRUE
    ,comments        => 'Enviar resumen de tareas del día pkAvisos.DAILY_MAIL');
  COMMIT;
END;
/



--
-- Avisos mediante SMS
--
--
--


-- EXEC DBMS_SCHEDULER.DROP_JOB('SEND_SMS_ALERTAS_pkAvisos')
-- EXEC DBMS_SCHEDULER.DROP_SCHEDULE('SEND_MAIL_REMEMBER');

BEGIN
   DBMS_SCHEDULER.create_schedule(  
         schedule_name   => 'SEND_SMS_ALERTAS'
        ,start_date      =>  '01/01/2012 00:00:01'
        ,repeat_interval => 'FREQ=MINUTELY; BYMINUTE=0,4,9,14,19,24,29,34,39,44,49,54,58'
        ,comments        => 'Enviar avisos recordatorios vía SMS');

   COMMIT;
END;
/


BEGIN
  DBMS_SCHEDULER.create_program (
     program_name        => 'SEND_SMS_ALERTAS_pkAvisos'
    ,program_type        => 'STORED_PROCEDURE'
    ,program_action      => 'pkAvisos.SEND_AVISOS_SMS'
    ,number_of_arguments => 1
    ,enabled             => FALSE
    ,comments            => 'Alertas al móvil vía SMS cada 5 minutos');

  DBMS_SCHEDULER.define_program_argument (
     program_name      => 'SEND_SMS_ALERTAS_pkAvisos'
    ,argument_position => 1
    ,argument_name     => 'xIntervalo_Minutos'
    ,argument_type     => 'number'
    ,default_value     => 5);

  DBMS_SCHEDULER.enable (
     name => 'SEND_SMS_ALERTAS_pkAvisos');

  COMMIT;
END;
/

-- exec dbms_scheduler.run_job('JOB_SEND_SMS_ALERTAS_pkAvisos');

BEGIN
  DBMS_SCHEDULER.create_job(
     job_name        => 'JOB_SEND_SMS_ALERTAS_pkAvisos'
    ,program_name    => 'SEND_SMS_ALERTAS_pkAvisos'
    ,schedule_name   => 'SEND_SMS_ALERTAS'
    ,enabled         => TRUE
    ,comments        => 'Alertas al móvil vía SMS cada 5 minutos');

  COMMIT;
END;
/

