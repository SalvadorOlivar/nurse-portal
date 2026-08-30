--
-- PostgreSQL database dump
--

\restrict kdMmnjrlXEK77upqQFvHkpN50xOGJXRm8a6hYx7uThjC5VHfrY5O2Tg0YZnMLHn

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.turnos DROP CONSTRAINT IF EXISTS turnos_planificacion_id_fkey;
ALTER TABLE IF EXISTS ONLY public.turnos DROP CONSTRAINT IF EXISTS turnos_empleado_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_requests DROP CONSTRAINT IF EXISTS shift_swap_requests_turno_solicitante_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_requests DROP CONSTRAINT IF EXISTS shift_swap_requests_turno_destino_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_requests DROP CONSTRAINT IF EXISTS shift_swap_requests_solicitante_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_requests DROP CONSTRAINT IF EXISTS shift_swap_requests_planificacion_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_requests DROP CONSTRAINT IF EXISTS shift_swap_requests_destino_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_requests DROP CONSTRAINT IF EXISTS shift_swap_requests_aprobado_por_fkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_history DROP CONSTRAINT IF EXISTS shift_swap_history_swap_request_id_fkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_history DROP CONSTRAINT IF EXISTS shift_swap_history_actor_id_fkey;
ALTER TABLE IF EXISTS ONLY public.planificacion_sectores DROP CONSTRAINT IF EXISTS planificacion_sectores_planificacion_id_fkey;
ALTER TABLE IF EXISTS ONLY public.planificacion_dotacion DROP CONSTRAINT IF EXISTS planificacion_dotacion_planificacion_id_fkey;
ALTER TABLE IF EXISTS ONLY public.leave_requests DROP CONSTRAINT IF EXISTS leave_requests_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.leave_requests DROP CONSTRAINT IF EXISTS leave_requests_aprobado_por_fkey;
ALTER TABLE IF EXISTS ONLY public.compensatory_days DROP CONSTRAINT IF EXISTS compensatory_days_turno_id_fkey;
ALTER TABLE IF EXISTS ONLY public.compensatory_days DROP CONSTRAINT IF EXISTS compensatory_days_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.auth_users DROP CONSTRAINT IF EXISTS auth_users_employee_id_fkey;
ALTER TABLE IF EXISTS ONLY public.auth_sessions DROP CONSTRAINT IF EXISTS auth_sessions_user_id_fkey;
DROP INDEX IF EXISTS public.idx_turnos_planificacion;
DROP INDEX IF EXISTS public.idx_turnos_empleado;
DROP INDEX IF EXISTS public.idx_swap_requests_solicitante;
DROP INDEX IF EXISTS public.idx_swap_requests_estado;
DROP INDEX IF EXISTS public.idx_swap_requests_destino;
DROP INDEX IF EXISTS public.idx_swap_history_request;
DROP INDEX IF EXISTS public.idx_leave_requests_fechas;
DROP INDEX IF EXISTS public.idx_leave_requests_estado;
DROP INDEX IF EXISTS public.idx_leave_requests_employee_id;
DROP INDEX IF EXISTS public.idx_compensatory_days_employee_id;
DROP INDEX IF EXISTS public.idx_auth_sessions_user_id;
DROP INDEX IF EXISTS public.idx_auth_sessions_expires_at;
ALTER TABLE IF EXISTS ONLY public.turnos DROP CONSTRAINT IF EXISTS turnos_planificacion_id_empleado_id_dia_semana_turno_key;
ALTER TABLE IF EXISTS ONLY public.turnos DROP CONSTRAINT IF EXISTS turnos_pkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_requests DROP CONSTRAINT IF EXISTS shift_swap_requests_pkey;
ALTER TABLE IF EXISTS ONLY public.shift_swap_history DROP CONSTRAINT IF EXISTS shift_swap_history_pkey;
ALTER TABLE IF EXISTS ONLY public.planificaciones DROP CONSTRAINT IF EXISTS planificaciones_semana_anio_key;
ALTER TABLE IF EXISTS ONLY public.planificaciones DROP CONSTRAINT IF EXISTS planificaciones_pkey;
ALTER TABLE IF EXISTS ONLY public.planificacion_sectores DROP CONSTRAINT IF EXISTS planificacion_sectores_planificacion_id_nombre_key;
ALTER TABLE IF EXISTS ONLY public.planificacion_sectores DROP CONSTRAINT IF EXISTS planificacion_sectores_pkey;
ALTER TABLE IF EXISTS ONLY public.planificacion_dotacion DROP CONSTRAINT IF EXISTS planificacion_dotacion_planificacion_id_sector_tipo_emplead_key;
ALTER TABLE IF EXISTS ONLY public.planificacion_dotacion DROP CONSTRAINT IF EXISTS planificacion_dotacion_pkey;
ALTER TABLE IF EXISTS ONLY public.leave_requests DROP CONSTRAINT IF EXISTS leave_requests_pkey;
ALTER TABLE IF EXISTS ONLY public.goose_db_version DROP CONSTRAINT IF EXISTS goose_db_version_pkey;
ALTER TABLE IF EXISTS ONLY public.employees DROP CONSTRAINT IF EXISTS employees_pkey;
ALTER TABLE IF EXISTS ONLY public.compensatory_days DROP CONSTRAINT IF EXISTS compensatory_days_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_users DROP CONSTRAINT IF EXISTS auth_users_username_key;
ALTER TABLE IF EXISTS ONLY public.auth_users DROP CONSTRAINT IF EXISTS auth_users_pkey;
ALTER TABLE IF EXISTS ONLY public.auth_users DROP CONSTRAINT IF EXISTS auth_users_employee_id_key;
ALTER TABLE IF EXISTS ONLY public.auth_sessions DROP CONSTRAINT IF EXISTS auth_sessions_token_hash_key;
ALTER TABLE IF EXISTS ONLY public.auth_sessions DROP CONSTRAINT IF EXISTS auth_sessions_pkey;
DROP TABLE IF EXISTS public.turnos;
DROP TABLE IF EXISTS public.shift_swap_requests;
DROP TABLE IF EXISTS public.shift_swap_history;
DROP TABLE IF EXISTS public.planificaciones;
DROP TABLE IF EXISTS public.planificacion_sectores;
DROP TABLE IF EXISTS public.planificacion_dotacion;
DROP TABLE IF EXISTS public.leave_requests;
DROP TABLE IF EXISTS public.goose_db_version;
DROP TABLE IF EXISTS public.employees;
DROP TABLE IF EXISTS public.compensatory_days;
DROP TABLE IF EXISTS public.auth_users;
DROP TABLE IF EXISTS public.auth_sessions;
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_sessions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    token_hash text NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: auth_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_users (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    username character varying(150) NOT NULL,
    password_hash text,
    role character varying(20) NOT NULL,
    employee_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    must_change_password boolean DEFAULT false NOT NULL,
    CONSTRAINT auth_users_role_check CHECK (((role)::text = ANY ((ARRAY['ADMIN'::character varying, 'SUPERVISOR'::character varying, 'EMPLOYEE'::character varying])::text[])))
);


--
-- Name: compensatory_days; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.compensatory_days (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    employee_id uuid NOT NULL,
    fecha_origen date NOT NULL,
    motivo character varying(30) NOT NULL,
    turno_id uuid,
    descripcion text DEFAULT ''::text NOT NULL,
    utilizado boolean DEFAULT false NOT NULL,
    fecha_uso date,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT compensatory_days_motivo_check CHECK (((motivo)::text = ANY ((ARRAY['DOBLE_TURNO'::character varying, 'DESCANSO_LABORADO'::character varying])::text[])))
);


--
-- Name: employees; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.employees (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    nombre character varying(100) NOT NULL,
    apellido character varying(100) NOT NULL,
    tipo character varying(20) NOT NULL,
    horas_minimas integer NOT NULL,
    horas_maximas integer NOT NULL,
    work_days integer DEFAULT 4 NOT NULL,
    rest_days integer DEFAULT 1 NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT employees_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['NURSE'::character varying, 'NURSE_ASSISTANT'::character varying, 'SUPERVISOR'::character varying, 'AUXILIAR_SERVICIO'::character varying])::text[])))
);


--
-- Name: goose_db_version; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.goose_db_version (
    id integer NOT NULL,
    version_id bigint NOT NULL,
    is_applied boolean NOT NULL,
    tstamp timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.goose_db_version ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.goose_db_version_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: leave_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leave_requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    employee_id uuid NOT NULL,
    fecha_inicio date NOT NULL,
    fecha_fin date NOT NULL,
    tipo character varying(20) NOT NULL,
    estado character varying(20) DEFAULT 'PENDIENTE'::character varying NOT NULL,
    motivo text DEFAULT ''::text NOT NULL,
    aprobado_por uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT leave_requests_estado_check CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE'::character varying, 'APROBADO'::character varying, 'RECHAZADO'::character varying])::text[]))),
    CONSTRAINT leave_requests_tipo_check CHECK (((tipo)::text = ANY ((ARRAY['VACACIONES'::character varying, 'ENFERMEDAD'::character varying, 'PERSONAL'::character varying, 'DIA_FAVOR'::character varying])::text[])))
);


