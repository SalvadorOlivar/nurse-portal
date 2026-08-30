--
-- PostgreSQL database dump
--

\restrict Y6xTlElgYkFokWminXyomfBNyhEKIfnhNxe1DHNGEa0dAPkyBrE9KZ6LDf4lDbc

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.10

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP EVENT TRIGGER IF EXISTS pgrst_drop_watch;
DROP EVENT TRIGGER IF EXISTS pgrst_ddl_watch;
DROP EVENT TRIGGER IF EXISTS issue_pg_net_access;
DROP EVENT TRIGGER IF EXISTS issue_pg_graphql_access;
DROP EVENT TRIGGER IF EXISTS issue_pg_cron_access;
DROP EVENT TRIGGER IF EXISTS issue_graphql_placeholder;
DROP PUBLICATION IF EXISTS supabase_realtime;
ALTER TABLE IF EXISTS ONLY storage.vector_indexes DROP CONSTRAINT IF EXISTS vector_indexes_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_upload_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads DROP CONSTRAINT IF EXISTS s3_multipart_uploads_bucket_id_fkey;
ALTER TABLE IF EXISTS ONLY storage.objects DROP CONSTRAINT IF EXISTS "objects_bucketId_fkey";
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
ALTER TABLE IF EXISTS ONLY auth.webauthn_credentials DROP CONSTRAINT IF EXISTS webauthn_credentials_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.webauthn_challenges DROP CONSTRAINT IF EXISTS webauthn_challenges_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.sso_domains DROP CONSTRAINT IF EXISTS sso_domains_sso_provider_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.sessions DROP CONSTRAINT IF EXISTS sessions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.sessions DROP CONSTRAINT IF EXISTS sessions_oauth_client_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.saml_relay_states DROP CONSTRAINT IF EXISTS saml_relay_states_sso_provider_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.saml_relay_states DROP CONSTRAINT IF EXISTS saml_relay_states_flow_state_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.saml_providers DROP CONSTRAINT IF EXISTS saml_providers_sso_provider_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_session_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.one_time_tokens DROP CONSTRAINT IF EXISTS one_time_tokens_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_client_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_client_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_factors DROP CONSTRAINT IF EXISTS mfa_factors_user_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_challenges DROP CONSTRAINT IF EXISTS mfa_challenges_auth_factor_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_amr_claims DROP CONSTRAINT IF EXISTS mfa_amr_claims_session_id_fkey;
ALTER TABLE IF EXISTS ONLY auth.identities DROP CONSTRAINT IF EXISTS identities_user_id_fkey;
DROP TRIGGER IF EXISTS update_objects_updated_at ON storage.objects;
DROP TRIGGER IF EXISTS protect_objects_delete ON storage.objects;
DROP TRIGGER IF EXISTS protect_buckets_delete ON storage.buckets;
DROP TRIGGER IF EXISTS enforce_bucket_name_length_trigger ON storage.buckets;
DROP TRIGGER IF EXISTS tr_check_filters ON realtime.subscription;
DROP INDEX IF EXISTS storage.vector_indexes_name_bucket_id_idx;
DROP INDEX IF EXISTS storage.name_prefix_search;
DROP INDEX IF EXISTS storage.idx_objects_bucket_id_name_lower;
DROP INDEX IF EXISTS storage.idx_objects_bucket_id_name;
DROP INDEX IF EXISTS storage.idx_multipart_uploads_list;
DROP INDEX IF EXISTS storage.buckets_analytics_unique_name_idx;
DROP INDEX IF EXISTS storage.bucketid_objname;
DROP INDEX IF EXISTS storage.bname;
DROP INDEX IF EXISTS realtime.subscription_subscription_id_entity_filters_action_filter_selec;
DROP INDEX IF EXISTS realtime.messages_inserted_at_topic_index;
DROP INDEX IF EXISTS realtime.ix_realtime_subscription_entity;
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
DROP INDEX IF EXISTS auth.webauthn_credentials_user_id_idx;
DROP INDEX IF EXISTS auth.webauthn_credentials_credential_id_key;
DROP INDEX IF EXISTS auth.webauthn_challenges_user_id_idx;
DROP INDEX IF EXISTS auth.webauthn_challenges_expires_at_idx;
DROP INDEX IF EXISTS auth.users_is_anonymous_idx;
DROP INDEX IF EXISTS auth.users_instance_id_idx;
DROP INDEX IF EXISTS auth.users_instance_id_email_idx;
DROP INDEX IF EXISTS auth.users_email_partial_key;
DROP INDEX IF EXISTS auth.user_id_created_at_idx;
DROP INDEX IF EXISTS auth.unique_phone_factor_per_user;
DROP INDEX IF EXISTS auth.sso_providers_resource_id_pattern_idx;
DROP INDEX IF EXISTS auth.sso_providers_resource_id_idx;
DROP INDEX IF EXISTS auth.sso_domains_sso_provider_id_idx;
DROP INDEX IF EXISTS auth.sso_domains_domain_idx;
DROP INDEX IF EXISTS auth.sessions_user_id_idx;
DROP INDEX IF EXISTS auth.sessions_oauth_client_id_idx;
DROP INDEX IF EXISTS auth.sessions_not_after_idx;
DROP INDEX IF EXISTS auth.saml_relay_states_sso_provider_id_idx;
DROP INDEX IF EXISTS auth.saml_relay_states_for_email_idx;
DROP INDEX IF EXISTS auth.saml_relay_states_created_at_idx;
DROP INDEX IF EXISTS auth.saml_providers_sso_provider_id_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_updated_at_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_session_id_revoked_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_parent_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_instance_id_user_id_idx;
DROP INDEX IF EXISTS auth.refresh_tokens_instance_id_idx;
DROP INDEX IF EXISTS auth.recovery_token_idx;
DROP INDEX IF EXISTS auth.reauthentication_token_idx;
DROP INDEX IF EXISTS auth.one_time_tokens_user_id_token_type_key;
DROP INDEX IF EXISTS auth.one_time_tokens_token_hash_hash_idx;
DROP INDEX IF EXISTS auth.one_time_tokens_relates_to_hash_idx;
DROP INDEX IF EXISTS auth.oauth_consents_user_order_idx;
DROP INDEX IF EXISTS auth.oauth_consents_active_user_client_idx;
DROP INDEX IF EXISTS auth.oauth_consents_active_client_idx;
DROP INDEX IF EXISTS auth.oauth_clients_deleted_at_idx;
DROP INDEX IF EXISTS auth.oauth_auth_pending_exp_idx;
DROP INDEX IF EXISTS auth.mfa_factors_user_id_idx;
DROP INDEX IF EXISTS auth.mfa_factors_user_friendly_name_unique;
DROP INDEX IF EXISTS auth.mfa_challenge_created_at_idx;
DROP INDEX IF EXISTS auth.idx_users_name;
DROP INDEX IF EXISTS auth.idx_users_last_sign_in_at_desc;
DROP INDEX IF EXISTS auth.idx_users_email;
DROP INDEX IF EXISTS auth.idx_users_created_at_desc;
DROP INDEX IF EXISTS auth.idx_user_id_auth_method;
DROP INDEX IF EXISTS auth.idx_oauth_client_states_created_at;
DROP INDEX IF EXISTS auth.idx_auth_code;
DROP INDEX IF EXISTS auth.identities_user_id_idx;
DROP INDEX IF EXISTS auth.identities_email_idx;
DROP INDEX IF EXISTS auth.flow_state_created_at_idx;
DROP INDEX IF EXISTS auth.factor_id_created_at_idx;
DROP INDEX IF EXISTS auth.email_change_token_new_idx;
DROP INDEX IF EXISTS auth.email_change_token_current_idx;
DROP INDEX IF EXISTS auth.custom_oauth_providers_provider_type_idx;
DROP INDEX IF EXISTS auth.custom_oauth_providers_identifier_idx;
DROP INDEX IF EXISTS auth.custom_oauth_providers_enabled_idx;
DROP INDEX IF EXISTS auth.custom_oauth_providers_created_at_idx;
DROP INDEX IF EXISTS auth.confirmation_token_idx;
DROP INDEX IF EXISTS auth.audit_logs_instance_id_idx;
ALTER TABLE IF EXISTS ONLY storage.vector_indexes DROP CONSTRAINT IF EXISTS vector_indexes_pkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads DROP CONSTRAINT IF EXISTS s3_multipart_uploads_pkey;
ALTER TABLE IF EXISTS ONLY storage.s3_multipart_uploads_parts DROP CONSTRAINT IF EXISTS s3_multipart_uploads_parts_pkey;
ALTER TABLE IF EXISTS ONLY storage.objects DROP CONSTRAINT IF EXISTS objects_pkey;
ALTER TABLE IF EXISTS ONLY storage.migrations DROP CONSTRAINT IF EXISTS migrations_pkey;
ALTER TABLE IF EXISTS ONLY storage.migrations DROP CONSTRAINT IF EXISTS migrations_name_key;
ALTER TABLE IF EXISTS ONLY storage.buckets_vectors DROP CONSTRAINT IF EXISTS buckets_vectors_pkey;
ALTER TABLE IF EXISTS ONLY storage.buckets DROP CONSTRAINT IF EXISTS buckets_pkey;
ALTER TABLE IF EXISTS ONLY storage.buckets_analytics DROP CONSTRAINT IF EXISTS buckets_analytics_pkey;
ALTER TABLE IF EXISTS ONLY realtime.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY realtime.subscription DROP CONSTRAINT IF EXISTS pk_subscription;
ALTER TABLE IF EXISTS ONLY realtime.messages DROP CONSTRAINT IF EXISTS messages_pkey;
ALTER TABLE IF EXISTS realtime.messages DROP CONSTRAINT IF EXISTS messages_payload_exclusive;
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
ALTER TABLE IF EXISTS ONLY auth.webauthn_credentials DROP CONSTRAINT IF EXISTS webauthn_credentials_pkey;
ALTER TABLE IF EXISTS ONLY auth.webauthn_challenges DROP CONSTRAINT IF EXISTS webauthn_challenges_pkey;
ALTER TABLE IF EXISTS ONLY auth.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY auth.users DROP CONSTRAINT IF EXISTS users_phone_key;
ALTER TABLE IF EXISTS ONLY auth.sso_providers DROP CONSTRAINT IF EXISTS sso_providers_pkey;
ALTER TABLE IF EXISTS ONLY auth.sso_domains DROP CONSTRAINT IF EXISTS sso_domains_pkey;
ALTER TABLE IF EXISTS ONLY auth.sessions DROP CONSTRAINT IF EXISTS sessions_pkey;
ALTER TABLE IF EXISTS ONLY auth.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY auth.saml_relay_states DROP CONSTRAINT IF EXISTS saml_relay_states_pkey;
ALTER TABLE IF EXISTS ONLY auth.saml_providers DROP CONSTRAINT IF EXISTS saml_providers_pkey;
ALTER TABLE IF EXISTS ONLY auth.saml_providers DROP CONSTRAINT IF EXISTS saml_providers_entity_id_key;
ALTER TABLE IF EXISTS ONLY auth.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_token_unique;
ALTER TABLE IF EXISTS ONLY auth.refresh_tokens DROP CONSTRAINT IF EXISTS refresh_tokens_pkey;
ALTER TABLE IF EXISTS ONLY auth.one_time_tokens DROP CONSTRAINT IF EXISTS one_time_tokens_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_user_client_unique;
ALTER TABLE IF EXISTS ONLY auth.oauth_consents DROP CONSTRAINT IF EXISTS oauth_consents_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_clients DROP CONSTRAINT IF EXISTS oauth_clients_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_client_states DROP CONSTRAINT IF EXISTS oauth_client_states_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_pkey;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_authorization_id_key;
ALTER TABLE IF EXISTS ONLY auth.oauth_authorizations DROP CONSTRAINT IF EXISTS oauth_authorizations_authorization_code_key;
ALTER TABLE IF EXISTS ONLY auth.mfa_factors DROP CONSTRAINT IF EXISTS mfa_factors_pkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_factors DROP CONSTRAINT IF EXISTS mfa_factors_last_challenged_at_key;
ALTER TABLE IF EXISTS ONLY auth.mfa_challenges DROP CONSTRAINT IF EXISTS mfa_challenges_pkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_amr_claims DROP CONSTRAINT IF EXISTS mfa_amr_claims_session_id_authentication_method_pkey;
ALTER TABLE IF EXISTS ONLY auth.instances DROP CONSTRAINT IF EXISTS instances_pkey;
ALTER TABLE IF EXISTS ONLY auth.identities DROP CONSTRAINT IF EXISTS identities_provider_id_provider_unique;
ALTER TABLE IF EXISTS ONLY auth.identities DROP CONSTRAINT IF EXISTS identities_pkey;
ALTER TABLE IF EXISTS ONLY auth.flow_state DROP CONSTRAINT IF EXISTS flow_state_pkey;
ALTER TABLE IF EXISTS ONLY auth.custom_oauth_providers DROP CONSTRAINT IF EXISTS custom_oauth_providers_pkey;
ALTER TABLE IF EXISTS ONLY auth.custom_oauth_providers DROP CONSTRAINT IF EXISTS custom_oauth_providers_identifier_key;
ALTER TABLE IF EXISTS ONLY auth.audit_log_entries DROP CONSTRAINT IF EXISTS audit_log_entries_pkey;
ALTER TABLE IF EXISTS ONLY auth.mfa_amr_claims DROP CONSTRAINT IF EXISTS amr_id_pk;
ALTER TABLE IF EXISTS auth.refresh_tokens ALTER COLUMN id DROP DEFAULT;
DROP TABLE IF EXISTS storage.vector_indexes;
DROP TABLE IF EXISTS storage.s3_multipart_uploads_parts;
DROP TABLE IF EXISTS storage.s3_multipart_uploads;
DROP TABLE IF EXISTS storage.objects;
DROP TABLE IF EXISTS storage.migrations;
DROP TABLE IF EXISTS storage.buckets_vectors;
DROP TABLE IF EXISTS storage.buckets_analytics;
DROP TABLE IF EXISTS storage.buckets;
DROP TABLE IF EXISTS realtime.subscription;
DROP TABLE IF EXISTS realtime.schema_migrations;
DROP TABLE IF EXISTS realtime.messages;
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
DROP TABLE IF EXISTS auth.webauthn_credentials;
DROP TABLE IF EXISTS auth.webauthn_challenges;
DROP TABLE IF EXISTS auth.users;
DROP TABLE IF EXISTS auth.sso_providers;
DROP TABLE IF EXISTS auth.sso_domains;
DROP TABLE IF EXISTS auth.sessions;
DROP TABLE IF EXISTS auth.schema_migrations;
DROP TABLE IF EXISTS auth.saml_relay_states;
DROP TABLE IF EXISTS auth.saml_providers;
DROP SEQUENCE IF EXISTS auth.refresh_tokens_id_seq;
DROP TABLE IF EXISTS auth.refresh_tokens;
DROP TABLE IF EXISTS auth.one_time_tokens;
DROP TABLE IF EXISTS auth.oauth_consents;
DROP TABLE IF EXISTS auth.oauth_clients;
DROP TABLE IF EXISTS auth.oauth_client_states;
DROP TABLE IF EXISTS auth.oauth_authorizations;
DROP TABLE IF EXISTS auth.mfa_factors;
DROP TABLE IF EXISTS auth.mfa_challenges;
DROP TABLE IF EXISTS auth.mfa_amr_claims;
DROP TABLE IF EXISTS auth.instances;
DROP TABLE IF EXISTS auth.identities;
DROP TABLE IF EXISTS auth.flow_state;
DROP TABLE IF EXISTS auth.custom_oauth_providers;
DROP TABLE IF EXISTS auth.audit_log_entries;
DROP FUNCTION IF EXISTS storage.update_updated_at_column();
DROP FUNCTION IF EXISTS storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text, sort_order text, sort_column text, sort_column_after text);
DROP FUNCTION IF EXISTS storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text);
DROP FUNCTION IF EXISTS storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text);
DROP FUNCTION IF EXISTS storage.protect_delete();
DROP FUNCTION IF EXISTS storage.operation();
DROP FUNCTION IF EXISTS storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text, sort_order text);
DROP FUNCTION IF EXISTS storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text);
DROP FUNCTION IF EXISTS storage.get_size_by_bucket();
DROP FUNCTION IF EXISTS storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text);
DROP FUNCTION IF EXISTS storage.foldername(name text);
DROP FUNCTION IF EXISTS storage.filename(name text);
DROP FUNCTION IF EXISTS storage.extension(name text);
DROP FUNCTION IF EXISTS storage.enforce_bucket_name_length();
DROP FUNCTION IF EXISTS storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb);
DROP FUNCTION IF EXISTS storage.allow_only_operation(expected_operation text);
DROP FUNCTION IF EXISTS storage.allow_any_operation(expected_operations text[]);
DROP FUNCTION IF EXISTS realtime.wal2json_escape_identifier(name text);
DROP FUNCTION IF EXISTS realtime.topic();
DROP FUNCTION IF EXISTS realtime.to_regrole(role_name text);
DROP FUNCTION IF EXISTS realtime.subscription_check_filters();
DROP FUNCTION IF EXISTS realtime.send_binary(payload bytea, event text, topic text, private boolean);
DROP FUNCTION IF EXISTS realtime.send(payload jsonb, event text, topic text, private boolean);
DROP FUNCTION IF EXISTS realtime.quote_wal2json(entity regclass);
DROP FUNCTION IF EXISTS realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer);
DROP FUNCTION IF EXISTS realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]);
DROP FUNCTION IF EXISTS realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean);
DROP FUNCTION IF EXISTS realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text);
DROP FUNCTION IF EXISTS realtime."cast"(val text, type_ regtype);
DROP FUNCTION IF EXISTS realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]);
DROP FUNCTION IF EXISTS realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text);
DROP FUNCTION IF EXISTS realtime.apply_rls(wal jsonb, max_record_bytes integer);
DROP FUNCTION IF EXISTS pgbouncer.get_auth(p_usename text);
DROP FUNCTION IF EXISTS graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb);
DROP FUNCTION IF EXISTS extensions.set_graphql_placeholder();
DROP FUNCTION IF EXISTS extensions.pgrst_drop_watch();
DROP FUNCTION IF EXISTS extensions.pgrst_ddl_watch();
DROP FUNCTION IF EXISTS extensions.grant_pg_net_access();
DROP FUNCTION IF EXISTS extensions.grant_pg_graphql_access();
DROP FUNCTION IF EXISTS extensions.grant_pg_cron_access();
DROP FUNCTION IF EXISTS auth.uid();
DROP FUNCTION IF EXISTS auth.role();
DROP FUNCTION IF EXISTS auth.jwt();
DROP FUNCTION IF EXISTS auth.email();
DROP TYPE IF EXISTS storage.buckettype;
DROP TYPE IF EXISTS realtime.wal_rls;
DROP TYPE IF EXISTS realtime.wal_column;
DROP TYPE IF EXISTS realtime.user_defined_filter;
DROP TYPE IF EXISTS realtime.equality_op;
DROP TYPE IF EXISTS realtime.action;
DROP TYPE IF EXISTS auth.one_time_token_type;
DROP TYPE IF EXISTS auth.oauth_response_type;
DROP TYPE IF EXISTS auth.oauth_registration_type;
DROP TYPE IF EXISTS auth.oauth_client_type;
DROP TYPE IF EXISTS auth.oauth_authorization_status;
DROP TYPE IF EXISTS auth.factor_type;
DROP TYPE IF EXISTS auth.factor_status;
DROP TYPE IF EXISTS auth.code_challenge_method;
DROP TYPE IF EXISTS auth.aal_level;
DROP EXTENSION IF EXISTS "uuid-ossp";
DROP EXTENSION IF EXISTS supabase_vault;
DROP EXTENSION IF EXISTS pgcrypto;
DROP EXTENSION IF EXISTS pg_stat_statements;
DROP SCHEMA IF EXISTS vault;
DROP SCHEMA IF EXISTS storage;
DROP SCHEMA IF EXISTS realtime;
DROP SCHEMA IF EXISTS pgbouncer;
DROP SCHEMA IF EXISTS graphql_public;
DROP SCHEMA IF EXISTS graphql;
DROP SCHEMA IF EXISTS extensions;
DROP SCHEMA IF EXISTS auth;
--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA auth;


