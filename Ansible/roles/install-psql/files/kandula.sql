-- SCHEMA: kandula

DROP SCHEMA IF EXISTS kandula CASCADE;

CREATE SCHEMA IF NOT EXISTS kandula
    AUTHORIZATION postgres;

-- Table: kandula.instances_shutdown

DROP TABLE IF EXISTS kandula.instances_shutdown CASCADE;

CREATE TABLE IF NOT EXISTS kandula.instances_shutdown
(
    job_id SERIAL NOT NULL PRIMARY KEY,
    instance_id character varying(20) COLLATE pg_catalog."default" NOT NULL,
    shutdown_time integer NOT NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS kandula.instances_shutdown
    OWNER to postgres;


-- Table: kandula.instances_shutdown_log

DROP TABLE IF EXISTS kandula.instances_shutdown_log;

CREATE TABLE IF NOT EXISTS kandula.instances_shutdown_log
(
    log_id SERIAL NOT NULL PRIMARY KEY,
    job_id integer NOT NULL,
    "time" timestamp NOT NULL,
    action character varying(20) COLLATE pg_catalog."default" NOT NULL
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS kandula.instances_shutdown_log
    OWNER to postgres;

-- FUNCTION: kandula.log_instances_shutdown_actions_changes()

DROP FUNCTION IF EXISTS kandula.log_instances_shutdown_actions_changes();

CREATE OR REPLACE FUNCTION kandula.log_instances_shutdown_actions_changes()
    RETURNS trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
BEGIN
	INSERT INTO kandula.instances_shutdown_log (job_id, time, action) VALUES (COALESCE(OLD.job_id, NEW.job_id), CURRENT_TIMESTAMP, TG_OP);
	
	RETURN NEW;
END;
$BODY$;

ALTER FUNCTION kandula.log_instances_shutdown_actions_changes()
    OWNER TO postgres;


-- Trigger: instances_shutdown_actions_changes

DROP TRIGGER IF EXISTS instances_shutdown_actions_changes ON kandula.instances_shutdown;

CREATE TRIGGER instances_shutdown_actions_changes
    AFTER INSERT OR DELETE OR UPDATE 
    ON kandula.instances_shutdown
    FOR EACH ROW
    EXECUTE FUNCTION kandula.log_instances_shutdown_actions_changes();