--
-- Name: planificacion_dotacion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.planificacion_dotacion (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    planificacion_id uuid NOT NULL,
    sector character varying(50) DEFAULT ''::character varying NOT NULL,
    tipo_empleado character varying(20) NOT NULL,
    turno character varying(20) NOT NULL,
    cantidad_minima integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: planificacion_sectores; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.planificacion_sectores (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    planificacion_id uuid NOT NULL,
    nombre character varying(50) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: planificaciones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.planificaciones (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    semana integer NOT NULL,
    anio integer NOT NULL,
    nombre character varying(200) NOT NULL,
    estado character varying(20) DEFAULT 'BORRADOR'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT planificaciones_estado_check CHECK (((estado)::text = ANY ((ARRAY['BORRADOR'::character varying, 'PUBLICADO'::character varying, 'CERRADO'::character varying])::text[]))),
    CONSTRAINT planificaciones_semana_check CHECK (((semana >= 1) AND (semana <= 53)))
);


--
-- Name: shift_swap_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shift_swap_history (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    swap_request_id uuid NOT NULL,
    accion character varying(30) NOT NULL,
    actor_id uuid NOT NULL,
    detalle text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: shift_swap_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shift_swap_requests (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    planificacion_id uuid NOT NULL,
    turno_solicitante_id uuid NOT NULL,
    turno_destino_id uuid NOT NULL,
    solicitante_id uuid NOT NULL,
    destino_id uuid NOT NULL,
    estado character varying(30) DEFAULT 'PENDIENTE_RESPUESTA'::character varying NOT NULL,
    aprobado_por uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT shift_swap_requests_estado_check CHECK (((estado)::text = ANY ((ARRAY['PENDIENTE_RESPUESTA'::character varying, 'PENDIENTE_APROBACION'::character varying, 'APROBADO'::character varying, 'RECHAZADO'::character varying, 'CANCELADO'::character varying])::text[])))
);


--
-- Name: turnos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.turnos (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    planificacion_id uuid NOT NULL,
    empleado_id uuid NOT NULL,
    dia_semana integer NOT NULL,
    turno character varying(20) DEFAULT 'MANANA'::character varying NOT NULL,
    sector character varying(255) DEFAULT ''::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT turnos_dia_semana_check CHECK (((dia_semana >= 1) AND (dia_semana <= 7))),
    CONSTRAINT turnos_turno_check CHECK (((turno)::text = ANY ((ARRAY['MANANA'::character varying, 'TARDE'::character varying, 'VESPERTINO'::character varying, 'NOCHE'::character varying])::text[])))
);


--
-- Data for Name: auth_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_sessions (id, user_id, token_hash, expires_at, created_at) FROM stdin;
13c7f9e6-8560-4303-b0a9-f016803ca032	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	b926fceb69780d66c83d6f548e5221b24ac290712a1bfde3ef1be2f4cf8eb837	2026-06-28 04:38:05.096706+00	2026-06-21 04:38:05.894087+00
eecadded-a154-47ae-96f2-c9bf95e60f10	9ce9bc05-eb98-4233-b155-4414263e4880	13d52466731d9de7d81363b3e43ac51c84febaf2f444a6232fb0c66fe7c89cf8	2026-06-30 22:22:28.96444+00	2026-06-23 22:22:29.238832+00
3c385d66-f6f3-4105-a16f-dfd19e434f57	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	421b607b8b4caa767e56cbd22cfccddd6f4a776b299854e96de74ed4db5b627b	2026-07-01 23:16:18.720961+00	2026-06-24 23:16:18.983876+00
eb48942b-35e8-459a-80fc-cffb870051ca	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	d0de88e2bfb5f820735db87180c21bf35a12351cfca8e03f8bb70f5cd678c6bb	2026-07-02 01:02:12.301863+00	2026-06-25 01:02:12.688674+00
4a52ff0c-a2aa-4aae-84b6-4ed5fbd8c31e	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	ee885455985d9302396a65302ce2670638a2b944245fd58ebd38644e0bd4f723	2026-07-04 22:48:01.790437+00	2026-06-27 22:48:02.02697+00
cc9db9cf-693c-4625-bf8f-6994631a978b	ac2b5c81-2dda-42da-9838-1b49ca4d7f60	a12367f9171c3a5a3ad586039022a0f50b7c84d3fdec0444cb9632d0ef98d052	2026-07-05 02:51:47.387919+00	2026-06-28 02:51:47.460919+00
2bc71bab-cbff-41d8-8efd-437f8b03da02	73042875-3233-4858-8376-e9de491cd249	314a94bc976bcc9fc88211a5d5a4753d1639c2aa7f96b3e0a0972a5cb81d2113	2026-07-05 02:56:44.124494+00	2026-06-28 02:56:44.197659+00
816e966f-1428-44cf-bab4-f95fb441ca07	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	e7dcf1799400fcbcdf6f1254fa73503fbed58f9923a36bf29f299856c30dc371	2026-07-05 03:56:06.674322+00	2026-06-28 03:56:06.973341+00
636439ab-97b6-44ee-a35c-0e811599e9ce	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	81842e117c74e30b7ab4aed2e823caf6115bf1ad503d28642e91a12841951115	2026-07-05 04:07:49.145696+00	2026-06-28 04:07:49.443688+00
9e1c1eff-2c7f-4781-a6d5-24a275b05a42	73042875-3233-4858-8376-e9de491cd249	04d36f4a948114f47b408a708e4c901c2e5ddceb460a14a597b8024a305ed40e	2026-07-05 17:39:11.687653+00	2026-06-28 17:39:11.996987+00
04207916-32dd-4647-a6a2-93fe13c3eecf	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	f39aa9c96702a34e9a3d0b321c2edc7565102e5815ee02debfc06b0805d6a16e	2026-07-05 17:41:10.676885+00	2026-06-28 17:41:10.985262+00
07b8eff7-7ce4-418c-b58d-867f8d6bc981	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	f04493a1eadaa9ca5a79bf618bc7b35e03e1138d0140465c0576dfe15229b9a9	2026-07-18 02:14:47.130993+00	2026-07-11 02:14:47.936483+00
737fe9c3-6b07-43ee-8e35-6cf20b22425e	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	c16aa8fd98136251793efc08702225a6c3307bbfff77a62a688affefa1634143	2026-08-01 02:56:49.174602+00	2026-07-25 02:56:49.449785+00
f25651fc-cb87-4d10-81a1-cc4fa1f1bafb	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	2b360e591106219917f463815a158593ff47807df4228f4e8717e630b73b2880	2026-08-04 00:43:16.453396+00	2026-07-28 00:43:16.697147+00
6d8a9883-b452-493e-a341-e82b81a5536c	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	d88f8f7978967342e2ef501e9cf0be756a0fb7dc63d1c59bfac9104de174f8b4	2026-08-13 15:02:41.110377+00	2026-08-06 15:02:41.544408+00
507e7361-2f8d-438c-b6e1-9e1b0de208f9	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	1bd315b2b881674ce5c5af8eaa5fa436672427866f54196453725956078f02d1	2026-08-13 15:03:57.327281+00	2026-08-06 15:03:57.585636+00
f028b8c6-f461-403a-bad5-dc6cc692a6c6	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	4b59cfeeb118f20b783976cc3d8daa5350f0fd5147d6fa06b6a8bf3aeb174f72	2026-08-13 15:05:20.373048+00	2026-08-06 15:05:20.812712+00
99b0f4ea-82f6-4128-b4de-02b419d612ef	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	ff659a501ef86199ba48ff8e46539982b0ad693c6f5beb4561e891fd8882a4bf	2026-08-13 15:05:56.547839+00	2026-08-06 15:05:56.807863+00
73ee410c-6c77-493f-87f5-3b16161922aa	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	b345d7c10e782c3d9a9a5ed4dac4aba3c71e976be6375977c36ff39bb8772cea	2026-08-13 15:09:29.730138+00	2026-08-06 15:09:30.315292+00
a038c306-4e4d-440e-afa1-209f01a51106	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	59d7666c3860d7f7007b45592b1816cfc862d38964960cb675adf3906a003195	2026-08-13 15:14:42.212966+00	2026-08-06 15:14:42.568146+00
\.


--
-- Data for Name: auth_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_users (id, username, password_hash, role, employee_id, created_at, updated_at, must_change_password) FROM stdin;
906043a8-3ea1-4f9a-9874-ffab5878df44	aldair.olivar	\N	SUPERVISOR	d31d5849-260a-4c22-ac22-ae372a52e768	2026-06-21 04:37:39.127284+00	2026-06-21 04:37:39.127284+00	f
5306fe31-6704-492d-bcdd-402912227f93	fide.olivar	\N	EMPLOYEE	3754962c-90b1-4039-893f-a9475cdd386b	2026-06-21 04:37:39.127284+00	2026-06-21 04:37:39.127284+00	f
524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	admin	$2a$10$Hdq.Rkg1kcvRUDoF5Q8n2udFIqROdhLIp7.lHE.rMeT/g5zMHVlea	ADMIN	\N	2026-06-21 04:37:56.634081+00	2026-06-21 04:37:56.634081+00	f
f48cd361-1bf0-49a9-8ea6-244d6b2433a3	salvador.olivar	$2a$10$QrViAwZZWqyzTqW7IcrGreK.RkPkyR9dmu.YDEQXUtWPnJ9QpTXUK	EMPLOYEE	b187fca6-d1f7-407d-ba22-d6397b6cc47c	2026-06-21 04:37:39.127284+00	2026-06-21 20:51:55.198177+00	f
ac2b5c81-2dda-42da-9838-1b49ca4d7f60	micaela.camilo	$2a$10$KegE5kX.NGjZeV0l9PLEoemuWa6HwWHlD1jYwFgUCifQULxQyTxTC	EMPLOYEE	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	2026-06-22 03:25:04.918807+00	2026-06-22 03:26:42.473978+00	f
a2379d37-5594-40de-9547-ba803e5f0774	eugenia.amaya	$2a$10$3lF80A2jbNU2J34hmMEZH.m8uX5dDWaKiBvTmMCziRluM1e//EoFe	SUPERVISOR	55010ec1-e611-46c8-ba12-7d598075fafb	2026-06-21 04:37:39.127284+00	2026-06-22 03:29:12.262486+00	f
9ce9bc05-eb98-4233-b155-4414263e4880	sandra.sarmiento	$2a$10$Ju74r0eDVuy/GTWcAnVhue/aos6PhBdNTsD4DiMEsEN5ppbgbV/jO	EMPLOYEE	973f24b1-d99e-4f54-856e-9b3d3cba5986	2026-06-21 04:37:39.127284+00	2026-06-23 22:22:28.829317+00	f
73042875-3233-4858-8376-e9de491cd249	javier.olivar	$2a$10$JKYeZf1vPCM5A8sGtd2SaOYIm7AYMqHQDdt8xjRN4vCkG6.cARG4a	EMPLOYEE	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	2026-06-21 04:37:39.127284+00	2026-06-28 02:34:37.424647+00	f
\.


--
-- Data for Name: compensatory_days; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.compensatory_days (id, employee_id, fecha_origen, motivo, turno_id, descripcion, utilizado, fecha_uso, created_at) FROM stdin;
27f8eb9b-8952-478e-bfdb-32ff99dcda02	55010ec1-e611-46c8-ba12-7d598075fafb	2026-07-01	DESCANSO_LABORADO	850a619c-8cf2-4efa-bf76-e106578bfde4	Trabajo en dia de descanso el 2026-07-01 - MANANA	f	\N	2026-06-21 04:56:52.073755+00
0e114316-e8e3-47e8-889b-55f2670fd376	d31d5849-260a-4c22-ac22-ae372a52e768	2026-06-29	DESCANSO_LABORADO	374a5729-72c9-47cd-bd17-ddf1dd4c7198	Trabajo en dia de descanso el 2026-06-29 - TARDE	f	\N	2026-06-22 03:20:20.700582+00
27356ea3-74a2-4dd1-93ba-6f3109c3092d	55010ec1-e611-46c8-ba12-7d598075fafb	2026-06-29	DOBLE_TURNO	5b6fd4f1-eb1e-4fa2-af97-3e2124891415	Turno doble el 2026-06-29 - NOCHE	f	\N	2026-06-22 03:20:29.745782+00
9b4845df-9767-468c-b426-332cbaa3a312	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	2026-06-29	DESCANSO_LABORADO	b573ef7b-4508-4a4b-8524-6c438274764a	Trabajo en dia de descanso el 2026-06-29 - MANANA	f	\N	2026-06-22 03:21:01.202538+00
e2d1e320-0019-40e6-9c46-65a9de7146a6	3754962c-90b1-4039-893f-a9475cdd386b	2026-06-29	DESCANSO_LABORADO	e61b511d-30f6-4e48-9401-127c7bdbba3f	Trabajo en dia de descanso el 2026-06-29 - MANANA	f	\N	2026-06-22 03:21:11.107847+00
17ab8800-a23a-4371-8e56-125e187cf0e1	973f24b1-d99e-4f54-856e-9b3d3cba5986	2026-06-29	DESCANSO_LABORADO	ea4f1011-551b-4e3e-b4ab-0afa37b92e00	Trabajo en dia de descanso el 2026-06-29 - MANANA	f	\N	2026-06-22 03:21:26.342832+00
de2de3c5-a673-4a8d-b7fa-0aa635b64d4e	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	2026-06-29	DOBLE_TURNO	97b71455-b7cf-47eb-a6cc-4086e55b01c1	Turno doble el 2026-06-29 - TARDE	f	\N	2026-06-22 03:21:52.884868+00
5f1e6f8d-bc75-4132-bd6e-22b88766a795	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	2026-06-29	DESCANSO_LABORADO	b1624dcb-5e16-4ff1-a9f3-d7db56a4b61d	Trabajo en dia de descanso el 2026-06-29 - VESPERTINO	f	\N	2026-06-22 03:25:15.753213+00
c0d6ad4d-6d21-483e-9934-6f31a9e347b1	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	2026-06-29	DOBLE_TURNO	fb5b5b99-145b-429a-b006-2cfc06950bf6	Turno doble el 2026-06-29 - NOCHE	f	\N	2026-06-22 03:25:20.502356+00
e51ece6d-b374-4873-8d58-f10e42ad34b5	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	2026-06-29	DOBLE_TURNO	\N	Turno doble el 2026-06-29 - VESPERTINO	f	\N	2026-06-22 03:22:13.174425+00
54b61024-7e9f-4546-b3d8-28fb67283df6	3754962c-90b1-4039-893f-a9475cdd386b	2026-06-29	DOBLE_TURNO	42d19f47-8975-4540-8c61-b218229fffbc	Turno doble el 2026-06-29 - VESPERTINO	f	\N	2026-06-22 03:25:28.793078+00
f4604018-7c4c-4156-8e00-c5b883b81002	b187fca6-d1f7-407d-ba22-d6397b6cc47c	2026-06-29	DOBLE_TURNO	61dec493-b85a-434d-a89d-222cab448f68	Turno doble el 2026-06-29 - VESPERTINO	f	\N	2026-06-22 03:25:31.918919+00
c0ad157e-92d0-4a8a-9bf4-d72ebdeaa72c	b187fca6-d1f7-407d-ba22-d6397b6cc47c	2026-06-29	DESCANSO_LABORADO	\N	Trabajo en dia de descanso el 2026-06-29 - MANANA	f	\N	2026-06-22 03:21:23.187762+00
1063c5c0-bcb9-456a-9075-2fce481d6d87	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	2026-06-29	DOBLE_TURNO	e1758438-103d-447a-8c4e-fa00797dd526	Turno doble el 2026-06-29 - VESPERTINO	f	\N	2026-06-22 03:25:38.625497+00
6d41e0c3-0717-4bfe-9818-b40d55d57635	55010ec1-e611-46c8-ba12-7d598075fafb	2026-06-29	DOBLE_TURNO	\N	Turno doble el 2026-06-29 - VESPERTINO	f	\N	2026-06-22 03:20:26.24655+00
d3179af9-e19d-446d-abd3-9e0384495f04	d31d5849-260a-4c22-ac22-ae372a52e768	2026-06-29	DOBLE_TURNO	36b11936-3196-4909-bc8f-45ab541a1b42	Turno doble el 2026-06-29 - VESPERTINO	f	\N	2026-06-22 03:25:53.461522+00
8d1ec3be-b96b-4d2f-9a75-1b2375ba526b	55010ec1-e611-46c8-ba12-7d598075fafb	2026-06-01	DOBLE_TURNO	70c52696-ca9e-4846-bd20-e62487e345f2	Turno doble el 2026-06-01 - VESPERTINO	f	\N	2026-06-25 00:44:03.495025+00
146f5633-61fe-4637-ba78-6d53f8f12db0	55010ec1-e611-46c8-ba12-7d598075fafb	2026-06-01	DOBLE_TURNO	4d7e62d6-23d1-4e0c-aff6-ac0d914345f7	Turno doble el 2026-06-01 - TARDE	f	\N	2026-06-25 00:44:08.076306+00
c4aaa5c3-6189-4d39-8d62-7614dadc4f0a	55010ec1-e611-46c8-ba12-7d598075fafb	2026-06-01	DOBLE_TURNO	eeff24b8-9df0-4303-9c13-bb9d61a64555	Turno doble el 2026-06-01 - NOCHE	f	\N	2026-06-25 00:44:11.676251+00
4373aae4-f016-4d3a-8d64-3ba1cc2d51c1	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	2026-08-03	DESCANSO_LABORADO	860ea8b5-20bd-4dc5-9c60-d962481c8fdd	Trabajo en dia de descanso el 2026-08-03 - MANANA	f	\N	2026-06-28 02:40:37.089951+00
127770f3-fc13-458d-af55-02c5a40d2a19	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	2026-08-03	DESCANSO_LABORADO	789d3a25-f3ac-4ddd-ab43-25dd4719baf4	Trabajo en dia de descanso el 2026-08-03 - TARDE	f	\N	2026-06-28 02:40:43.54016+00
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.employees (id, nombre, apellido, tipo, horas_minimas, horas_maximas, work_days, rest_days, activo, created_at, updated_at) FROM stdin;
b187fca6-d1f7-407d-ba22-d6397b6cc47c	salvador	olivar	AUXILIAR_SERVICIO	120	200	4	1	t	2026-06-21 00:53:12.007191+00	2026-06-21 00:53:12.007191+00
d31d5849-260a-4c22-ac22-ae372a52e768	aldair	olivar	SUPERVISOR	120	200	4	1	t	2026-06-21 02:24:11.817142+00	2026-06-21 02:24:11.817142+00
973f24b1-d99e-4f54-856e-9b3d3cba5986	sandra	sarmiento	AUXILIAR_SERVICIO	120	200	4	1	t	2026-06-21 02:25:19.882993+00	2026-06-21 02:25:19.882993+00
3754962c-90b1-4039-893f-a9475cdd386b	fide	olivar	NURSE_ASSISTANT	120	200	4	1	t	2026-06-21 02:26:10.404656+00	2026-06-21 02:26:10.404656+00
bb038eb1-f99a-4cd1-aa76-99a9f62bca50	javier	olivar	NURSE	120	200	4	1	t	2026-06-21 02:27:08.029315+00	2026-06-21 02:27:08.029315+00
55010ec1-e611-46c8-ba12-7d598075fafb	eugenia	amaya	SUPERVISOR	120	200	4	1	t	2026-06-20 05:50:25.844157+00	2026-06-22 03:24:01.117402+00
ab7ec850-e002-4daa-b721-8dc8a19d3eb4	micaela	camilo	NURSE	120	200	4	1	t	2026-06-22 03:25:03.380738+00	2026-06-22 03:25:03.380738+00
\.


--
-- Data for Name: goose_db_version; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.goose_db_version (id, version_id, is_applied, tstamp) FROM stdin;
1	0	t	2026-06-19 21:25:13.484137
2	1	t	2026-06-19 21:25:14.891819
3	2	t	2026-06-19 21:25:15.512271
4	3	t	2026-06-19 21:25:16.730561
24	4	t	2026-06-21 04:37:34.684248
25	5	t	2026-06-21 04:37:35.438043
26	6	t	2026-06-21 04:37:36.029484
27	7	t	2026-06-21 04:37:36.618615
28	8	t	2026-06-21 04:37:37.799184
29	9	t	2026-06-21 04:37:38.391155
30	10	t	2026-06-21 04:37:39.127284
31	11	t	2026-06-21 04:37:40.467798
32	12	t	2026-06-21 04:37:41.055276
33	13	t	2026-06-21 04:37:42.531422
34	14	t	2026-06-21 04:37:43.127434
35	15	t	2026-06-28 02:28:13.016125
36	16	t	2026-06-28 04:03:42.966902
37	17	t	2026-06-28 04:05:10.524096
\.


--
-- Data for Name: leave_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.leave_requests (id, employee_id, fecha_inicio, fecha_fin, tipo, estado, motivo, aprobado_por, created_at, updated_at) FROM stdin;
307f8960-56bc-4e82-ad45-9244376cf5a4	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	2026-07-01	2026-07-30	VACACIONES	APROBADO	para pasear con mi novio	a2379d37-5594-40de-9547-ba803e5f0774	2026-06-22 03:28:48.960482+00	2026-06-22 03:29:23.944019+00
\.


--
-- Data for Name: planificacion_dotacion; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.planificacion_dotacion (id, planificacion_id, sector, tipo_empleado, turno, cantidad_minima, created_at, updated_at) FROM stdin;
e8ceb39e-6ea6-4a2b-bf3b-132e7bdfe7b0	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb		SUPERVISOR	MANANA	1	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
62935ae2-db40-495d-a608-770955ef0f6a	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb		AUXILIAR_SERVICIO	MANANA	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
4fa435cf-17b5-4a43-88b5-6ea9eac42b7c	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	1-8	NURSE	MANANA	2	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
214179d0-48ee-4272-b46e-b9fc40abaa33	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	1-8	NURSE_ASSISTANT	MANANA	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
6c1a73f8-f1c1-45ed-a453-3882015320fc	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	9-14	NURSE	MANANA	2	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
b1f73072-9a07-47ba-84dc-921b91a544d5	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	9-14	NURSE_ASSISTANT	MANANA	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
23df9786-77c3-42b0-80f9-8b78322b7449	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb		SUPERVISOR	TARDE	1	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
e03cbcfd-b6b8-4505-b1b6-1ea2ca7f8ddc	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb		AUXILIAR_SERVICIO	TARDE	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
50c28ba3-2547-486b-8348-2dc32083bd27	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	1-8	NURSE	TARDE	2	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
7e3d07fa-e8f8-4e54-800e-f7f911ab89ff	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	1-8	NURSE_ASSISTANT	TARDE	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
8b9b6d00-f642-4914-ab2d-7a9abe2441b1	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	9-14	NURSE	TARDE	2	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
4b9d7880-f190-4252-80ce-86279f9019c8	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	9-14	NURSE_ASSISTANT	TARDE	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
db62f504-128b-4d75-8d1a-abfdb9caa208	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb		SUPERVISOR	VESPERTINO	1	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
fd1b9b75-310b-4769-ab2a-8f9fc4ae2162	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb		AUXILIAR_SERVICIO	VESPERTINO	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
bf53b407-2a7c-4e3a-b89b-cd0679c42775	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	1-8	NURSE	VESPERTINO	2	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
69466512-8252-4c76-8876-40c7072722c1	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	1-8	NURSE_ASSISTANT	VESPERTINO	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
f9ab0824-c35a-482f-bb95-b418cab17bbc	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	9-14	NURSE	VESPERTINO	2	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
04039990-dad0-4a88-83bf-a6d93a27f4ae	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	9-14	NURSE_ASSISTANT	VESPERTINO	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
fbc60cfc-cfc9-457c-9e74-6f36a8c86a4d	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb		SUPERVISOR	NOCHE	1	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
d091831b-91cc-4337-ab57-dbe449137210	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb		AUXILIAR_SERVICIO	NOCHE	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
f5e96e38-bb58-4e7e-8876-efa82dbea745	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	1-8	NURSE	NOCHE	2	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
132f2e2b-dfad-40d0-b8d0-e9ad9140e5a6	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	1-8	NURSE_ASSISTANT	NOCHE	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
0fe10b32-e3e4-47c8-8787-2ef68f019b5d	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	9-14	NURSE	NOCHE	2	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
9b865e05-d9d5-4559-8a93-5d26bbd735df	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	9-14	NURSE_ASSISTANT	NOCHE	4	2026-06-21 04:51:46.231041+00	2026-06-21 04:51:46.231041+00
5f6ae541-afcb-438a-aa6a-a5acad8e17d6	329d832f-16c1-4bc6-b532-6045d42f7895		SUPERVISOR	MANANA	1	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
c94bc465-fe3c-4937-b0bc-596ab004e3e8	329d832f-16c1-4bc6-b532-6045d42f7895		AUXILIAR_SERVICIO	MANANA	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
efe1b1ac-bdd6-45e9-beea-e18ab326825d	329d832f-16c1-4bc6-b532-6045d42f7895	1-8	NURSE	MANANA	2	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
c29f2ee8-32c8-4c5f-93bf-03af1f630ee4	329d832f-16c1-4bc6-b532-6045d42f7895	1-8	NURSE_ASSISTANT	MANANA	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
11c926f9-e8b3-4757-b8d4-3108cd1c76cc	329d832f-16c1-4bc6-b532-6045d42f7895	9-14	NURSE	MANANA	2	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
f8e9d87b-93b2-48df-af13-edd9b30b4d1d	329d832f-16c1-4bc6-b532-6045d42f7895	9-14	NURSE_ASSISTANT	MANANA	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
917e4671-be1c-432e-8230-b92188df6321	329d832f-16c1-4bc6-b532-6045d42f7895		SUPERVISOR	TARDE	1	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
bd209b9a-951c-456d-9604-8bc265f4ac23	329d832f-16c1-4bc6-b532-6045d42f7895		AUXILIAR_SERVICIO	TARDE	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
d78e8455-ab64-4e6e-b824-62d35a6adaf3	329d832f-16c1-4bc6-b532-6045d42f7895	1-8	NURSE	TARDE	2	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
9af86e84-92b7-4102-a637-0946e0c64212	329d832f-16c1-4bc6-b532-6045d42f7895	1-8	NURSE_ASSISTANT	TARDE	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
2a04a35b-2d02-4120-8e40-a18f2790fbd0	329d832f-16c1-4bc6-b532-6045d42f7895	9-14	NURSE	TARDE	2	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
769fc21e-4abd-439e-9244-c09320ded790	329d832f-16c1-4bc6-b532-6045d42f7895	9-14	NURSE_ASSISTANT	TARDE	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
9d3d367b-63d2-401f-854f-31568d9c849c	329d832f-16c1-4bc6-b532-6045d42f7895		SUPERVISOR	VESPERTINO	1	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
610d3694-5f3f-4aba-81ac-b8d1b05a40f5	329d832f-16c1-4bc6-b532-6045d42f7895		AUXILIAR_SERVICIO	VESPERTINO	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
629b5096-9e20-4088-804c-f0959191d30e	329d832f-16c1-4bc6-b532-6045d42f7895	1-8	NURSE	VESPERTINO	2	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
6365f9eb-5fc8-4970-bb2d-64700c7dd8e6	329d832f-16c1-4bc6-b532-6045d42f7895	1-8	NURSE_ASSISTANT	VESPERTINO	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
a00a32a6-7c1e-4e6e-9885-24f1fec71d6c	329d832f-16c1-4bc6-b532-6045d42f7895	9-14	NURSE	VESPERTINO	2	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
fa409a41-9f79-42cb-8768-e7b065a4f332	329d832f-16c1-4bc6-b532-6045d42f7895	9-14	NURSE_ASSISTANT	VESPERTINO	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
1d664e07-70ae-4856-be0d-f2aa195b2b32	329d832f-16c1-4bc6-b532-6045d42f7895		SUPERVISOR	NOCHE	1	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
99b77ce1-a8de-4ac9-92ac-c268abb4c825	329d832f-16c1-4bc6-b532-6045d42f7895		AUXILIAR_SERVICIO	NOCHE	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
82853bec-2e98-4f1b-8dfb-2890c09d82bf	329d832f-16c1-4bc6-b532-6045d42f7895	1-8	NURSE	NOCHE	2	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
ac1c24a8-9fc6-4439-b074-7d13be0b6b05	329d832f-16c1-4bc6-b532-6045d42f7895	1-8	NURSE_ASSISTANT	NOCHE	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
73b36308-facf-4331-88c6-5bf433ceedc9	329d832f-16c1-4bc6-b532-6045d42f7895	9-14	NURSE	NOCHE	2	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
c6c22889-eea1-4ac2-b22e-a1af099f5b59	329d832f-16c1-4bc6-b532-6045d42f7895	9-14	NURSE_ASSISTANT	NOCHE	4	2026-06-25 00:00:11.901662+00	2026-06-25 00:00:11.901662+00
4942cfac-5439-480a-9066-3d8e4049627b	c3104d56-5d85-4ece-8dfe-db69a7b77a71		SUPERVISOR	MANANA	1	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
2ca141bb-8f6b-40e0-af6d-b41ce23bb55b	c3104d56-5d85-4ece-8dfe-db69a7b77a71		AUXILIAR_SERVICIO	MANANA	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
ceb96bed-5e6f-4778-8943-b7550e386fdf	c3104d56-5d85-4ece-8dfe-db69a7b77a71	1-8	NURSE	MANANA	2	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
448a9a5a-8fa1-4956-8204-39ea2c0a0c3e	c3104d56-5d85-4ece-8dfe-db69a7b77a71	1-8	NURSE_ASSISTANT	MANANA	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
2687764b-357f-4eef-9c8f-5fe6be79dfb0	c3104d56-5d85-4ece-8dfe-db69a7b77a71	9-14	NURSE	MANANA	2	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
008483dd-c34e-4812-b597-593a388da903	c3104d56-5d85-4ece-8dfe-db69a7b77a71	9-14	NURSE_ASSISTANT	MANANA	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
d5d75bc4-5075-4416-a150-43c4a7f1f1c6	c3104d56-5d85-4ece-8dfe-db69a7b77a71		SUPERVISOR	TARDE	1	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
0099f33e-03f1-4a25-bafc-217ff2c70531	c3104d56-5d85-4ece-8dfe-db69a7b77a71		AUXILIAR_SERVICIO	TARDE	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
3b23e6f2-93c1-4948-82c1-146b80ac1f43	c3104d56-5d85-4ece-8dfe-db69a7b77a71	1-8	NURSE	TARDE	2	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
4b0c4416-8407-4e56-a23b-9af3657d7cc6	c3104d56-5d85-4ece-8dfe-db69a7b77a71	1-8	NURSE_ASSISTANT	TARDE	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
ac6df447-0014-4b8d-b474-6475dd0822cf	c3104d56-5d85-4ece-8dfe-db69a7b77a71	9-14	NURSE	TARDE	2	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
85044b0d-c9d6-477e-9836-0d967d225f15	c3104d56-5d85-4ece-8dfe-db69a7b77a71	9-14	NURSE_ASSISTANT	TARDE	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
0bb2d311-deb0-467a-a6c8-a3ece6614286	c3104d56-5d85-4ece-8dfe-db69a7b77a71		SUPERVISOR	VESPERTINO	1	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
28abed81-18b3-4032-8935-f2c49ef9bcdb	c3104d56-5d85-4ece-8dfe-db69a7b77a71		AUXILIAR_SERVICIO	VESPERTINO	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
d4d32514-9153-4aaa-b971-41148794f919	c3104d56-5d85-4ece-8dfe-db69a7b77a71	1-8	NURSE	VESPERTINO	2	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
38cdc678-9390-49a2-8952-848d55a21fc1	c3104d56-5d85-4ece-8dfe-db69a7b77a71	1-8	NURSE_ASSISTANT	VESPERTINO	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
a1773664-4034-47e2-930e-936823325e6f	c3104d56-5d85-4ece-8dfe-db69a7b77a71	9-14	NURSE	VESPERTINO	2	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
2647f6d7-0ced-4dd2-a47f-841454a55de8	c3104d56-5d85-4ece-8dfe-db69a7b77a71	9-14	NURSE_ASSISTANT	VESPERTINO	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
83e3cb9b-06af-44e0-92e2-2d5c1ebac29d	c3104d56-5d85-4ece-8dfe-db69a7b77a71		SUPERVISOR	NOCHE	1	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
c249e1d9-1845-4645-8b7b-ab96cb17334c	c3104d56-5d85-4ece-8dfe-db69a7b77a71		AUXILIAR_SERVICIO	NOCHE	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
b01fe521-d2c3-48c8-a779-f3c435fd4af0	c3104d56-5d85-4ece-8dfe-db69a7b77a71	1-8	NURSE	NOCHE	2	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
148d179a-bb1d-4076-bd88-b38055050f4c	c3104d56-5d85-4ece-8dfe-db69a7b77a71	1-8	NURSE_ASSISTANT	NOCHE	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
a49d3372-6b47-4b62-b982-5c95a76e1a13	c3104d56-5d85-4ece-8dfe-db69a7b77a71	9-14	NURSE	NOCHE	2	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
41dec4d6-7487-4843-8046-636a84f38531	c3104d56-5d85-4ece-8dfe-db69a7b77a71	9-14	NURSE_ASSISTANT	NOCHE	4	2026-06-25 00:14:30.469924+00	2026-06-25 00:14:30.469924+00
1764ff26-49c0-447a-bc1e-3c07c86f503b	bd3dba0f-c5d0-4118-85d6-1e58aa75168e		SUPERVISOR	MANANA	1	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
5c562e28-7f65-4712-ae0d-ea7519f0c61b	bd3dba0f-c5d0-4118-85d6-1e58aa75168e		AUXILIAR_SERVICIO	MANANA	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
4bf8e95d-dd5a-4ad3-a0e0-3ba59b845359	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	1-8	NURSE	MANANA	2	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
18238247-8848-44a3-9d96-2abc00b8c65e	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	1-8	NURSE_ASSISTANT	MANANA	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
04339e98-60be-413e-be70-2ba1a8c48b66	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	9-14	NURSE	MANANA	2	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
bebee614-3434-4a77-8922-91e03460b2da	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	9-14	NURSE_ASSISTANT	MANANA	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
c4eac55b-5d36-44b0-845c-8e4199bc89de	bd3dba0f-c5d0-4118-85d6-1e58aa75168e		SUPERVISOR	TARDE	1	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
80c5a7c8-68c4-4f02-b8b1-60294b1f3aed	bd3dba0f-c5d0-4118-85d6-1e58aa75168e		AUXILIAR_SERVICIO	TARDE	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
dc173406-0e7c-4816-b7fa-49c4dbfcc34e	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	1-8	NURSE	TARDE	2	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
f1e16fab-4f1f-4f16-8473-03b048b4ee59	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	1-8	NURSE_ASSISTANT	TARDE	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
0c8f9b43-7b45-44b5-b203-2a27c2579413	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	9-14	NURSE	TARDE	2	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
a60ab35d-b30e-49dd-8cb1-0780a14fb8c8	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	9-14	NURSE_ASSISTANT	TARDE	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
ae7ce177-23cc-4f11-853b-6332f6c78235	bd3dba0f-c5d0-4118-85d6-1e58aa75168e		SUPERVISOR	VESPERTINO	1	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
a0aa3fcf-e61c-4272-ba40-7e3db3ebad03	bd3dba0f-c5d0-4118-85d6-1e58aa75168e		AUXILIAR_SERVICIO	VESPERTINO	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
5d47ade7-daed-4b73-85b3-fa9cf1035bbf	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	1-8	NURSE	VESPERTINO	2	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
7a753095-336a-4353-ba65-4cac1e0b8f43	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	1-8	NURSE_ASSISTANT	VESPERTINO	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
fac64c58-ae11-4bb5-8432-9ae96ecd898e	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	9-14	NURSE	VESPERTINO	2	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
810536c9-a16a-4a07-ac28-89d7f7b5ed2f	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	9-14	NURSE_ASSISTANT	VESPERTINO	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
c94e3b0b-8cc5-4f88-bc02-afd6c4f1cfb2	bd3dba0f-c5d0-4118-85d6-1e58aa75168e		SUPERVISOR	NOCHE	1	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
19197583-210e-4f61-b403-e4adbce6671a	bd3dba0f-c5d0-4118-85d6-1e58aa75168e		AUXILIAR_SERVICIO	NOCHE	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
c866d684-35b0-42dd-9734-f50fd5b5b814	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	1-8	NURSE	NOCHE	2	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
0ea5b226-39e6-43c7-ae93-a59142c73965	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	1-8	NURSE_ASSISTANT	NOCHE	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
c886a1c9-3cf8-4afc-bc0e-1456d7408f8c	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	9-14	NURSE	NOCHE	2	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
b24c8f0e-444d-4284-bf3f-d61226619372	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	9-14	NURSE_ASSISTANT	NOCHE	4	2026-06-27 22:52:16.763228+00	2026-06-27 22:52:16.763228+00
a3949bf0-59c9-4d86-9353-71a0aa3a15c6	22a85761-0108-4c88-846a-d7af72343b4d		SUPERVISOR	MANANA	1	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
e7c5eccd-d6cb-41fb-a617-3f638e9cfcef	22a85761-0108-4c88-846a-d7af72343b4d		AUXILIAR_SERVICIO	MANANA	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
36d86f07-72bc-4f43-9493-93478ae3d58e	22a85761-0108-4c88-846a-d7af72343b4d	1-8	NURSE	MANANA	2	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
c3e99191-1cae-4a31-b850-bcd76ad22c5b	22a85761-0108-4c88-846a-d7af72343b4d	1-8	NURSE_ASSISTANT	MANANA	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
b1e16ed2-c1de-475f-a2f7-22623b11267b	22a85761-0108-4c88-846a-d7af72343b4d	9-14	NURSE	MANANA	2	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
cc92f79f-24b7-4ea4-a812-35f1f2f03168	22a85761-0108-4c88-846a-d7af72343b4d	9-14	NURSE_ASSISTANT	MANANA	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
30cfc1a6-9858-49f1-91f8-53e3521d928a	22a85761-0108-4c88-846a-d7af72343b4d		SUPERVISOR	TARDE	1	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
20e8410d-6289-4fbf-b3f5-7ff1aa1dbd8d	22a85761-0108-4c88-846a-d7af72343b4d		AUXILIAR_SERVICIO	TARDE	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
2ea6151d-1e62-4d1a-b3f5-f692ef53fef7	22a85761-0108-4c88-846a-d7af72343b4d	1-8	NURSE	TARDE	2	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
edf9fbf9-c934-40be-b523-d93ddc363661	22a85761-0108-4c88-846a-d7af72343b4d	1-8	NURSE_ASSISTANT	TARDE	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
6159be71-0208-4ebc-bd59-288867ecdb7c	22a85761-0108-4c88-846a-d7af72343b4d	9-14	NURSE	TARDE	2	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
0f2146e7-5e17-440f-99fe-d13a157f1cd0	22a85761-0108-4c88-846a-d7af72343b4d	9-14	NURSE_ASSISTANT	TARDE	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
d31755ec-024f-4b74-a02c-4cef2526bb75	22a85761-0108-4c88-846a-d7af72343b4d		SUPERVISOR	VESPERTINO	1	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
9740ee4e-4065-4868-8259-7aa80a97ba85	22a85761-0108-4c88-846a-d7af72343b4d		AUXILIAR_SERVICIO	VESPERTINO	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
d4108ca4-0f15-4946-9171-b8cbc352b211	22a85761-0108-4c88-846a-d7af72343b4d	1-8	NURSE	VESPERTINO	2	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
e42dde40-6ed6-4e29-a93f-60bd5b84f1ea	22a85761-0108-4c88-846a-d7af72343b4d	1-8	NURSE_ASSISTANT	VESPERTINO	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
52ddf879-717b-4b03-9c10-7c745a1b8031	22a85761-0108-4c88-846a-d7af72343b4d	9-14	NURSE	VESPERTINO	2	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
006c5b0c-c287-4fba-850d-f220dd5b402e	22a85761-0108-4c88-846a-d7af72343b4d	9-14	NURSE_ASSISTANT	VESPERTINO	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
1f7ce1ed-92c6-4161-ad6b-66fcf010a86e	22a85761-0108-4c88-846a-d7af72343b4d		SUPERVISOR	NOCHE	1	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
8677d405-5443-4531-81c7-5a1dae66e509	22a85761-0108-4c88-846a-d7af72343b4d		AUXILIAR_SERVICIO	NOCHE	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
f66a54b5-a6c6-4fe2-abbf-37ebb0306c2b	22a85761-0108-4c88-846a-d7af72343b4d	1-8	NURSE	NOCHE	2	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
a3e46f48-e2cd-47f2-9f52-471a750d5085	22a85761-0108-4c88-846a-d7af72343b4d	1-8	NURSE_ASSISTANT	NOCHE	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
c6ae943a-3232-4c8c-a3ee-0c88be25d536	22a85761-0108-4c88-846a-d7af72343b4d	9-14	NURSE	NOCHE	2	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
3cf924b2-ba87-4d65-a57e-3f424d9d5aa4	22a85761-0108-4c88-846a-d7af72343b4d	9-14	NURSE_ASSISTANT	NOCHE	4	2026-06-28 02:40:16.707967+00	2026-06-28 02:40:16.707967+00
1f0d38ef-a183-4ca7-9891-255db9bdc870	6e684b1d-8418-44ad-93fd-de297c6cfb48		SUPERVISOR	MANANA	1	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
daa31762-912a-4dfe-833b-37878229c145	6e684b1d-8418-44ad-93fd-de297c6cfb48		AUXILIAR_SERVICIO	MANANA	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
a148120a-ebc8-42fa-9fde-302acee8b3c7	6e684b1d-8418-44ad-93fd-de297c6cfb48	1-8	NURSE	MANANA	2	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
f33723e5-4848-491c-ade6-577874fa760c	6e684b1d-8418-44ad-93fd-de297c6cfb48	1-8	NURSE_ASSISTANT	MANANA	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
06cef774-81e4-4c4b-b72d-b52905413241	6e684b1d-8418-44ad-93fd-de297c6cfb48	9-14	NURSE	MANANA	2	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
f1b83c70-a81d-42df-89bc-6e8abfdd28b2	6e684b1d-8418-44ad-93fd-de297c6cfb48	9-14	NURSE_ASSISTANT	MANANA	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
98075613-dd72-4ea0-9f51-910df3243ab4	6e684b1d-8418-44ad-93fd-de297c6cfb48		SUPERVISOR	TARDE	1	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
53fe89f6-57f1-49c7-95a9-0d5eb6b8795d	6e684b1d-8418-44ad-93fd-de297c6cfb48		AUXILIAR_SERVICIO	TARDE	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
9b51acbc-6923-4a7a-b995-375002d6957e	6e684b1d-8418-44ad-93fd-de297c6cfb48	1-8	NURSE	TARDE	2	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
b23fa0e7-e35b-4651-a657-fc57f4544cf6	6e684b1d-8418-44ad-93fd-de297c6cfb48	1-8	NURSE_ASSISTANT	TARDE	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
9d7d9cb5-57da-4016-9526-8edf5c6924eb	6e684b1d-8418-44ad-93fd-de297c6cfb48	9-14	NURSE	TARDE	2	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
eba5f24c-6c9a-465b-bae0-16b154c60086	6e684b1d-8418-44ad-93fd-de297c6cfb48	9-14	NURSE_ASSISTANT	TARDE	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
a75f995a-411b-4b33-9384-5de76800058f	6e684b1d-8418-44ad-93fd-de297c6cfb48		SUPERVISOR	VESPERTINO	1	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
352f13f1-89ef-406f-800a-6360707cd454	6e684b1d-8418-44ad-93fd-de297c6cfb48		AUXILIAR_SERVICIO	VESPERTINO	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
0c4fb386-9b3e-47de-b5d0-9c03cdd671c4	6e684b1d-8418-44ad-93fd-de297c6cfb48	1-8	NURSE	VESPERTINO	2	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
156dfa03-8671-4df5-b682-de0435e16111	6e684b1d-8418-44ad-93fd-de297c6cfb48	1-8	NURSE_ASSISTANT	VESPERTINO	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
63e50d91-0994-4ccb-aae7-4d4de2826cb8	6e684b1d-8418-44ad-93fd-de297c6cfb48	9-14	NURSE	VESPERTINO	2	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
0724d736-2859-4161-a3db-4890ad2b3dee	6e684b1d-8418-44ad-93fd-de297c6cfb48	9-14	NURSE_ASSISTANT	VESPERTINO	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
c8760800-fcf7-4c91-961d-a622220b93bb	6e684b1d-8418-44ad-93fd-de297c6cfb48		SUPERVISOR	NOCHE	1	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
8dfd856e-a389-438a-a433-a38fe1270475	6e684b1d-8418-44ad-93fd-de297c6cfb48		AUXILIAR_SERVICIO	NOCHE	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
8d41923b-9c78-47dd-8d57-7e7912802cb8	6e684b1d-8418-44ad-93fd-de297c6cfb48	1-8	NURSE	NOCHE	2	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
c73d0e88-182c-4c63-903a-90500b05da87	6e684b1d-8418-44ad-93fd-de297c6cfb48	1-8	NURSE_ASSISTANT	NOCHE	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
64547fc6-6dbd-405d-a4f9-f451f60a077e	6e684b1d-8418-44ad-93fd-de297c6cfb48	9-14	NURSE	NOCHE	2	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
070c89b0-220a-42fd-a0e9-dee91b8b7dad	6e684b1d-8418-44ad-93fd-de297c6cfb48	9-14	NURSE_ASSISTANT	NOCHE	4	2026-06-28 03:46:43.083228+00	2026-06-28 03:46:43.083228+00
\.


--
-- Data for Name: planificacion_sectores; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.planificacion_sectores (id, planificacion_id, nombre, created_at) FROM stdin;
0840ac88-0d81-4f8d-a32d-d3efed00d68d	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	1-8	2026-06-21 04:51:45.503939+00
2ea4d3c8-be39-4d7b-85cf-77b71c2bc9b3	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	9-14	2026-06-21 04:51:45.642646+00
c81ad5ac-5311-4958-a7d8-f85488e7de3f	329d832f-16c1-4bc6-b532-6045d42f7895	1-8	2026-06-25 00:00:10.841838+00
7c255e44-8a0b-4a76-8c25-0a286cd73762	329d832f-16c1-4bc6-b532-6045d42f7895	9-14	2026-06-25 00:00:11.154392+00
a72d05db-6d7d-4376-bcf8-b306d89cc775	c3104d56-5d85-4ece-8dfe-db69a7b77a71	1-8	2026-06-25 00:14:29.720909+00
43223f8d-bc61-492d-8b44-8bbe1c2a63ef	c3104d56-5d85-4ece-8dfe-db69a7b77a71	9-14	2026-06-25 00:14:29.871128+00
56ad7387-08b1-4e2c-9ca8-af0e3ac6164d	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	1-8	2026-06-27 22:52:15.331055+00
61c845f4-6a0a-48a5-9709-cb151b15274d	bd3dba0f-c5d0-4118-85d6-1e58aa75168e	9-14	2026-06-27 22:52:15.739624+00
bf3a2a66-7ba3-4443-83b2-5c5c128e0b9f	22a85761-0108-4c88-846a-d7af72343b4d	1-8	2026-06-28 02:40:15.274781+00
950d9530-f34f-4912-9db1-3445d774954e	22a85761-0108-4c88-846a-d7af72343b4d	9-14	2026-06-28 02:40:15.684356+00
1b1365bf-b93e-4308-aa4e-c7fe4f61b825	6e684b1d-8418-44ad-93fd-de297c6cfb48	1-8	2026-06-28 03:46:41.750227+00
3630e271-45ba-41bb-8f83-4666b4593a67	6e684b1d-8418-44ad-93fd-de297c6cfb48	9-14	2026-06-28 03:46:42.160186+00
\.


--
-- Data for Name: planificaciones; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.planificaciones (id, semana, anio, nombre, estado, created_at, updated_at) FROM stdin;
bd3dba0f-c5d0-4118-85d6-1e58aa75168e	29	2026	Planificación Semana del lun 13/7	BORRADOR	2026-06-27 22:52:14.306072+00	2026-06-27 22:52:14.306072+00
22a85761-0108-4c88-846a-d7af72343b4d	32	2026	Planificación Semana del lun 3/8	PUBLICADO	2026-06-28 02:40:14.35377+00	2026-06-28 02:40:57.159899+00
c3104d56-5d85-4ece-8dfe-db69a7b77a71	23	2026	Planificación Semana del lun 1/6	CERRADO	2026-06-25 00:14:29.270056+00	2026-06-28 03:34:03.573374+00
6e684b1d-8418-44ad-93fd-de297c6cfb48	26	2026	Planificación Semana del lun 22/6	CERRADO	2026-06-28 03:46:40.726694+00	2026-06-30 00:43:22.097995+00
c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	27	2026	Planificación Semana del lun 29/6 (incluye jul)	CERRADO	2026-06-21 04:51:45.059009+00	2026-07-11 02:14:48.208868+00
329d832f-16c1-4bc6-b532-6045d42f7895	28	2026	Planificación Semana del lun 6/7	CERRADO	2026-06-25 00:00:10.05985+00	2026-07-25 02:56:50.208839+00
\.


--
-- Data for Name: shift_swap_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shift_swap_history (id, swap_request_id, accion, actor_id, detalle, created_at) FROM stdin;
20404bba-325d-423d-b1a2-65df0fa6d390	d8a23e28-340f-47b0-8d56-e0bdc3716dcb	SOLICITADO	f48cd361-1bf0-49a9-8ea6-244d6b2433a3	\N	2026-06-23 22:22:05.313206+00
c38faff2-3c03-477b-ad83-c7e5e102aad7	d8a23e28-340f-47b0-8d56-e0bdc3716dcb	EJECUTADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	\N	2026-06-23 22:30:58.408493+00
fa9448d1-1e53-4202-9c27-15a2fac87324	2921f2e5-f459-4929-b47a-fb0c1cd9441b	SOLICITADO	ac2b5c81-2dda-42da-9838-1b49ca4d7f60	\N	2026-06-28 02:33:45.532078+00
f3cbea5a-e113-4093-9453-7bbb1d5e577d	09ef1e9a-c15b-42c1-bc5c-9e7e29081af6	SOLICITADO	ac2b5c81-2dda-42da-9838-1b49ca4d7f60	\N	2026-06-28 02:42:14.88241+00
b9ff38e4-b510-489a-b265-d377a484f108	de34c2d7-7d48-4b69-a0d2-11a629f5bfa7	SOLICITADO	73042875-3233-4858-8376-e9de491cd249	\N	2026-06-28 02:45:38.970012+00
21c224fa-3871-47d2-9c99-82c35fd36640	a0ef3afc-5e48-4f04-b050-9003f981b7df	SOLICITADO	ac2b5c81-2dda-42da-9838-1b49ca4d7f60	\N	2026-06-28 02:54:59.588317+00
5a934d2d-711a-4d8d-b856-5e114f4d2105	a0ef3afc-5e48-4f04-b050-9003f981b7df	EJECUTADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	\N	2026-06-28 03:01:11.701308+00
12f1ca17-8f67-494c-be3b-c7b38fa50e43	9fa140d6-596b-493e-81e3-bcdb0099999e	SOLICITADO	ac2b5c81-2dda-42da-9838-1b49ca4d7f60	\N	2026-06-28 03:05:49.656235+00
7390c2c2-f39e-469e-ae44-1b1853d1b697	9fa140d6-596b-493e-81e3-bcdb0099999e	EJECUTADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	\N	2026-06-28 03:07:03.077516+00
b3a86dcb-54e2-425b-9010-833e4202ed53	af01b2fe-5872-4e8e-a7d8-7f89b211f532	SOLICITADO	73042875-3233-4858-8376-e9de491cd249	\N	2026-06-28 03:11:56.757568+00
3aa47197-24c6-4094-a422-0347ea02ba28	af01b2fe-5872-4e8e-a7d8-7f89b211f532	CANCELADO	73042875-3233-4858-8376-e9de491cd249	\N	2026-06-28 03:16:53.010951+00
d3a5add7-9ab1-4c39-af01-04d2645bc997	09517c7d-5d7b-4e53-b0b5-3b560e2776b5	SOLICITADO	73042875-3233-4858-8376-e9de491cd249	\N	2026-06-28 03:17:18.507179+00
b177399a-e1bf-4f70-9b78-6bdf509c1da8	09517c7d-5d7b-4e53-b0b5-3b560e2776b5	ACEPTADO	ac2b5c81-2dda-42da-9838-1b49ca4d7f60	\N	2026-06-28 03:17:30.489545+00
93f90b96-bf30-4d27-ad5c-0910cfc2094b	09517c7d-5d7b-4e53-b0b5-3b560e2776b5	EJECUTADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	\N	2026-06-28 03:17:41.752561+00
58e94a6a-cd1c-40d4-be48-e1aa20851c58	a5e6cd9b-2b9e-4032-b4a4-f005f0c326a6	SOLICITADO	73042875-3233-4858-8376-e9de491cd249	\N	2026-06-28 17:39:48.179913+00
bc17f79f-89b5-443a-a215-b6da7c3f203a	a5e6cd9b-2b9e-4032-b4a4-f005f0c326a6	ACEPTADO	ac2b5c81-2dda-42da-9838-1b49ca4d7f60	\N	2026-06-28 17:40:08.347647+00
3240a48d-42fb-4c5d-a377-7494c7fc93fc	a5e6cd9b-2b9e-4032-b4a4-f005f0c326a6	EJECUTADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	\N	2026-06-28 17:41:23.920632+00
\.


--
-- Data for Name: shift_swap_requests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.shift_swap_requests (id, planificacion_id, turno_solicitante_id, turno_destino_id, solicitante_id, destino_id, estado, aprobado_por, created_at, updated_at) FROM stdin;
d8a23e28-340f-47b0-8d56-e0bdc3716dcb	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	61dec493-b85a-434d-a89d-222cab448f68	ea4f1011-551b-4e3e-b4ab-0afa37b92e00	b187fca6-d1f7-407d-ba22-d6397b6cc47c	973f24b1-d99e-4f54-856e-9b3d3cba5986	APROBADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	2026-06-23 22:22:04.799273+00	2026-06-23 22:30:56.770007+00
09ef1e9a-c15b-42c1-bc5c-9e7e29081af6	22a85761-0108-4c88-846a-d7af72343b4d	860ea8b5-20bd-4dc5-9c60-d962481c8fdd	789d3a25-f3ac-4ddd-ab43-25dd4719baf4	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	CANCELADO	\N	2026-06-28 02:42:14.677728+00	2026-06-28 02:51:57.852333+00
2921f2e5-f459-4929-b47a-fb0c1cd9441b	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	b1624dcb-5e16-4ff1-a9f3-d7db56a4b61d	e1758438-103d-447a-8c4e-fa00797dd526	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	CANCELADO	\N	2026-06-28 02:33:45.123478+00	2026-06-28 02:52:03.690156+00
de34c2d7-7d48-4b69-a0d2-11a629f5bfa7	22a85761-0108-4c88-846a-d7af72343b4d	789d3a25-f3ac-4ddd-ab43-25dd4719baf4	860ea8b5-20bd-4dc5-9c60-d962481c8fdd	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	CANCELADO	\N	2026-06-28 02:45:38.763808+00	2026-06-28 02:57:37.819041+00
a0ef3afc-5e48-4f04-b050-9003f981b7df	22a85761-0108-4c88-846a-d7af72343b4d	860ea8b5-20bd-4dc5-9c60-d962481c8fdd	789d3a25-f3ac-4ddd-ab43-25dd4719baf4	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	APROBADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	2026-06-28 02:54:59.44013+00	2026-06-28 03:01:09.281652+00
9fa140d6-596b-493e-81e3-bcdb0099999e	22a85761-0108-4c88-846a-d7af72343b4d	789d3a25-f3ac-4ddd-ab43-25dd4719baf4	860ea8b5-20bd-4dc5-9c60-d962481c8fdd	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	APROBADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	2026-06-28 03:05:49.246166+00	2026-06-28 03:07:00.619393+00
af01b2fe-5872-4e8e-a7d8-7f89b211f532	c3104d56-5d85-4ece-8dfe-db69a7b77a71	edf52852-1c1f-4cd2-ba37-f565bb3f55e6	39a24bdb-f229-41d6-b2b3-6b4ec1a25ffb	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	CANCELADO	\N	2026-06-28 03:11:56.456095+00	2026-06-28 03:16:52.600801+00
09517c7d-5d7b-4e53-b0b5-3b560e2776b5	22a85761-0108-4c88-846a-d7af72343b4d	789d3a25-f3ac-4ddd-ab43-25dd4719baf4	860ea8b5-20bd-4dc5-9c60-d962481c8fdd	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	APROBADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	2026-06-28 03:17:18.097704+00	2026-06-28 03:17:38.98809+00
a5e6cd9b-2b9e-4032-b4a4-f005f0c326a6	22a85761-0108-4c88-846a-d7af72343b4d	860ea8b5-20bd-4dc5-9c60-d962481c8fdd	789d3a25-f3ac-4ddd-ab43-25dd4719baf4	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	APROBADO	524a3e5d-cfe8-40f6-837a-93e9bfab6bc1	2026-06-28 17:39:47.766725+00	2026-06-28 17:41:22.078036+00
\.


--
-- Data for Name: turnos; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.turnos (id, planificacion_id, empleado_id, dia_semana, turno, sector, created_at, updated_at) FROM stdin;
87a1c6e2-34b3-444d-8b9f-af3627a02777	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	d31d5849-260a-4c22-ac22-ae372a52e768	3	MANANA		2026-06-21 04:56:32.495791+00	2026-06-21 04:56:32.495791+00
a733fa8d-2641-4d5f-b725-f1f637f299eb	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	3	MANANA	1-8	2026-06-21 04:56:36.804005+00	2026-06-21 04:56:36.804005+00
4fc332f6-6962-473c-a720-e1ac8d014db9	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	3754962c-90b1-4039-893f-a9475cdd386b	3	MANANA	1-8	2026-06-21 04:56:39.827465+00	2026-06-21 04:56:39.827465+00
9eab1406-dc9e-4593-bf3b-42170b0d77ef	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	b187fca6-d1f7-407d-ba22-d6397b6cc47c	3	MANANA		2026-06-21 04:56:43.289101+00	2026-06-21 04:56:43.289101+00
850a619c-8cf2-4efa-bf76-e106578bfde4	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	55010ec1-e611-46c8-ba12-7d598075fafb	3	MANANA		2026-06-21 04:56:51.629206+00	2026-06-21 04:56:51.629206+00
ccaf9ae3-29f2-4eca-97d0-cbfe41262736	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	55010ec1-e611-46c8-ba12-7d598075fafb	1	MANANA		2026-06-22 03:20:14.41847+00	2026-06-22 03:20:14.41847+00
374a5729-72c9-47cd-bd17-ddf1dd4c7198	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	d31d5849-260a-4c22-ac22-ae372a52e768	1	TARDE		2026-06-22 03:20:19.658936+00	2026-06-22 03:20:19.658936+00
5b6fd4f1-eb1e-4fa2-af97-3e2124891415	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	55010ec1-e611-46c8-ba12-7d598075fafb	1	NOCHE		2026-06-22 03:20:29.294757+00	2026-06-22 03:20:29.294757+00
b573ef7b-4508-4a4b-8524-6c438274764a	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	1	MANANA	1-8	2026-06-22 03:21:00.296726+00	2026-06-22 03:21:00.296726+00
e61b511d-30f6-4e48-9401-127c7bdbba3f	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	3754962c-90b1-4039-893f-a9475cdd386b	1	MANANA	1-8	2026-06-22 03:21:10.648948+00	2026-06-22 03:21:10.648948+00
97b71455-b7cf-47eb-a6cc-4086e55b01c1	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	1	TARDE	1-8	2026-06-22 03:21:52.42763+00	2026-06-22 03:21:52.42763+00
b1624dcb-5e16-4ff1-a9f3-d7db56a4b61d	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	1	VESPERTINO	1-8	2026-06-22 03:25:15.304633+00	2026-06-22 03:25:15.304633+00
fb5b5b99-145b-429a-b006-2cfc06950bf6	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	1	NOCHE	1-8	2026-06-22 03:25:20.042938+00	2026-06-22 03:25:20.042938+00
42d19f47-8975-4540-8c61-b218229fffbc	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	3754962c-90b1-4039-893f-a9475cdd386b	1	VESPERTINO	1-8	2026-06-22 03:25:28.345716+00	2026-06-22 03:25:28.345716+00
e1758438-103d-447a-8c4e-fa00797dd526	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	1	VESPERTINO	9-14	2026-06-22 03:25:38.177529+00	2026-06-22 03:25:38.177529+00
36b11936-3196-4909-bc8f-45ab541a1b42	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	d31d5849-260a-4c22-ac22-ae372a52e768	1	VESPERTINO		2026-06-22 03:25:53.012739+00	2026-06-22 03:25:53.012739+00
61dec493-b85a-434d-a89d-222cab448f68	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	973f24b1-d99e-4f54-856e-9b3d3cba5986	1	VESPERTINO		2026-06-22 03:25:31.470306+00	2026-06-22 03:25:31.470306+00
ea4f1011-551b-4e3e-b4ab-0afa37b92e00	c4e33dfc-e2c6-48ea-b2ee-b6bf78eb16cb	b187fca6-d1f7-407d-ba22-d6397b6cc47c	1	MANANA		2026-06-22 03:21:25.881848+00	2026-06-22 03:21:25.881848+00
5fde6b95-e455-49a0-a40b-3597d7ec6f0f	329d832f-16c1-4bc6-b532-6045d42f7895	55010ec1-e611-46c8-ba12-7d598075fafb	1	MANANA		2026-06-25 00:01:09.70771+00	2026-06-25 00:01:09.70771+00
4f3b1657-13f6-496a-b101-aca44efe1e38	c3104d56-5d85-4ece-8dfe-db69a7b77a71	55010ec1-e611-46c8-ba12-7d598075fafb	1	MANANA		2026-06-25 00:43:04.239069+00	2026-06-25 00:43:04.239069+00
5811ad34-ba11-40e4-8f0d-b502d20af220	c3104d56-5d85-4ece-8dfe-db69a7b77a71	d31d5849-260a-4c22-ac22-ae372a52e768	1	MANANA		2026-06-25 00:43:07.52668+00	2026-06-25 00:43:07.52668+00
39a24bdb-f229-41d6-b2b3-6b4ec1a25ffb	c3104d56-5d85-4ece-8dfe-db69a7b77a71	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	1	MANANA	1-8	2026-06-25 00:43:27.877221+00	2026-06-25 00:43:27.877221+00
5cd598e6-c8d0-4488-93a7-59973d975cf5	c3104d56-5d85-4ece-8dfe-db69a7b77a71	3754962c-90b1-4039-893f-a9475cdd386b	1	MANANA	1-8	2026-06-25 00:43:30.333137+00	2026-06-25 00:43:30.333137+00
edf52852-1c1f-4cd2-ba37-f565bb3f55e6	c3104d56-5d85-4ece-8dfe-db69a7b77a71	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	1	MANANA	9-14	2026-06-25 00:43:34.477862+00	2026-06-25 00:43:34.477862+00
70c52696-ca9e-4846-bd20-e62487e345f2	c3104d56-5d85-4ece-8dfe-db69a7b77a71	55010ec1-e611-46c8-ba12-7d598075fafb	1	VESPERTINO		2026-06-25 00:44:02.593297+00	2026-06-25 00:44:02.593297+00
4d7e62d6-23d1-4e0c-aff6-ac0d914345f7	c3104d56-5d85-4ece-8dfe-db69a7b77a71	55010ec1-e611-46c8-ba12-7d598075fafb	1	TARDE		2026-06-25 00:44:07.636152+00	2026-06-25 00:44:07.636152+00
eeff24b8-9df0-4303-9c13-bb9d61a64555	c3104d56-5d85-4ece-8dfe-db69a7b77a71	55010ec1-e611-46c8-ba12-7d598075fafb	1	NOCHE		2026-06-25 00:44:11.228805+00	2026-06-25 00:44:11.228805+00
860ea8b5-20bd-4dc5-9c60-d962481c8fdd	22a85761-0108-4c88-846a-d7af72343b4d	ab7ec850-e002-4daa-b721-8dc8a19d3eb4	1	MANANA	1-8	2026-06-28 02:40:35.858933+00	2026-06-28 02:40:35.858933+00
789d3a25-f3ac-4ddd-ab43-25dd4719baf4	22a85761-0108-4c88-846a-d7af72343b4d	bb038eb1-f99a-4cd1-aa76-99a9f62bca50	1	TARDE	1-8	2026-06-28 02:40:42.925277+00	2026-06-28 02:40:42.925277+00
\.


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.goose_db_version_id_seq', 37, true);


--
-- Name: auth_sessions auth_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_sessions
    ADD CONSTRAINT auth_sessions_pkey PRIMARY KEY (id);


--
-- Name: auth_sessions auth_sessions_token_hash_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_sessions
    ADD CONSTRAINT auth_sessions_token_hash_key UNIQUE (token_hash);


--
-- Name: auth_users auth_users_employee_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_users
    ADD CONSTRAINT auth_users_employee_id_key UNIQUE (employee_id);


--
-- Name: auth_users auth_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_users
    ADD CONSTRAINT auth_users_pkey PRIMARY KEY (id);


--
-- Name: auth_users auth_users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_users
    ADD CONSTRAINT auth_users_username_key UNIQUE (username);


--
-- Name: compensatory_days compensatory_days_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compensatory_days
    ADD CONSTRAINT compensatory_days_pkey PRIMARY KEY (id);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: goose_db_version goose_db_version_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.goose_db_version
    ADD CONSTRAINT goose_db_version_pkey PRIMARY KEY (id);


--
-- Name: leave_requests leave_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT leave_requests_pkey PRIMARY KEY (id);


--
-- Name: planificacion_dotacion planificacion_dotacion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planificacion_dotacion
    ADD CONSTRAINT planificacion_dotacion_pkey PRIMARY KEY (id);


--
-- Name: planificacion_dotacion planificacion_dotacion_planificacion_id_sector_tipo_emplead_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planificacion_dotacion
    ADD CONSTRAINT planificacion_dotacion_planificacion_id_sector_tipo_emplead_key UNIQUE (planificacion_id, sector, tipo_empleado, turno);


--
-- Name: planificacion_sectores planificacion_sectores_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planificacion_sectores
    ADD CONSTRAINT planificacion_sectores_pkey PRIMARY KEY (id);


--
-- Name: planificacion_sectores planificacion_sectores_planificacion_id_nombre_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planificacion_sectores
    ADD CONSTRAINT planificacion_sectores_planificacion_id_nombre_key UNIQUE (planificacion_id, nombre);


--
-- Name: planificaciones planificaciones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planificaciones
    ADD CONSTRAINT planificaciones_pkey PRIMARY KEY (id);


--
-- Name: planificaciones planificaciones_semana_anio_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planificaciones
    ADD CONSTRAINT planificaciones_semana_anio_key UNIQUE (semana, anio);


--
-- Name: shift_swap_history shift_swap_history_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_history
    ADD CONSTRAINT shift_swap_history_pkey PRIMARY KEY (id);


--
-- Name: shift_swap_requests shift_swap_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_requests
    ADD CONSTRAINT shift_swap_requests_pkey PRIMARY KEY (id);


--
-- Name: turnos turnos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_pkey PRIMARY KEY (id);


--
-- Name: turnos turnos_planificacion_id_empleado_id_dia_semana_turno_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_planificacion_id_empleado_id_dia_semana_turno_key UNIQUE (planificacion_id, empleado_id, dia_semana, turno);


--
-- Name: idx_auth_sessions_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_sessions_expires_at ON public.auth_sessions USING btree (expires_at);


--
-- Name: idx_auth_sessions_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_sessions_user_id ON public.auth_sessions USING btree (user_id);


--
-- Name: idx_compensatory_days_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compensatory_days_employee_id ON public.compensatory_days USING btree (employee_id);


--
-- Name: idx_leave_requests_employee_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_leave_requests_employee_id ON public.leave_requests USING btree (employee_id);


--
-- Name: idx_leave_requests_estado; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_leave_requests_estado ON public.leave_requests USING btree (estado);


--
-- Name: idx_leave_requests_fechas; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_leave_requests_fechas ON public.leave_requests USING btree (fecha_inicio, fecha_fin);


--
-- Name: idx_swap_history_request; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_swap_history_request ON public.shift_swap_history USING btree (swap_request_id);


--
-- Name: idx_swap_requests_destino; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_swap_requests_destino ON public.shift_swap_requests USING btree (destino_id);


--
-- Name: idx_swap_requests_estado; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_swap_requests_estado ON public.shift_swap_requests USING btree (estado);


--
-- Name: idx_swap_requests_solicitante; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_swap_requests_solicitante ON public.shift_swap_requests USING btree (solicitante_id);


--
-- Name: idx_turnos_empleado; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_turnos_empleado ON public.turnos USING btree (empleado_id);


--
-- Name: idx_turnos_planificacion; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_turnos_planificacion ON public.turnos USING btree (planificacion_id);


--
-- Name: auth_sessions auth_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_sessions
    ADD CONSTRAINT auth_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.auth_users(id) ON DELETE CASCADE;


--
-- Name: auth_users auth_users_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_users
    ADD CONSTRAINT auth_users_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE SET NULL;


--
-- Name: compensatory_days compensatory_days_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compensatory_days
    ADD CONSTRAINT compensatory_days_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;


--
-- Name: compensatory_days compensatory_days_turno_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compensatory_days
    ADD CONSTRAINT compensatory_days_turno_id_fkey FOREIGN KEY (turno_id) REFERENCES public.turnos(id) ON DELETE SET NULL;


--
-- Name: leave_requests leave_requests_aprobado_por_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT leave_requests_aprobado_por_fkey FOREIGN KEY (aprobado_por) REFERENCES public.auth_users(id) ON DELETE SET NULL;


--
-- Name: leave_requests leave_requests_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leave_requests
    ADD CONSTRAINT leave_requests_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id) ON DELETE CASCADE;


--
-- Name: planificacion_dotacion planificacion_dotacion_planificacion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planificacion_dotacion
    ADD CONSTRAINT planificacion_dotacion_planificacion_id_fkey FOREIGN KEY (planificacion_id) REFERENCES public.planificaciones(id) ON DELETE CASCADE;


--
-- Name: planificacion_sectores planificacion_sectores_planificacion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.planificacion_sectores
    ADD CONSTRAINT planificacion_sectores_planificacion_id_fkey FOREIGN KEY (planificacion_id) REFERENCES public.planificaciones(id) ON DELETE CASCADE;


--
-- Name: shift_swap_history shift_swap_history_actor_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_history
    ADD CONSTRAINT shift_swap_history_actor_id_fkey FOREIGN KEY (actor_id) REFERENCES public.auth_users(id);


--
-- Name: shift_swap_history shift_swap_history_swap_request_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_history
    ADD CONSTRAINT shift_swap_history_swap_request_id_fkey FOREIGN KEY (swap_request_id) REFERENCES public.shift_swap_requests(id) ON DELETE CASCADE;


--
-- Name: shift_swap_requests shift_swap_requests_aprobado_por_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_requests
    ADD CONSTRAINT shift_swap_requests_aprobado_por_fkey FOREIGN KEY (aprobado_por) REFERENCES public.auth_users(id);


--
-- Name: shift_swap_requests shift_swap_requests_destino_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_requests
    ADD CONSTRAINT shift_swap_requests_destino_id_fkey FOREIGN KEY (destino_id) REFERENCES public.employees(id);


--
-- Name: shift_swap_requests shift_swap_requests_planificacion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_requests
    ADD CONSTRAINT shift_swap_requests_planificacion_id_fkey FOREIGN KEY (planificacion_id) REFERENCES public.planificaciones(id) ON DELETE CASCADE;


--
-- Name: shift_swap_requests shift_swap_requests_solicitante_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_requests
    ADD CONSTRAINT shift_swap_requests_solicitante_id_fkey FOREIGN KEY (solicitante_id) REFERENCES public.employees(id);


--
-- Name: shift_swap_requests shift_swap_requests_turno_destino_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_requests
    ADD CONSTRAINT shift_swap_requests_turno_destino_id_fkey FOREIGN KEY (turno_destino_id) REFERENCES public.turnos(id);


--
-- Name: shift_swap_requests shift_swap_requests_turno_solicitante_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shift_swap_requests
    ADD CONSTRAINT shift_swap_requests_turno_solicitante_id_fkey FOREIGN KEY (turno_solicitante_id) REFERENCES public.turnos(id);


--
-- Name: turnos turnos_empleado_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_empleado_id_fkey FOREIGN KEY (empleado_id) REFERENCES public.employees(id);


--
-- Name: turnos turnos_planificacion_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.turnos
    ADD CONSTRAINT turnos_planificacion_id_fkey FOREIGN KEY (planificacion_id) REFERENCES public.planificaciones(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict kdMmnjrlXEK77upqQFvHkpN50xOGJXRm8a6hYx7uThjC5VHfrY5O2Tg0YZnMLHn