--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA extensions;


--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql;


--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA graphql_public;


--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA pgbouncer;


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA realtime;


--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA storage;


--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA vault;


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


--
-- Name: oauth_authorization_status; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_authorization_status AS ENUM (
    'pending',
    'approved',
    'denied',
    'expired'
);


--
-- Name: oauth_client_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_client_type AS ENUM (
    'public',
    'confidential'
);


--
-- Name: oauth_registration_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_registration_type AS ENUM (
    'dynamic',
    'manual'
);


--
-- Name: oauth_response_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.oauth_response_type AS ENUM (
    'code'
);


--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: -
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


--
-- Name: action; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in',
    'like',
    'ilike',
    'is',
    'match',
    'imatch',
    'isdistinct'
);


--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text,
	negate boolean
);


--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: -
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


--
-- Name: buckettype; Type: TYPE; Schema: storage; Owner: -
--

CREATE TYPE storage.buckettype AS ENUM (
    'STANDARD',
    'ANALYTICS',
    'VECTOR'
);


--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: -
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
begin
    if not exists (
        select 1
        from pg_event_trigger_ddl_commands() ev
        join pg_catalog.pg_extension e on ev.objid = e.oid
        where e.extname = 'pg_graphql'
    ) then
        return;
    end if;

    drop function if exists graphql_public.graphql;
    create or replace function graphql_public.graphql(
        "operationName" text default null,
        query text default null,
        variables jsonb default null,
        extensions jsonb default null
    )
        returns jsonb
        language sql
    as $$
        select graphql.resolve(
            query := query,
            variables := coalesce(variables, '{}'),
            "operationName" := "operationName",
            extensions := extensions
        );
    $$;

    -- Attach the wrapper to the extension so DROP EXTENSION cascades to it,
    -- which in turn triggers set_graphql_placeholder to reinstall the "not enabled" stub.
    alter extension pg_graphql add function graphql_public.graphql(text, text, jsonb, jsonb);

    grant usage on schema graphql to postgres, anon, authenticated, service_role;
    grant execute on function graphql.resolve to postgres, anon, authenticated, service_role;
    grant usage on schema graphql to postgres with grant option;
    grant usage on schema graphql_public to postgres with grant option;
end;
$_$;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: -
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: -
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: graphql(text, text, jsonb, jsonb); Type: FUNCTION; Schema: graphql_public; Owner: -
--

