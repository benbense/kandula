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

DROP TABLE IF EXISTS kandula.instances_shutdown_log CASCADE;

CREATE TABLE IF NOT EXISTS kandula.instances_shutdown_log
(
    job_id integer NOT NULL,
    "time" timestamp with time zone NOT NULL,
    action integer NOT NULL,
    CONSTRAINT instances_shutdown_log_pkey PRIMARY KEY (job_id),
    CONSTRAINT job_id FOREIGN KEY (job_id)
        REFERENCES kandula.instances_shutdown (job_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS kandula.instances_shutdown_log
    OWNER to postgres;