CREATE FUNCTION graphql_public.graphql("operationName" text DEFAULT NULL::text, query text DEFAULT NULL::text, variables jsonb DEFAULT NULL::jsonb, extensions jsonb DEFAULT NULL::jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: -
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO ''
    AS $_$
  BEGIN
      RAISE DEBUG 'PgBouncer auth request: %', p_usename;

      RETURN QUERY
      SELECT
          rolname::text,
          CASE WHEN rolvaliduntil < now()
              THEN null
              ELSE rolpassword::text
          END
      FROM pg_authid
      WHERE rolname=$1 and rolcanlogin;
  END;
  $_$;


--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
    -- Regclass of the table e.g. public.notes
    entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

    -- I, U, D, T: insert, update ...
    action realtime.action = (
        case wal ->> 'action'
            when 'I' then 'INSERT'
            when 'U' then 'UPDATE'
            when 'D' then 'DELETE'
            else 'ERROR'
        end
    );

    -- Is row level security enabled for the table
    is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

    subscriptions realtime.subscription[] = array_agg(subs)
        from
            realtime.subscription subs
        where
            subs.entity = entity_
            -- Filter by action early - only get subscriptions interested in this action
            -- action_filter column can be: '*' (all), 'INSERT', 'UPDATE', or 'DELETE'
            and (subs.action_filter = '*' or subs.action_filter = action::text);

    -- Subscription vars
    working_role regrole;
    working_selected_columns text[];
    claimed_role regrole;
    claims jsonb;

    subscription_id uuid;
    subscription_has_access bool;
    visible_to_subscription_ids uuid[] = '{}';

    -- structured info for wal's columns
    columns realtime.wal_column[];
    -- previous identity values for update/delete
    old_columns realtime.wal_column[];

    error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

    -- Primary jsonb output for record
    output jsonb;

    -- Loop record for iterating unique roles (outer loop)
    role_record record;
    -- Loop record for iterating unique selected_columns within a role (inner loop)
    cols_record record;
    -- Subscription ids visible at the role level (before fanning out by selected_columns)
    visible_role_sub_ids uuid[] = '{}';

begin
    perform set_config('role', null, true);

    columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'columns') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    old_columns =
        array_agg(
            (
                x->>'name',
                x->>'type',
                x->>'typeoid',
                realtime.cast(
                    (x->'value') #>> '{}',
                    coalesce(
                        (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                        (x->>'type')::regtype
                    )
                ),
                (pks ->> 'name') is not null,
                true
            )::realtime.wal_column
        )
        from
            jsonb_array_elements(wal -> 'identity') x
            left join jsonb_array_elements(wal -> 'pk') pks
                on (x ->> 'name') = (pks ->> 'name');

    for role_record in
        select claims_role
        from (select distinct claims_role from unnest(subscriptions)) t
        order by claims_role::text
    loop
        working_role := role_record.claims_role;

        -- Update `is_selectable` for columns and old_columns (once per role)
        columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(columns) c;

        old_columns =
                array_agg(
                    (
                        c.name,
                        c.type_name,
                        c.type_oid,
                        c.value,
                        c.is_pkey,
                        pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                    )::realtime.wal_column
                )
                from
                    unnest(old_columns) c;

        if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
            -- Fan out 400 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 400: Bad Request, no primary key']
                )::realtime.wal_rls;
            end loop;

        -- The claims role does not have SELECT permission to the primary key of entity
        elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
            -- Fan out 401 error per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;
                return next (
                    jsonb_build_object(
                        'schema', wal ->> 'schema',
                        'table', wal ->> 'table',
                        'type', action
                    ),
                    is_rls_enabled,
                    (select array_agg(s.subscription_id) from unnest(subscriptions) as s where s.claims_role = working_role and (s.selected_columns is not distinct from working_selected_columns)),
                    array['Error 401: Unauthorized']
                )::realtime.wal_rls;
            end loop;

        else
            -- Create the prepared statement (once per role)
            if is_rls_enabled and action <> 'DELETE' then
                if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                    deallocate walrus_rls_stmt;
                end if;
                execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
            end if;

            -- Collect all visible subscription IDs for this role (filter check + RLS check)
            visible_role_sub_ids = '{}';

            for subscription_id, claims in (
                    select
                        subs.subscription_id,
                        subs.claims
                    from
                        unnest(subscriptions) subs
                    where
                        subs.entity = entity_
                        and subs.claims_role = working_role
                        and (
                            realtime.is_visible_through_filters(columns, subs.filters)
                            or (
                              action = 'DELETE'
                              and realtime.is_visible_through_filters(old_columns, subs.filters)
                            )
                        )
            ) loop

                if not is_rls_enabled or action = 'DELETE' then
                    visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                else
                    -- Check if RLS allows the role to see the record
                    perform
                        -- Trim leading and trailing quotes from working_role because set_config
                        -- doesn't recognize the role as valid if they are included
                        set_config('role', trim(both '"' from working_role::text), true),
                        set_config('request.jwt.claims', claims::text, true);

                    execute 'execute walrus_rls_stmt' into subscription_has_access;

                    -- Reset the role on every FOR..LOOP batch execution.
                    -- The first batch of 10 rows is pre-fetched using the current connection role (PG internal behaviour)
                    -- then we have to reset it again otherwise it would use the role defined in the `set_config` above
                    -- to fetch the remaining rows when rows>10, which could be a user-defined role that lacks execution grants.
                    -- The flow is:
                    --   1. run batch with conn role
                    --   2. set_config working_role
                    --   3. execute walrus
                    --   4. reset role (revert)
                    --   5. repeat
                    perform set_config('role', null, true);

                    if subscription_has_access then
                        visible_role_sub_ids = visible_role_sub_ids || subscription_id;
                    end if;
                end if;
            end loop;

            perform set_config('role', null, true);

            -- Inner loop: per distinct selected_columns for this role
            for cols_record in
                select selected_columns
                from (select distinct selected_columns from unnest(subscriptions) s where s.claims_role = working_role) t
                order by coalesce(array_to_string(selected_columns, ','), '')
            loop
                working_selected_columns := cols_record.selected_columns;

                output = jsonb_build_object(
                    'schema', wal ->> 'schema',
                    'table', wal ->> 'table',
                    'type', action,
                    'commit_timestamp', to_char(
                        ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                        'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
                    ),
                    'columns', (
                        select
                            jsonb_agg(
                                jsonb_build_object(
                                    'name', pa.attname,
                                    'type', pt.typname
                                )
                                order by pa.attnum asc
                            )
                        from
                            pg_attribute pa
                            join pg_type pt
                                on pa.atttypid = pt.oid
                            left join (
                                select unnest(conkey) as pkey_attnum
                                from pg_constraint
                                where conrelid = entity_ and contype = 'p'
                            ) pk on pk.pkey_attnum = pa.attnum
                        where
                            attrelid = entity_
                            and attnum > 0
                            and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
                            and (working_selected_columns is null or pa.attname = any(working_selected_columns) or pk.pkey_attnum is not null)
                    )
                )
                -- Add "record" key for insert and update
                || case
                    when action in ('INSERT', 'UPDATE') then
                        jsonb_build_object(
                            'record',
                            (
                                select
                                    jsonb_object_agg(
                                        -- if unchanged toast, get column name and value from old record
                                        coalesce((c).name, (oc).name),
                                        case
                                            when (c).name is null then (oc).value
                                            else (c).value
                                        end
                                    )
                                from
                                    unnest(columns) c
                                    full outer join unnest(old_columns) oc
                                        on (c).name = (oc).name
                                where
                                    coalesce((c).is_selectable, (oc).is_selectable)
                                    and (working_selected_columns is null or coalesce((c).name, (oc).name) = any(working_selected_columns) or coalesce((c).is_pkey, (oc).is_pkey))
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            )
                        )
                    else '{}'::jsonb
                end
                -- Add "old_record" key for update and delete
                || case
                    when action = 'UPDATE' then
                        jsonb_build_object(
                                'old_record',
                                (
                                    select jsonb_object_agg((c).name, (c).value)
                                    from unnest(old_columns) c
                                    where
                                        (c).is_selectable
                                        and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                        and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                )
                            )
                    when action = 'DELETE' then
                        jsonb_build_object(
                            'old_record',
                            (
                                select jsonb_object_agg((c).name, (c).value)
                                from unnest(old_columns) c
                                where
                                    (c).is_selectable
                                    and (working_selected_columns is null or (c).name = any(working_selected_columns) or (c).is_pkey)
                                    and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                                    and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                            )
                        )
                    else '{}'::jsonb
                end;

                -- Filter visible_role_sub_ids to those matching the current selected_columns group
                visible_to_subscription_ids = coalesce(
                    (
                        select array_agg(s.subscription_id)
                        from unnest(subscriptions) s
                        where s.claims_role = working_role
                          and (s.selected_columns is not distinct from working_selected_columns)
                          and s.subscription_id = any(visible_role_sub_ids)
                    ),
                    '{}'::uuid[]
                );

                return next (
                    output,
                    is_rls_enabled,
                    visible_to_subscription_ids,
                    case
                        when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                        else '{}'
                    end
                )::realtime.wal_rls;
            end loop;

        end if;
    end loop;

    perform set_config('role', null, true);
end;
$$;


--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
declare
  res jsonb;
begin
  if type_::text = 'bytea' then
    return to_jsonb(val);
  end if;
  execute format('select to_jsonb(%L::'|| type_::text || ')', val) into res;
  return res;
end
$$;


--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
/*
Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
*/
declare
    op_symbol text = (
        case
            when op = 'eq' then '='
            when op = 'neq' then '!='
            when op = 'lt' then '<'
            when op = 'lte' then '<='
            when op = 'gt' then '>'
            when op = 'gte' then '>='
            when op = 'in' then '= any'
            else 'UNKNOWN OP'
        end
    );
    res boolean;
begin
    execute format(
        'select %L::'|| type_::text || ' ' || op_symbol
        || ' ( %L::'
        || (
            case
                when op = 'in' then type_::text || '[]'
                else type_::text end
        )
        || ')', val_1, val_2) into res;
    return res;
end;
$$;


--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text, negate boolean) RETURNS boolean
    LANGUAGE plpgsql STABLE
    AS $$
declare
    op_symbol text;
    res boolean;
begin
    -- IS DISTINCT FROM / IS NOT DISTINCT FROM: infix, both sides typed literals
    if op = 'isdistinct' then
        execute format(
            'select %L::%s %s %L::%s',
            val_1,
            type_::text,
            case when negate then 'IS NOT DISTINCT FROM' else 'IS DISTINCT FROM' end,
            val_2,
            type_::text
        ) into res;
        return res;
    end if;

    -- IS requires a keyword RHS (NULL, TRUE, FALSE, UNKNOWN), not a typed literal
    if op = 'is' then
        if val_2 not in ('null', 'true', 'false', 'unknown') then
            raise exception 'invalid value for is filter: must be null, true, false, or unknown';
        end if;
        execute format(
            'select %L::%s %s %s',
            val_1,
            type_::text,
            case when negate then 'IS NOT' else 'IS' end,
            upper(val_2)
        ) into res;
        return res;
    end if;

    op_symbol = case
        when op = 'eq'    then '='
        when op = 'neq'   then '!='
        when op = 'lt'    then '<'
        when op = 'lte'   then '<='
        when op = 'gt'    then '>'
        when op = 'gte'   then '>='
        when op = 'in'    then '= any'
        when op = 'like'   then 'LIKE'
        when op = 'ilike'  then 'ILIKE'
        when op = 'match'  then '~'
        when op = 'imatch' then '~*'
        else null
    end;

    if op_symbol is null then
        raise exception 'unsupported equality operator: %', op::text;
    end if;

    execute format(
        'select %L::%s %s (%L::%s)',
        val_1,
        type_::text,
        op_symbol,
        val_2,
        case when op = 'in' then type_::text || '[]' else type_::text end
    ) into res;

    return case when negate then not res else res end;
end;
$$;


--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
    select
        filters is null
        or array_length(filters, 1) is null
        or coalesce(
            count(col.name) = count(1)
            and sum(
                realtime.check_equality_op(
                    op:=f.op,
                    type_:=coalesce(col.type_oid::regtype, col.type_name::regtype),
                    val_1:=col.value #>> '{}',
                    val_2:=f.value,
                    negate:=coalesce(f.negate, false)
                )::int
            ) filter (where col.name is not null) = count(col.name),
            false
        )
    from
        unnest(filters) f
        left join unnest(columns) col
            on f.column_name = col.name;
$$;


--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS TABLE(wal jsonb, is_rls_enabled boolean, subscription_ids uuid[], errors text[], slot_changes_count bigint)
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
  WITH pub AS (
    SELECT
      concat_ws(
        ',',
        CASE WHEN bool_or(pubinsert) THEN 'insert' ELSE NULL END,
        CASE WHEN bool_or(pubupdate) THEN 'update' ELSE NULL END,
        CASE WHEN bool_or(pubdelete) THEN 'delete' ELSE NULL END
      ) AS w2j_actions,
      coalesce(
        string_agg(
          realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
          ','
        ) filter (WHERE ppt.tablename IS NOT NULL),
        ''
      ) AS w2j_add_tables
    FROM pg_publication pp
    LEFT JOIN pg_publication_tables ppt ON pp.pubname = ppt.pubname
    WHERE pp.pubname = publication
    GROUP BY pp.pubname
    LIMIT 1
  ),
  -- MATERIALIZED ensures pg_logical_slot_get_changes is called exactly once
  w2j AS MATERIALIZED (
    SELECT x.*, pub.w2j_add_tables
    FROM pub,
         pg_logical_slot_get_changes(
           slot_name, null, max_changes,
           'include-pk', 'true',
           'include-transaction', 'false',
           'include-timestamp', 'true',
           'include-type-oids', 'true',
           'format-version', '2',
           'actions', pub.w2j_actions,
           'add-tables', pub.w2j_add_tables
         ) x
  ),
  slot_count AS (
    SELECT count(*)::bigint AS cnt
    FROM w2j
    WHERE w2j.w2j_add_tables <> ''
  ),
  rls_filtered AS (
    SELECT xyz.wal, xyz.is_rls_enabled, xyz.subscription_ids, xyz.errors
    FROM w2j,
         realtime.apply_rls(
           wal := w2j.data::jsonb,
           max_record_bytes := max_record_bytes
         ) xyz(wal, is_rls_enabled, subscription_ids, errors)
    WHERE w2j.w2j_add_tables <> ''
      AND xyz.subscription_ids[1] IS NOT NULL
  )
  SELECT rf.wal, rf.is_rls_enabled, rf.subscription_ids, rf.errors, sc.cnt
  FROM rls_filtered rf, slot_count sc

  UNION ALL

  SELECT null, null, null, null, sc.cnt
  FROM slot_count sc
  WHERE NOT EXISTS (SELECT 1 FROM rls_filtered)
$$;


--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  SELECT
    realtime.wal2json_escape_identifier(nsp.nspname::text)
    || '.'
    || realtime.wal2json_escape_identifier(pc.relname::text)
  FROM pg_class pc
  JOIN pg_namespace nsp ON pc.relnamespace = nsp.oid
  WHERE pc.oid = entity
$$;


--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
  final_payload jsonb;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    -- Check if payload has an 'id' key, if not, add the generated UUID
    IF payload ? 'id' THEN
      final_payload := payload;
    ELSE
      final_payload := jsonb_set(payload, '{id}', to_jsonb(generated_id));
    END IF;

    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, payload, event, topic, private, extension)
    VALUES (generated_id, final_payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'WarnSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


--
-- Name: send_binary(bytea, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.send_binary(payload bytea, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
  generated_id uuid;
BEGIN
  BEGIN
    generated_id := gen_random_uuid();

    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    INSERT INTO realtime.messages (id, binary_payload, event, topic, private, extension)
    VALUES (generated_id, payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      RAISE WARNING 'WarnSendingBroadcastMessage: %', SQLERRM;
  END;
END;
$$;


--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
declare
    col_names text[] = coalesce(
            array_agg(a.attname order by a.attnum),
            '{}'::text[]
        )
        from
            pg_catalog.pg_attribute a
        where
            a.attrelid = new.entity
            and a.attnum > 0
            and not a.attisdropped
            and pg_catalog.has_column_privilege(
                (new.claims ->> 'role'),
                a.attrelid,
                a.attnum,
                'SELECT'
            );
    filter realtime.user_defined_filter;
    col_type regtype;
    in_val jsonb;
    selected_col text;
begin
    for filter in select * from unnest(new.filters) loop
        if not filter.column_name = any(col_names) then
            raise exception 'invalid column for filter %', filter.column_name;
        end if;

        col_type = (
            select atttypid::regtype
            from pg_catalog.pg_attribute
            where attrelid = new.entity
                  and attname = filter.column_name
        );
        if col_type is null then
            raise exception 'failed to lookup type for column %', filter.column_name;
        end if;

        if filter.op = 'in'::realtime.equality_op then
            in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
            if coalesce(jsonb_array_length(in_val), 0) > 100 then
                raise exception 'too many values for `in` filter. Maximum 100';
            end if;
        elsif filter.op = 'is'::realtime.equality_op then
            -- `is` requires a keyword RHS rather than a typed literal
            if filter.value not in ('null', 'true', 'false', 'unknown') then
                raise exception 'invalid value for is filter: must be null, true, false, or unknown';
            end if;
            -- IS NULL works for any type, but IS TRUE/FALSE/UNKNOWN require a boolean
            -- operand. Reject the non-null keywords on non-boolean columns here so they
            -- don't abort apply_rls at WAL time.
            if filter.value <> 'null' and col_type <> 'boolean'::regtype then
                raise exception 'is % filter requires a boolean column, got %', filter.value, col_type::text;
            end if;
        elsif filter.op in ('like'::realtime.equality_op, 'ilike'::realtime.equality_op) then
            -- like/ilike apply the text pattern operator (~~); reject column types that
            -- have no such operator instead of failing at WAL time
            if not exists (
                select 1 from pg_catalog.pg_operator
                where oprname = '~~' and oprleft = col_type
            ) then
                raise exception 'operator % requires a text-compatible column type, got %', filter.op::text, col_type::text;
            end if;
        elsif filter.op in ('match'::realtime.equality_op, 'imatch'::realtime.equality_op) then
            -- match/imatch apply the regex operators ~ / ~*; reject column types that have
            -- no such operator (e.g. integer) instead of failing at WAL time, mirroring the
            -- like/ilike guard above.
            if not exists (
                select 1 from pg_catalog.pg_operator
                where oprname = case when filter.op = 'imatch'::realtime.equality_op then '~*' else '~' end
                  and oprleft = col_type
                  and oprright = col_type
                  and oprresult = 'boolean'::regtype
            ) then
                raise exception 'operator % requires a text-compatible column type, got %', filter.op::text, col_type::text;
            end if;
            -- validate the regex eagerly so a bad pattern is rejected here, not inside
            -- apply_rls where it would abort the WAL stream for the entity
            begin
                perform '' ~ filter.value;
            exception when others then
                raise exception 'invalid regular expression for % filter: %', filter.op::text, sqlerrm;
            end;
        else
            -- eq/neq/lt/lte/gt/gte: value must be coercable to the type
            perform realtime.cast(filter.value, col_type);
        end if;
    end loop;

    if new.selected_columns is not null then
        for selected_col in select * from unnest(new.selected_columns) loop
            if not selected_col = any(col_names) then
                raise exception 'invalid column for select %', selected_col;
            end if;
        end loop;
    end if;

    -- Apply consistent order to filters so the unique constraint can't be tricked by a
    -- different filter order. negate is part of the sort key.
    new.filters = coalesce(
        array_agg(f order by f.column_name, f.op, f.value, f.negate),
        '{}'
    ) from unnest(new.filters) f;

    new.selected_columns = (
        select array_agg(c order by c)
        from unnest(new.selected_columns) c
    );

    return new;
end;
$$;


--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


--
-- Name: wal2json_escape_identifier(text); Type: FUNCTION; Schema: realtime; Owner: -
--

CREATE FUNCTION realtime.wal2json_escape_identifier(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
  -- Prefix `\`, `,`, `.`, and any whitespace with `\`
  SELECT regexp_replace(name, '([\\,.[:space:]])', '\\\1', 'g')
$$;


--
-- Name: allow_any_operation(text[]); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.allow_any_operation(expected_operations text[]) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT CASE
      WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
      ELSE raw_operation
    END AS current_operation
    FROM current_operation
  )
  SELECT EXISTS (
    SELECT 1
    FROM normalized n
    CROSS JOIN LATERAL unnest(expected_operations) AS expected_operation
    WHERE expected_operation IS NOT NULL
      AND expected_operation <> ''
      AND n.current_operation = CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END
  );
$$;


--
-- Name: allow_only_operation(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.allow_only_operation(expected_operation text) RETURNS boolean
    LANGUAGE sql STABLE
    AS $$
  WITH current_operation AS (
    SELECT storage.operation() AS raw_operation
  ),
  normalized AS (
    SELECT
      CASE
        WHEN raw_operation LIKE 'storage.%' THEN substr(raw_operation, 9)
        ELSE raw_operation
      END AS current_operation,
      CASE
        WHEN expected_operation LIKE 'storage.%' THEN substr(expected_operation, 9)
        ELSE expected_operation
      END AS requested_operation
    FROM current_operation
  )
  SELECT CASE
    WHEN requested_operation IS NULL OR requested_operation = '' THEN FALSE
    ELSE COALESCE(current_operation = requested_operation, FALSE)
  END
  FROM normalized;
$$;


--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


--
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Get the last path segment (the actual filename)
    SELECT _parts[array_length(_parts, 1)] INTO _filename;
    -- Extract extension: reverse, split on '.', then reverse again
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


--
-- Name: get_common_prefix(text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_common_prefix(p_key text, p_prefix text, p_delimiter text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS $$
SELECT CASE
    WHEN position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)) > 0
    THEN left(p_key, length(p_prefix) + position(p_delimiter IN substring(p_key FROM length(p_prefix) + 1)))
    ELSE NULL
END;
$$;


--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint)::bigint as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.list_objects_with_delimiter(_bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;

    -- Configuration
    v_is_asc BOOLEAN;
    v_prefix TEXT;
    v_start TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_is_asc := lower(coalesce(sort_order, 'asc')) = 'asc';
    v_prefix := coalesce(prefix_param, '');
    v_start := CASE WHEN coalesce(next_token, '') <> '' THEN next_token ELSE coalesce(start_after, '') END;
    v_file_batch_size := LEAST(GREATEST(max_keys * 2, 100), 1000);

    -- Calculate upper bound for prefix filtering (bytewise, using COLLATE "C")
    IF v_prefix = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix, 1) = delimiter_param THEN
        v_upper_bound := left(v_prefix, -1) || chr(ascii(delimiter_param) + 1);
    ELSE
        v_upper_bound := left(v_prefix, -1) || chr(ascii(right(v_prefix, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'AND o.name COLLATE "C" < $3 ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" >= $2 ' ||
                'ORDER BY o.name COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'AND o.name COLLATE "C" >= $3 ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND o.name COLLATE "C" < $2 ' ||
                'ORDER BY o.name COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- ========================================================================
    -- SEEK INITIALIZATION: Determine starting position
    -- ========================================================================
    IF v_start = '' THEN
        IF v_is_asc THEN
            v_next_seek := v_prefix;
        ELSE
            -- DESC without cursor: find the last item in range
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_next_seek FROM storage.objects o
                WHERE o.bucket_id = _bucket_id
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;

            IF v_next_seek IS NOT NULL THEN
                v_next_seek := v_next_seek || delimiter_param;
            ELSE
                RETURN;
            END IF;
        END IF;
    ELSE
        -- Cursor provided: determine if it refers to a folder or leaf
        IF EXISTS (
            SELECT 1 FROM storage.objects o
            WHERE o.bucket_id = _bucket_id
              AND o.name COLLATE "C" LIKE v_start || delimiter_param || '%'
            LIMIT 1
        ) THEN
            -- Cursor refers to a folder
            IF v_is_asc THEN
                v_next_seek := v_start || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_start || delimiter_param;
            END IF;
        ELSE
            -- Cursor refers to a leaf object
            IF v_is_asc THEN
                v_next_seek := v_start || delimiter_param;
            ELSE
                v_next_seek := v_start;
            END IF;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= max_keys;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek AND o.name COLLATE "C" < v_upper_bound
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" >= v_next_seek
                ORDER BY o.name COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek AND o.name COLLATE "C" >= v_prefix
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = _bucket_id AND o.name COLLATE "C" < v_next_seek
                ORDER BY o.name COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(v_peek_name, v_prefix, delimiter_param);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Emit and skip to next folder (no heap access needed)
            name := rtrim(v_common_prefix, delimiter_param);
            id := NULL;
            updated_at := NULL;
            created_at := NULL;
            last_accessed_at := NULL;
            metadata := NULL;
            RETURN NEXT;
            v_count := v_count + 1;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := left(v_common_prefix, -1) || chr(ascii(delimiter_param) + 1);
            ELSE
                v_next_seek := v_common_prefix;
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query USING _bucket_id, v_next_seek,
                CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix) ELSE v_prefix END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(v_current.name, v_prefix, delimiter_param);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := v_current.name;
                    EXIT;
                END IF;

                -- Emit file
                name := v_current.name;
                id := v_current.id;
                updated_at := v_current.updated_at;
                created_at := v_current.created_at;
                last_accessed_at := v_current.last_accessed_at;
                metadata := v_current.metadata;
                RETURN NEXT;
                v_count := v_count + 1;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := v_current.name || delimiter_param;
                ELSE
                    v_next_seek := v_current.name;
                END IF;

                EXIT WHEN v_count >= max_keys;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


--
-- Name: protect_delete(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.protect_delete() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if storage.allow_delete_query is set to 'true'
    IF COALESCE(current_setting('storage.allow_delete_query', true), 'false') != 'true' THEN
        RAISE EXCEPTION 'Direct deletion from storage tables is not allowed. Use the Storage API instead.'
            USING HINT = 'This prevents accidental data loss from orphaned objects.',
                  ERRCODE = '42501';
    END IF;
    RETURN NULL;
END;
$$;


--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_peek_name TEXT;
    v_current RECORD;
    v_common_prefix TEXT;
    v_delimiter CONSTANT TEXT := '/';

    -- Configuration
    v_limit INT;
    v_prefix TEXT;
    v_prefix_lower TEXT;
    v_is_asc BOOLEAN;
    v_order_by TEXT;
    v_sort_order TEXT;
    v_upper_bound TEXT;
    v_file_batch_size INT;

    -- Dynamic SQL for batch query only
    v_batch_query TEXT;

    -- Seek state
    v_next_seek TEXT;
    v_count INT := 0;
    v_skipped INT := 0;
BEGIN
    -- ========================================================================
    -- INITIALIZATION
    -- ========================================================================
    v_limit := LEAST(coalesce(limits, 100), 1500);
    v_prefix := coalesce(prefix, '') || coalesce(search, '');
    v_prefix_lower := lower(v_prefix);
    v_is_asc := lower(coalesce(sortorder, 'asc')) = 'asc';
    v_file_batch_size := LEAST(GREATEST(v_limit * 2, 100), 1000);

    -- Validate sort column
    CASE lower(coalesce(sortcolumn, 'name'))
        WHEN 'name' THEN v_order_by := 'name';
        WHEN 'updated_at' THEN v_order_by := 'updated_at';
        WHEN 'created_at' THEN v_order_by := 'created_at';
        WHEN 'last_accessed_at' THEN v_order_by := 'last_accessed_at';
        ELSE v_order_by := 'name';
    END CASE;

    v_sort_order := CASE WHEN v_is_asc THEN 'asc' ELSE 'desc' END;

    -- ========================================================================
    -- NON-NAME SORTING: Use path_tokens approach (unchanged)
    -- ========================================================================
    IF v_order_by != 'name' THEN
        RETURN QUERY EXECUTE format(
            $sql$
            WITH folders AS (
                SELECT path_tokens[$1] AS folder
                FROM storage.objects
                WHERE objects.name ILIKE $2 || '%%'
                  AND bucket_id = $3
                  AND array_length(objects.path_tokens, 1) <> $1
                GROUP BY folder
                ORDER BY folder %s
            )
            (SELECT folder AS "name",
                   NULL::uuid AS id,
                   NULL::timestamptz AS updated_at,
                   NULL::timestamptz AS created_at,
                   NULL::timestamptz AS last_accessed_at,
                   NULL::jsonb AS metadata FROM folders)
            UNION ALL
            (SELECT path_tokens[$1] AS "name",
                   id, updated_at, created_at, last_accessed_at, metadata
             FROM storage.objects
             WHERE objects.name ILIKE $2 || '%%'
               AND bucket_id = $3
               AND array_length(objects.path_tokens, 1) = $1
             ORDER BY %I %s)
            LIMIT $4 OFFSET $5
            $sql$, v_sort_order, v_order_by, v_sort_order
        ) USING levels, v_prefix, bucketname, v_limit, offsets;
        RETURN;
    END IF;

    -- ========================================================================
    -- NAME SORTING: Hybrid skip-scan with batch optimization
    -- ========================================================================

    -- Calculate upper bound for prefix filtering
    IF v_prefix_lower = '' THEN
        v_upper_bound := NULL;
    ELSIF right(v_prefix_lower, 1) = v_delimiter THEN
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(v_delimiter) + 1);
    ELSE
        v_upper_bound := left(v_prefix_lower, -1) || chr(ascii(right(v_prefix_lower, 1)) + 1);
    END IF;

    -- Build batch query (dynamic SQL - called infrequently, amortized over many rows)
    IF v_is_asc THEN
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'AND lower(o.name) COLLATE "C" < $3 ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" >= $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" ASC LIMIT $4';
        END IF;
    ELSE
        IF v_upper_bound IS NOT NULL THEN
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'AND lower(o.name) COLLATE "C" >= $3 ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        ELSE
            v_batch_query := 'SELECT o.name, o.id, o.updated_at, o.created_at, o.last_accessed_at, o.metadata ' ||
                'FROM storage.objects o WHERE o.bucket_id = $1 AND lower(o.name) COLLATE "C" < $2 ' ||
                'ORDER BY lower(o.name) COLLATE "C" DESC LIMIT $4';
        END IF;
    END IF;

    -- Initialize seek position
    IF v_is_asc THEN
        v_next_seek := v_prefix_lower;
    ELSE
        -- DESC: find the last item in range first (static SQL)
        IF v_upper_bound IS NOT NULL THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower AND lower(o.name) COLLATE "C" < v_upper_bound
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSIF v_prefix_lower <> '' THEN
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_prefix_lower
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        ELSE
            SELECT o.name INTO v_peek_name FROM storage.objects o
            WHERE o.bucket_id = bucketname
            ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
        END IF;

        IF v_peek_name IS NOT NULL THEN
            v_next_seek := lower(v_peek_name) || v_delimiter;
        ELSE
            RETURN;
        END IF;
    END IF;

    -- ========================================================================
    -- MAIN LOOP: Hybrid peek-then-batch algorithm
    -- Uses STATIC SQL for peek (hot path) and DYNAMIC SQL for batch
    -- ========================================================================
    LOOP
        EXIT WHEN v_count >= v_limit;

        -- STEP 1: PEEK using STATIC SQL (plan cached, very fast)
        IF v_is_asc THEN
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek AND lower(o.name) COLLATE "C" < v_upper_bound
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" >= v_next_seek
                ORDER BY lower(o.name) COLLATE "C" ASC LIMIT 1;
            END IF;
        ELSE
            IF v_upper_bound IS NOT NULL THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSIF v_prefix_lower <> '' THEN
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek AND lower(o.name) COLLATE "C" >= v_prefix_lower
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            ELSE
                SELECT o.name INTO v_peek_name FROM storage.objects o
                WHERE o.bucket_id = bucketname AND lower(o.name) COLLATE "C" < v_next_seek
                ORDER BY lower(o.name) COLLATE "C" DESC LIMIT 1;
            END IF;
        END IF;

        EXIT WHEN v_peek_name IS NULL;

        -- STEP 2: Check if this is a FOLDER or FILE
        v_common_prefix := storage.get_common_prefix(lower(v_peek_name), v_prefix_lower, v_delimiter);

        IF v_common_prefix IS NOT NULL THEN
            -- FOLDER: Handle offset, emit if needed, skip to next folder
            IF v_skipped < offsets THEN
                v_skipped := v_skipped + 1;
            ELSE
                name := split_part(rtrim(storage.get_common_prefix(v_peek_name, v_prefix, v_delimiter), v_delimiter), v_delimiter, levels);
                id := NULL;
                updated_at := NULL;
                created_at := NULL;
                last_accessed_at := NULL;
                metadata := NULL;
                RETURN NEXT;
                v_count := v_count + 1;
            END IF;

            -- Advance seek past the folder range
            IF v_is_asc THEN
                v_next_seek := lower(left(v_common_prefix, -1)) || chr(ascii(v_delimiter) + 1);
            ELSE
                v_next_seek := lower(v_common_prefix);
            END IF;
        ELSE
            -- FILE: Batch fetch using DYNAMIC SQL (overhead amortized over many rows)
            -- For ASC: upper_bound is the exclusive upper limit (< condition)
            -- For DESC: prefix_lower is the inclusive lower limit (>= condition)
            FOR v_current IN EXECUTE v_batch_query
                USING bucketname, v_next_seek,
                    CASE WHEN v_is_asc THEN COALESCE(v_upper_bound, v_prefix_lower) ELSE v_prefix_lower END, v_file_batch_size
            LOOP
                v_common_prefix := storage.get_common_prefix(lower(v_current.name), v_prefix_lower, v_delimiter);

                IF v_common_prefix IS NOT NULL THEN
                    -- Hit a folder: exit batch, let peek handle it
                    v_next_seek := lower(v_current.name);
                    EXIT;
                END IF;

                -- Handle offset skipping
                IF v_skipped < offsets THEN
                    v_skipped := v_skipped + 1;
                ELSE
                    -- Emit file
                    name := split_part(v_current.name, v_delimiter, levels);
                    id := v_current.id;
                    updated_at := v_current.updated_at;
                    created_at := v_current.created_at;
                    last_accessed_at := v_current.last_accessed_at;
                    metadata := v_current.metadata;
                    RETURN NEXT;
                    v_count := v_count + 1;
                END IF;

                -- Advance seek past this file
                IF v_is_asc THEN
                    v_next_seek := lower(v_current.name) || v_delimiter;
                ELSE
                    v_next_seek := lower(v_current.name);
                END IF;

                EXIT WHEN v_count >= v_limit;
            END LOOP;
        END IF;
    END LOOP;
END;
$_$;


--
-- Name: search_by_timestamp(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_by_timestamp(p_prefix text, p_bucket_id text, p_limit integer, p_level integer, p_start_after text, p_sort_order text, p_sort_column text, p_sort_column_after text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
DECLARE
    v_cursor_op text;
    v_query text;
    v_prefix text;
BEGIN
    v_prefix := coalesce(p_prefix, '');

    IF p_sort_order = 'asc' THEN
        v_cursor_op := '>';
    ELSE
        v_cursor_op := '<';
    END IF;

    v_query := format($sql$
        WITH raw_objects AS (
            SELECT
                o.name AS obj_name,
                o.id AS obj_id,
                o.updated_at AS obj_updated_at,
                o.created_at AS obj_created_at,
                o.last_accessed_at AS obj_last_accessed_at,
                o.metadata AS obj_metadata,
                storage.get_common_prefix(o.name, $1, '/') AS common_prefix
            FROM storage.objects o
            WHERE o.bucket_id = $2
              AND o.name COLLATE "C" LIKE $1 || '%%'
        ),
        -- Aggregate common prefixes (folders)
        -- Both created_at and updated_at use MIN(obj_created_at) to match the old prefixes table behavior
        aggregated_prefixes AS (
            SELECT
                rtrim(common_prefix, '/') AS name,
                NULL::uuid AS id,
                MIN(obj_created_at) AS updated_at,
                MIN(obj_created_at) AS created_at,
                NULL::timestamptz AS last_accessed_at,
                NULL::jsonb AS metadata,
                TRUE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NOT NULL
            GROUP BY common_prefix
        ),
        leaf_objects AS (
            SELECT
                obj_name AS name,
                obj_id AS id,
                obj_updated_at AS updated_at,
                obj_created_at AS created_at,
                obj_last_accessed_at AS last_accessed_at,
                obj_metadata AS metadata,
                FALSE AS is_prefix
            FROM raw_objects
            WHERE common_prefix IS NULL
        ),
        combined AS (
            SELECT * FROM aggregated_prefixes
            UNION ALL
            SELECT * FROM leaf_objects
        ),
        filtered AS (
            SELECT *
            FROM combined
            WHERE (
                $5 = ''
                OR ROW(
                    date_trunc('milliseconds', %I),
                    name COLLATE "C"
                ) %s ROW(
                    COALESCE(NULLIF($6, '')::timestamptz, 'epoch'::timestamptz),
                    $5
                )
            )
        )
        SELECT
            split_part(name, '/', $3) AS key,
            name,
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
        FROM filtered
        ORDER BY
            COALESCE(date_trunc('milliseconds', %I), 'epoch'::timestamptz) %s,
            name COLLATE "C" %s
        LIMIT $4
    $sql$,
        p_sort_column,
        v_cursor_op,
        p_sort_column,
        p_sort_order,
        p_sort_order
    );

    RETURN QUERY EXECUTE v_query
    USING v_prefix, p_bucket_id, p_level, p_limit, p_start_after, p_sort_column_after;
END;
$_$;


--
-- Name: search_v2(text, text, integer, integer, text, text, text, text); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text, sort_order text DEFAULT 'asc'::text, sort_column text DEFAULT 'name'::text, sort_column_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $$
DECLARE
    v_sort_col text;
    v_sort_ord text;
    v_limit int;
BEGIN
    -- Cap limit to maximum of 1500 records
    v_limit := LEAST(coalesce(limits, 100), 1500);

    -- Validate and normalize sort_order
    v_sort_ord := lower(coalesce(sort_order, 'asc'));
    IF v_sort_ord NOT IN ('asc', 'desc') THEN
        v_sort_ord := 'asc';
    END IF;

    -- Validate and normalize sort_column
    v_sort_col := lower(coalesce(sort_column, 'name'));
    IF v_sort_col NOT IN ('name', 'updated_at', 'created_at') THEN
        v_sort_col := 'name';
    END IF;

    -- Route to appropriate implementation
    IF v_sort_col = 'name' THEN
        -- Use list_objects_with_delimiter for name sorting (most efficient: O(k * log n))
        RETURN QUERY
        SELECT
            split_part(l.name, '/', levels) AS key,
            l.name AS name,
            l.id,
            l.updated_at,
            l.created_at,
            l.last_accessed_at,
            l.metadata
        FROM storage.list_objects_with_delimiter(
            bucket_name,
            coalesce(prefix, ''),
            '/',
            v_limit,
            start_after,
            '',
            v_sort_ord
        ) l;
    ELSE
        -- Use aggregation approach for timestamp sorting
        -- Not efficient for large datasets but supports correct pagination
        RETURN QUERY SELECT * FROM storage.search_by_timestamp(
            prefix, bucket_name, v_limit, levels, start_after,
            v_sort_ord, v_sort_col, sort_column_after
        );
    END IF;
END;
$$;


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: -
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: custom_oauth_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.custom_oauth_providers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    provider_type text NOT NULL,
    identifier text NOT NULL,
    name text NOT NULL,
    client_id text NOT NULL,
    client_secret text NOT NULL,
    acceptable_client_ids text[] DEFAULT '{}'::text[] NOT NULL,
    scopes text[] DEFAULT '{}'::text[] NOT NULL,
    pkce_enabled boolean DEFAULT true NOT NULL,
    attribute_mapping jsonb DEFAULT '{}'::jsonb NOT NULL,
    authorization_params jsonb DEFAULT '{}'::jsonb NOT NULL,
    enabled boolean DEFAULT true NOT NULL,
    email_optional boolean DEFAULT false NOT NULL,
    issuer text,
    discovery_url text,
    skip_nonce_check boolean DEFAULT false NOT NULL,
    cached_discovery jsonb,
    discovery_cached_at timestamp with time zone,
    authorization_url text,
    token_url text,
    userinfo_url text,
    jwks_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    custom_claims_allowlist text[] DEFAULT '{}'::text[] NOT NULL,
    CONSTRAINT custom_oauth_providers_authorization_url_https CHECK (((authorization_url IS NULL) OR (authorization_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_authorization_url_length CHECK (((authorization_url IS NULL) OR (char_length(authorization_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_client_id_length CHECK (((char_length(client_id) >= 1) AND (char_length(client_id) <= 512))),
    CONSTRAINT custom_oauth_providers_discovery_url_length CHECK (((discovery_url IS NULL) OR (char_length(discovery_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_identifier_format CHECK ((identifier ~ '^[a-z0-9][a-z0-9:-]{0,48}[a-z0-9]$'::text)),
    CONSTRAINT custom_oauth_providers_issuer_length CHECK (((issuer IS NULL) OR ((char_length(issuer) >= 1) AND (char_length(issuer) <= 2048)))),
    CONSTRAINT custom_oauth_providers_jwks_uri_https CHECK (((jwks_uri IS NULL) OR (jwks_uri ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_jwks_uri_length CHECK (((jwks_uri IS NULL) OR (char_length(jwks_uri) <= 2048))),
    CONSTRAINT custom_oauth_providers_name_length CHECK (((char_length(name) >= 1) AND (char_length(name) <= 100))),
    CONSTRAINT custom_oauth_providers_oauth2_requires_endpoints CHECK (((provider_type <> 'oauth2'::text) OR ((authorization_url IS NOT NULL) AND (token_url IS NOT NULL) AND (userinfo_url IS NOT NULL)))),
    CONSTRAINT custom_oauth_providers_oidc_discovery_url_https CHECK (((provider_type <> 'oidc'::text) OR (discovery_url IS NULL) OR (discovery_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_issuer_https CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NULL) OR (issuer ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_oidc_requires_issuer CHECK (((provider_type <> 'oidc'::text) OR (issuer IS NOT NULL))),
    CONSTRAINT custom_oauth_providers_provider_type_check CHECK ((provider_type = ANY (ARRAY['oauth2'::text, 'oidc'::text]))),
    CONSTRAINT custom_oauth_providers_token_url_https CHECK (((token_url IS NULL) OR (token_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_token_url_length CHECK (((token_url IS NULL) OR (char_length(token_url) <= 2048))),
    CONSTRAINT custom_oauth_providers_userinfo_url_https CHECK (((userinfo_url IS NULL) OR (userinfo_url ~~ 'https://%'::text))),
    CONSTRAINT custom_oauth_providers_userinfo_url_length CHECK (((userinfo_url IS NULL) OR (char_length(userinfo_url) <= 2048)))
);


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text,
    code_challenge_method auth.code_challenge_method,
    code_challenge text,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone,
    invite_token text,
    referrer text,
    oauth_client_state_id uuid,
    linking_target_id uuid,
    email_optional boolean DEFAULT false NOT NULL
);


--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.flow_state IS 'Stores metadata for all OAuth/SSO login flows';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid,
    last_webauthn_challenge_data jsonb
);


--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: COLUMN mfa_factors.last_webauthn_challenge_data; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.mfa_factors.last_webauthn_challenge_data IS 'Stores the latest WebAuthn challenge data including attestation/assertion for customer verification';


--
-- Name: oauth_authorizations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_authorizations (
    id uuid NOT NULL,
    authorization_id text NOT NULL,
    client_id uuid NOT NULL,
    user_id uuid,
    redirect_uri text NOT NULL,
    scope text NOT NULL,
    state text,
    resource text,
    code_challenge text,
    code_challenge_method auth.code_challenge_method,
    response_type auth.oauth_response_type DEFAULT 'code'::auth.oauth_response_type NOT NULL,
    status auth.oauth_authorization_status DEFAULT 'pending'::auth.oauth_authorization_status NOT NULL,
    authorization_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone DEFAULT (now() + '00:03:00'::interval) NOT NULL,
    approved_at timestamp with time zone,
    nonce text,
    CONSTRAINT oauth_authorizations_authorization_code_length CHECK ((char_length(authorization_code) <= 255)),
    CONSTRAINT oauth_authorizations_code_challenge_length CHECK ((char_length(code_challenge) <= 128)),
    CONSTRAINT oauth_authorizations_expires_at_future CHECK ((expires_at > created_at)),
    CONSTRAINT oauth_authorizations_nonce_length CHECK ((char_length(nonce) <= 255)),
    CONSTRAINT oauth_authorizations_redirect_uri_length CHECK ((char_length(redirect_uri) <= 2048)),
    CONSTRAINT oauth_authorizations_resource_length CHECK ((char_length(resource) <= 2048)),
    CONSTRAINT oauth_authorizations_scope_length CHECK ((char_length(scope) <= 4096)),
    CONSTRAINT oauth_authorizations_state_length CHECK ((char_length(state) <= 4096))
);


--
-- Name: oauth_client_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_client_states (
    id uuid NOT NULL,
    provider_type text NOT NULL,
    code_verifier text,
    created_at timestamp with time zone NOT NULL
);


--
-- Name: TABLE oauth_client_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.oauth_client_states IS 'Stores OAuth states for third-party provider authentication flows where Supabase acts as the OAuth client.';


--
-- Name: oauth_clients; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_clients (
    id uuid NOT NULL,
    client_secret_hash text,
    registration_type auth.oauth_registration_type NOT NULL,
    redirect_uris text NOT NULL,
    grant_types text NOT NULL,
    client_name text,
    client_uri text,
    logo_uri text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    deleted_at timestamp with time zone,
    client_type auth.oauth_client_type DEFAULT 'confidential'::auth.oauth_client_type NOT NULL,
    token_endpoint_auth_method text NOT NULL,
    CONSTRAINT oauth_clients_client_name_length CHECK ((char_length(client_name) <= 1024)),
    CONSTRAINT oauth_clients_client_uri_length CHECK ((char_length(client_uri) <= 2048)),
    CONSTRAINT oauth_clients_logo_uri_length CHECK ((char_length(logo_uri) <= 2048)),
    CONSTRAINT oauth_clients_token_endpoint_auth_method_check CHECK ((token_endpoint_auth_method = ANY (ARRAY['client_secret_basic'::text, 'client_secret_post'::text, 'none'::text])))
);


--
-- Name: oauth_consents; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.oauth_consents (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    client_id uuid NOT NULL,
    scopes text NOT NULL,
    granted_at timestamp with time zone DEFAULT now() NOT NULL,
    revoked_at timestamp with time zone,
    CONSTRAINT oauth_consents_revoked_after_granted CHECK (((revoked_at IS NULL) OR (revoked_at >= granted_at))),
    CONSTRAINT oauth_consents_scopes_length CHECK ((char_length(scopes) <= 2048)),
    CONSTRAINT oauth_consents_scopes_not_empty CHECK ((char_length(TRIM(BOTH FROM scopes)) > 0))
);


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: -
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: -
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text,
    oauth_client_id uuid,
    refresh_token_hmac_key text,
    refresh_token_counter bigint,
    scopes text,
    CONSTRAINT sessions_scopes_length CHECK ((char_length(scopes) <= 4096))
);


--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: COLUMN sessions.refresh_token_hmac_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.refresh_token_hmac_key IS 'Holds a HMAC-SHA256 key used to sign refresh tokens for this session.';


--
-- Name: COLUMN sessions.refresh_token_counter; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sessions.refresh_token_counter IS 'Holds the ID (counter) of the last issued refresh token.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    disabled boolean,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: webauthn_challenges; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.webauthn_challenges (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    challenge_type text NOT NULL,
    session_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    CONSTRAINT webauthn_challenges_challenge_type_check CHECK ((challenge_type = ANY (ARRAY['signup'::text, 'registration'::text, 'authentication'::text])))
);


--
-- Name: webauthn_credentials; Type: TABLE; Schema: auth; Owner: -
--

CREATE TABLE auth.webauthn_credentials (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    credential_id bytea NOT NULL,
    public_key bytea NOT NULL,
    attestation_type text DEFAULT ''::text NOT NULL,
    aaguid uuid,
    sign_count bigint DEFAULT 0 NOT NULL,
    transports jsonb DEFAULT '[]'::jsonb NOT NULL,
    backup_eligible boolean DEFAULT false NOT NULL,
    backed_up boolean DEFAULT false NOT NULL,
    friendly_name text DEFAULT ''::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    last_used_at timestamp with time zone
);


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
-- Name: messages; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    binary_payload bytea
)
PARTITION BY RANGE (inserted_at);


--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: -
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    action_filter text DEFAULT '*'::text,
    selected_columns text[],
    CONSTRAINT subscription_action_filter_check CHECK ((action_filter = ANY (ARRAY['*'::text, 'INSERT'::text, 'UPDATE'::text, 'DELETE'::text])))
);


--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: -
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text,
    type storage.buckettype DEFAULT 'STANDARD'::storage.buckettype NOT NULL
);


--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: buckets_analytics; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_analytics (
    name text NOT NULL,
    type storage.buckettype DEFAULT 'ANALYTICS'::storage.buckettype NOT NULL,
    format text DEFAULT 'ICEBERG'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    deleted_at timestamp with time zone
);


--
-- Name: buckets_vectors; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.buckets_vectors (
    id text NOT NULL,
    type storage.buckettype DEFAULT 'VECTOR'::storage.buckettype NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: objects; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: -
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb,
    metadata jsonb
);


--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: vector_indexes; Type: TABLE; Schema: storage; Owner: -
--

CREATE TABLE storage.vector_indexes (
    id text DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    bucket_id text NOT NULL,
    data_type text NOT NULL,
    dimension integer NOT NULL,
    distance_metric text NOT NULL,
    metadata_configuration jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
\.


--
-- Data for Name: custom_oauth_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.custom_oauth_providers (id, provider_type, identifier, name, client_id, client_secret, acceptable_client_ids, scopes, pkce_enabled, attribute_mapping, authorization_params, enabled, email_optional, issuer, discovery_url, skip_nonce_check, cached_discovery, discovery_cached_at, authorization_url, token_url, userinfo_url, jwks_uri, created_at, updated_at, custom_claims_allowlist) FROM stdin;
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at, invite_token, referrer, oauth_client_state_id, linking_target_id, email_optional) FROM stdin;
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid, last_webauthn_challenge_data) FROM stdin;
\.


--
-- Data for Name: oauth_authorizations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_authorizations (id, authorization_id, client_id, user_id, redirect_uri, scope, state, resource, code_challenge, code_challenge_method, response_type, status, authorization_code, created_at, expires_at, approved_at, nonce) FROM stdin;
\.


--
-- Data for Name: oauth_client_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_client_states (id, provider_type, code_verifier, created_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_clients (id, client_secret_hash, registration_type, redirect_uris, grant_types, client_name, client_uri, logo_uri, created_at, updated_at, deleted_at, client_type, token_endpoint_auth_method) FROM stdin;
\.


--
-- Data for Name: oauth_consents; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.oauth_consents (id, user_id, client_id, scopes, granted_at, revoked_at) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
20250717082212
20250731150234
20250804100000
20250901200500
20250903112500
20250904133000
20250925093508
20251007112900
20251104100000
20251111201300
20251201000000
20260115000000
20260121000000
20260219120000
20260302000000
20260625000000
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag, oauth_client_id, refresh_token_hmac_key, refresh_token_counter, scopes) FROM stdin;
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at, disabled) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
\.


--
-- Data for Name: webauthn_challenges; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.webauthn_challenges (id, user_id, challenge_type, session_data, created_at, expires_at) FROM stdin;
\.


--
-- Data for Name: webauthn_credentials; Type: TABLE DATA; Schema: auth; Owner: -
--

COPY auth.webauthn_credentials (id, user_id, credential_id, public_key, attestation_type, aaguid, sign_count, transports, backup_eligible, backed_up, friendly_name, created_at, updated_at, last_used_at) FROM stdin;
\.


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
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2026-06-19 19:34:08
20211116045059	2026-06-19 19:34:08
20211116050929	2026-06-19 19:34:08
20211116051442	2026-06-19 19:34:08
20211116212300	2026-06-19 19:34:08
20211116213355	2026-06-19 19:34:08
20211116213934	2026-06-19 19:34:09
20211116214523	2026-06-19 19:34:09
20211122062447	2026-06-19 19:34:09
20211124070109	2026-06-19 19:34:09
20211202204204	2026-06-19 19:34:09
20211202204605	2026-06-19 19:34:09
20211210212804	2026-06-19 19:34:09
20211228014915	2026-06-19 19:34:10
20220107221237	2026-06-19 19:34:10
20220228202821	2026-06-19 19:34:10
20220312004840	2026-06-19 19:34:10
20220603231003	2026-06-19 19:34:10
20220603232444	2026-06-19 19:34:10
20220615214548	2026-06-19 19:34:10
20220712093339	2026-06-19 19:34:10
20220908172859	2026-06-19 19:34:11
20220916233421	2026-06-19 19:34:11
20230119133233	2026-06-19 19:34:11
20230128025114	2026-06-19 19:34:11
20230128025212	2026-06-19 19:34:11
20230227211149	2026-06-19 19:34:11
20230228184745	2026-06-19 19:34:11
20230308225145	2026-06-19 19:34:11
20230328144023	2026-06-19 19:34:11
20231018144023	2026-06-19 19:34:12
20231204144023	2026-06-19 19:34:12
20231204144024	2026-06-19 19:34:12
20231204144025	2026-06-19 19:34:12
20240108234812	2026-06-19 19:34:12
20240109165339	2026-06-19 19:34:12
20240227174441	2026-06-19 19:34:12
20240311171622	2026-06-19 19:34:13
20240321100241	2026-06-19 19:34:13
20240401105812	2026-06-19 19:34:13
20240418121054	2026-06-19 19:34:13
20240523004032	2026-06-19 19:34:14
20240618124746	2026-06-19 19:34:14
20240801235015	2026-06-19 19:34:14
20240805133720	2026-06-19 19:34:14
20240827160934	2026-06-19 19:34:14
20240919163303	2026-06-19 19:34:14
20240919163305	2026-06-19 19:34:14
20241019105805	2026-06-19 19:34:14
20241030150047	2026-06-19 19:34:15
20241108114728	2026-06-19 19:34:15
20241121104152	2026-06-19 19:34:15
20241130184212	2026-06-19 19:34:15
20241220035512	2026-06-19 19:34:15
20241220123912	2026-06-19 19:34:16
20241224161212	2026-06-19 19:34:16
20250107150512	2026-06-19 19:34:16
20250110162412	2026-06-19 19:34:16
20250123174212	2026-06-19 19:34:16
20250128220012	2026-06-19 19:34:16
20250506224012	2026-06-19 19:34:16
20250523164012	2026-06-19 19:34:16
20250714121412	2026-06-19 19:34:16
20250905041441	2026-06-19 19:34:16
20251103001201	2026-06-19 19:34:17
20251120212548	2026-06-19 19:34:17
20251120215549	2026-06-19 19:34:17
20260218120000	2026-06-19 19:34:17
20260326120000	2026-06-19 19:34:17
20260514120000	2026-06-19 19:34:17
20260527120000	2026-06-19 19:34:17
20260528120000	2026-06-19 19:34:18
20260603120000	2026-06-19 19:34:18
20260605120000	2026-06-19 19:34:18
20260606110000	2026-06-19 19:34:18
20260616120000	2026-07-25 02:55:52
20260624120000	2026-07-25 02:55:53
20260626120000	2026-07-25 02:55:53
20260706120000	2026-07-25 02:55:53
20260707120000	2026-07-25 02:55:54
20260709120000	2026-07-25 02:55:54
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: -
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at, action_filter, selected_columns) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id, type) FROM stdin;
\.


--
-- Data for Name: buckets_analytics; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_analytics (name, type, format, created_at, updated_at, id, deleted_at) FROM stdin;
\.


--
-- Data for Name: buckets_vectors; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.buckets_vectors (id, type, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2026-06-19 19:34:08.980387
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2026-06-19 19:34:08.991472
2	storage-schema	f6a1fa2c93cbcd16d4e487b362e45fca157a8dbd	2026-06-19 19:34:08.998735
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2026-06-19 19:34:09.01459
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2026-06-19 19:34:09.030694
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2026-06-19 19:34:09.036959
6	change-column-name-in-get-size	ded78e2f1b5d7e616117897e6443a925965b30d2	2026-06-19 19:34:09.043552
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2026-06-19 19:34:09.050363
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2026-06-19 19:34:09.056576
9	fix-search-function	af597a1b590c70519b464a4ab3be54490712796b	2026-06-19 19:34:09.063086
10	search-files-search-function	b595f05e92f7e91211af1bbfe9c6a13bb3391e16	2026-06-19 19:34:09.070453
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2026-06-19 19:34:09.077326
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2026-06-19 19:34:09.084148
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2026-06-19 19:34:09.091307
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2026-06-19 19:34:09.097986
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2026-06-19 19:34:09.123653
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2026-06-19 19:34:09.129926
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2026-06-19 19:34:09.136368
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2026-06-19 19:34:09.142814
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2026-06-19 19:34:09.150514
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2026-06-19 19:34:09.156806
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2026-06-19 19:34:09.204149
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2026-06-19 19:34:09.218684
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2026-06-19 19:34:09.27171
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2026-06-19 19:34:09.282831
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2026-06-19 19:34:09.294217
26	objects-prefixes	215cabcb7f78121892a5a2037a09fedf9a1ae322	2026-06-19 19:34:09.300861
27	search-v2	859ba38092ac96eb3964d83bf53ccc0b141663a6	2026-06-19 19:34:09.3072
28	object-bucket-name-sorting	c73a2b5b5d4041e39705814fd3a1b95502d38ce4	2026-06-19 19:34:09.313121
29	create-prefixes	ad2c1207f76703d11a9f9007f821620017a66c21	2026-06-19 19:34:09.319119
30	update-object-levels	2be814ff05c8252fdfdc7cfb4b7f5c7e17f0bed6	2026-06-19 19:34:09.325177
31	objects-level-index	b40367c14c3440ec75f19bbce2d71e914ddd3da0	2026-06-19 19:34:09.372657
32	backward-compatible-index-on-objects	e0c37182b0f7aee3efd823298fb3c76f1042c0f7	2026-06-19 19:34:09.378626
33	backward-compatible-index-on-prefixes	b480e99ed951e0900f033ec4eb34b5bdcb4e3d49	2026-06-19 19:34:09.384795
34	optimize-search-function-v1	ca80a3dc7bfef894df17108785ce29a7fc8ee456	2026-06-19 19:34:09.390725
35	add-insert-trigger-prefixes	458fe0ffd07ec53f5e3ce9df51bfdf4861929ccc	2026-06-19 19:34:09.396569
36	optimise-existing-functions	6ae5fca6af5c55abe95369cd4f93985d1814ca8f	2026-06-19 19:34:09.402439
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2026-06-19 19:34:09.408218
38	iceberg-catalog-flag-on-buckets	02716b81ceec9705aed84aa1501657095b32e5c5	2026-06-19 19:34:09.415293
39	add-search-v2-sort-support	6706c5f2928846abee18461279799ad12b279b78	2026-06-19 19:34:09.438637
40	fix-prefix-race-conditions-optimized	7ad69982ae2d372b21f48fc4829ae9752c518f6b	2026-06-19 19:34:09.447543
41	add-object-level-update-trigger	07fcf1a22165849b7a029deed059ffcde08d1ae0	2026-06-19 19:34:09.474117
42	rollback-prefix-triggers	771479077764adc09e2ea2043eb627503c034cd4	2026-06-19 19:34:09.483936
43	fix-object-level	84b35d6caca9d937478ad8a797491f38b8c2979f	2026-06-19 19:34:09.49009
44	vector-bucket-type	99c20c0ffd52bb1ff1f32fb992f3b351e3ef8fb3	2026-06-19 19:34:09.496053
45	vector-buckets	049e27196d77a7cb76497a85afae669d8b230953	2026-06-19 19:34:09.50262
46	buckets-objects-grants	fedeb96d60fefd8e02ab3ded9fbde05632f84aed	2026-06-19 19:34:09.516269
47	iceberg-table-metadata	649df56855c24d8b36dd4cc1aeb8251aa9ad42c2	2026-06-19 19:34:09.523043
48	iceberg-catalog-ids	e0e8b460c609b9999ccd0df9ad14294613eed939	2026-06-19 19:34:09.570303
49	buckets-objects-grants-postgres	072b1195d0d5a2f888af6b2302a1938dd94b8b3d	2026-06-19 19:34:09.587885
50	search-v2-optimised	6323ac4f850aa14e7387eb32102869578b5bd478	2026-06-19 19:34:09.594708
51	index-backward-compatible-search	2ee395d433f76e38bcd3856debaf6e0e5b674011	2026-06-19 19:34:10.689058
52	drop-not-used-indexes-and-functions	5cc44c8696749ac11dd0dc37f2a3802075f3a171	2026-06-19 19:34:10.691692
53	drop-index-lower-name	d0cb18777d9e2a98ebe0bc5cc7a42e57ebe41854	2026-06-19 19:34:10.703483
54	drop-index-object-level	6289e048b1472da17c31a7eba1ded625a6457e67	2026-06-19 19:34:10.707291
55	prevent-direct-deletes	262a4798d5e0f2e7c8970232e03ce8be695d5819	2026-06-19 19:34:10.709791
56	fix-optimized-search-function	b823ed1e418101032fa01374edc9a436e54e3ed4	2026-06-19 19:34:10.717005
57	s3-multipart-uploads-metadata	f127886e00d1b374fadbc7c6b31e09336aad5287	2026-06-19 19:34:10.724602
58	operation-ergonomics	00ca5d483b3fe0d522133d9002ccc5df98365120	2026-06-19 19:34:10.730991
59	drop-unused-functions	38456f13e39691c2bbb4b5151d0d1cdbabd4a8c4	2026-06-19 19:34:10.738635
60	optimize-existing-functions-again	db35e1c91a9201e59f4fef8d972c2f277d68b157	2026-06-19 19:34:10.74525
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata, metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: vector_indexes; Type: TABLE DATA; Schema: storage; Owner: -
--

COPY storage.vector_indexes (id, name, bucket_id, data_type, dimension, distance_metric, metadata_configuration, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: -
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: -
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- Name: goose_db_version_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.goose_db_version_id_seq', 37, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: -
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: custom_oauth_providers custom_oauth_providers_identifier_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_identifier_key UNIQUE (identifier);


--
-- Name: custom_oauth_providers custom_oauth_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.custom_oauth_providers
    ADD CONSTRAINT custom_oauth_providers_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_code_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_code_key UNIQUE (authorization_code);


--
-- Name: oauth_authorizations oauth_authorizations_authorization_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_authorization_id_key UNIQUE (authorization_id);


--
-- Name: oauth_authorizations oauth_authorizations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_pkey PRIMARY KEY (id);


--
-- Name: oauth_client_states oauth_client_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_client_states
    ADD CONSTRAINT oauth_client_states_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients oauth_clients_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_pkey PRIMARY KEY (id);


--
-- Name: oauth_consents oauth_consents_user_client_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_client_unique UNIQUE (user_id, client_id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: webauthn_challenges webauthn_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_pkey PRIMARY KEY (id);


--
-- Name: webauthn_credentials webauthn_credentials_pkey; Type: CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_pkey PRIMARY KEY (id);


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
-- Name: messages messages_payload_exclusive; Type: CHECK CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE realtime.messages
    ADD CONSTRAINT messages_payload_exclusive CHECK (((payload IS NULL) OR (binary_payload IS NULL))) NOT VALID;


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: -
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets_analytics buckets_analytics_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_analytics
    ADD CONSTRAINT buckets_analytics_pkey PRIMARY KEY (id);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: buckets_vectors buckets_vectors_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.buckets_vectors
    ADD CONSTRAINT buckets_vectors_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: vector_indexes vector_indexes_pkey; Type: CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: custom_oauth_providers_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX custom_oauth_providers_created_at_idx ON auth.custom_oauth_providers USING btree (created_at);


--
-- Name: custom_oauth_providers_enabled_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX custom_oauth_providers_enabled_idx ON auth.custom_oauth_providers USING btree (enabled);


--
-- Name: custom_oauth_providers_identifier_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX custom_oauth_providers_identifier_idx ON auth.custom_oauth_providers USING btree (identifier);


--
-- Name: custom_oauth_providers_provider_type_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX custom_oauth_providers_provider_type_idx ON auth.custom_oauth_providers USING btree (provider_type);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_oauth_client_states_created_at; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_oauth_client_states_created_at ON auth.oauth_client_states USING btree (created_at);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: idx_users_created_at_desc; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_users_created_at_desc ON auth.users USING btree (created_at DESC);


--
-- Name: idx_users_email; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_users_email ON auth.users USING btree (email);


--
-- Name: idx_users_last_sign_in_at_desc; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_users_last_sign_in_at_desc ON auth.users USING btree (last_sign_in_at DESC);


--
-- Name: idx_users_name; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX idx_users_name ON auth.users USING btree (((raw_user_meta_data ->> 'name'::text))) WHERE ((raw_user_meta_data ->> 'name'::text) IS NOT NULL);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: oauth_auth_pending_exp_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_auth_pending_exp_idx ON auth.oauth_authorizations USING btree (expires_at) WHERE (status = 'pending'::auth.oauth_authorization_status);


--
-- Name: oauth_clients_deleted_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_clients_deleted_at_idx ON auth.oauth_clients USING btree (deleted_at);


--
-- Name: oauth_consents_active_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_client_idx ON auth.oauth_consents USING btree (client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_active_user_client_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_active_user_client_idx ON auth.oauth_consents USING btree (user_id, client_id) WHERE (revoked_at IS NULL);


--
-- Name: oauth_consents_user_order_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX oauth_consents_user_order_idx ON auth.oauth_consents USING btree (user_id, granted_at DESC);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_oauth_client_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_oauth_client_id_idx ON auth.sessions USING btree (oauth_client_id);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: sso_providers_resource_id_pattern_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX sso_providers_resource_id_pattern_idx ON auth.sso_providers USING btree (resource_id text_pattern_ops);


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: -
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: webauthn_challenges_expires_at_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX webauthn_challenges_expires_at_idx ON auth.webauthn_challenges USING btree (expires_at);


--
-- Name: webauthn_challenges_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX webauthn_challenges_user_id_idx ON auth.webauthn_challenges USING btree (user_id);


--
-- Name: webauthn_credentials_credential_id_key; Type: INDEX; Schema: auth; Owner: -
--

CREATE UNIQUE INDEX webauthn_credentials_credential_id_key ON auth.webauthn_credentials USING btree (credential_id);


--
-- Name: webauthn_credentials_user_id_idx; Type: INDEX; Schema: auth; Owner: -
--

CREATE INDEX webauthn_credentials_user_id_idx ON auth.webauthn_credentials USING btree (user_id);


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
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: messages_inserted_at_topic_index; Type: INDEX; Schema: realtime; Owner: -
--

CREATE INDEX messages_inserted_at_topic_index ON ONLY realtime.messages USING btree (inserted_at DESC, topic) WHERE ((extension = 'broadcast'::text) AND (private IS TRUE));


--
-- Name: subscription_subscription_id_entity_filters_action_filter_selec; Type: INDEX; Schema: realtime; Owner: -
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_action_filter_selec ON realtime.subscription USING btree (subscription_id, entity, filters, action_filter, COALESCE(selected_columns, '{}'::text[]));


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: buckets_analytics_unique_name_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX buckets_analytics_unique_name_idx ON storage.buckets_analytics USING btree (name) WHERE (deleted_at IS NULL);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: idx_objects_bucket_id_name_lower; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX idx_objects_bucket_id_name_lower ON storage.objects USING btree (bucket_id, lower(name) COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: -
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: vector_indexes_name_bucket_id_idx; Type: INDEX; Schema: storage; Owner: -
--

CREATE UNIQUE INDEX vector_indexes_name_bucket_id_idx ON storage.vector_indexes USING btree (name, bucket_id);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: -
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- Name: buckets protect_buckets_delete; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER protect_buckets_delete BEFORE DELETE ON storage.buckets FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects protect_objects_delete; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER protect_objects_delete BEFORE DELETE ON storage.objects FOR EACH STATEMENT EXECUTE FUNCTION storage.protect_delete();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: -
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_authorizations oauth_authorizations_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_authorizations
    ADD CONSTRAINT oauth_authorizations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_client_id_fkey FOREIGN KEY (client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: oauth_consents oauth_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.oauth_consents
    ADD CONSTRAINT oauth_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_oauth_client_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_oauth_client_id_fkey FOREIGN KEY (oauth_client_id) REFERENCES auth.oauth_clients(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: webauthn_challenges webauthn_challenges_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.webauthn_challenges
    ADD CONSTRAINT webauthn_challenges_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: webauthn_credentials webauthn_credentials_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: -
--

ALTER TABLE ONLY auth.webauthn_credentials
    ADD CONSTRAINT webauthn_credentials_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


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
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: vector_indexes vector_indexes_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: -
--

ALTER TABLE ONLY storage.vector_indexes
    ADD CONSTRAINT vector_indexes_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets_vectors(id);


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: -
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: -
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_analytics; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_analytics ENABLE ROW LEVEL SECURITY;

--
-- Name: buckets_vectors; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.buckets_vectors ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: vector_indexes; Type: ROW SECURITY; Schema: storage; Owner: -
--

ALTER TABLE storage.vector_indexes ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: -
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: -
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


--
-- PostgreSQL database dump complete
--

\unrestrict Y6xTlElgYkFokWminXyomfBNyhEKIfnhNxe1DHNGEa0dAPkyBrE9KZ6LDf4lDbc

