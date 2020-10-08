--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 12.2 (Ubuntu 12.2-2.pgdg18.04+1)

-- Started on 2020-03-06 17:17:36 CET

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

--
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

--CREATE SCHEMA public;


--
-- TOC entry 3858 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

--
-- TOC entry 239 (class 1259 OID 21368)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


--
-- TOC entry 268 (class 1259 OID 21831)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- TOC entry 242 (class 1259 OID 21386)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- TOC entry 241 (class 1259 OID 21380)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- TOC entry 240 (class 1259 OID 21374)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 243 (class 1259 OID 21391)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 269 (class 1259 OID 21846)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- TOC entry 199 (class 1259 OID 20723)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- TOC entry 223 (class 1259 OID 21097)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


--
-- TOC entry 280 (class 1259 OID 22105)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- TOC entry 198 (class 1259 OID 20720)
-- Name: client_default_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_default_roles (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 279 (class 1259 OID 21980)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- TOC entry 225 (class 1259 OID 21109)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- TOC entry 257 (class 1259 OID 21629)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- TOC entry 258 (class 1259 OID 21644)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- TOC entry 281 (class 1259 OID 22147)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 259 (class 1259 OID 21650)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 200 (class 1259 OID 20735)
-- Name: client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


--
-- TOC entry 246 (class 1259 OID 21412)
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 21103)
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 238 (class 1259 OID 21290)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 201 (class 1259 OID 20741)
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 21493)
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 277 (class 1259 OID 21896)
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- TOC entry 276 (class 1259 OID 21890)
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


--
-- TOC entry 202 (class 1259 OID 20744)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- TOC entry 203 (class 1259 OID 20747)
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- TOC entry 197 (class 1259 OID 20714)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- TOC entry 196 (class 1259 OID 20709)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- TOC entry 282 (class 1259 OID 22163)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 204 (class 1259 OID 20753)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


--
-- TOC entry 270 (class 1259 OID 21852)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


--
-- TOC entry 271 (class 1259 OID 21858)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 284 (class 1259 OID 22189)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 272 (class 1259 OID 21867)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- TOC entry 273 (class 1259 OID 21877)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 274 (class 1259 OID 21880)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 275 (class 1259 OID 21887)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 228 (class 1259 OID 21147)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 278 (class 1259 OID 21956)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 254 (class 1259 OID 21566)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 21563)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 21153)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 21163)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 21269)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 21275)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 21560)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36),
    realm_id character varying(36)
);


--
-- TOC entry 205 (class 1259 OID 20762)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- TOC entry 234 (class 1259 OID 21266)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- TOC entry 251 (class 1259 OID 21550)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


--
-- TOC entry 250 (class 1259 OID 21544)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 264 (class 1259 OID 21773)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 226 (class 1259 OID 21134)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- TOC entry 227 (class 1259 OID 21141)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 206 (class 1259 OID 20769)
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 207 (class 1259 OID 20787)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 256 (class 1259 OID 21576)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 208 (class 1259 OID 20793)
-- Name: realm_default_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_roles (
    realm_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 21258)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 209 (class 1259 OID 20796)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 210 (class 1259 OID 20799)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 20807)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 231 (class 1259 OID 21173)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 212 (class 1259 OID 20819)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 249 (class 1259 OID 21507)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 248 (class 1259 OID 21499)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- TOC entry 286 (class 1259 OID 22228)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- TOC entry 266 (class 1259 OID 21801)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 265 (class 1259 OID 21786)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 260 (class 1259 OID 21720)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- TOC entry 285 (class 1259 OID 22204)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- TOC entry 263 (class 1259 OID 21758)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- TOC entry 261 (class 1259 OID 21728)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 262 (class 1259 OID 21743)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 287 (class 1259 OID 22247)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 288 (class 1259 OID 22257)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- TOC entry 213 (class 1259 OID 20822)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 267 (class 1259 OID 21816)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 20828)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


--
-- TOC entry 237 (class 1259 OID 21281)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 283 (class 1259 OID 22179)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 20834)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 20843)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 21397)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 245 (class 1259 OID 21403)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 20849)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 255 (class 1259 OID 21573)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 219 (class 1259 OID 20855)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 20858)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 20861)
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


--
-- TOC entry 232 (class 1259 OID 21176)
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


--
-- TOC entry 214 (class 1259 OID 20825)
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


--
-- TOC entry 222 (class 1259 OID 20874)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 3803 (class 0 OID 21368)
-- Dependencies: 239
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- TOC entry 3832 (class 0 OID 21831)
-- Dependencies: 268
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- TOC entry 3806 (class 0 OID 21386)
-- Dependencies: 242
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
6cf08465-9d2b-4a25-b23b-f7dd100d6cc4	\N	auth-cookie	master	7e5491f9-9087-4a4c-9ad2-6f91b7b10917	2	10	f	\N	\N
67a30214-4458-45cd-a396-d7e9ed448ab8	\N	auth-spnego	master	7e5491f9-9087-4a4c-9ad2-6f91b7b10917	3	20	f	\N	\N
6b67130a-5afe-43a9-afe5-fabd048db452	\N	identity-provider-redirector	master	7e5491f9-9087-4a4c-9ad2-6f91b7b10917	2	25	f	\N	\N
552ace6d-d803-4f4a-8f4a-a8c2e847280d	\N	\N	master	7e5491f9-9087-4a4c-9ad2-6f91b7b10917	2	30	t	12b68dd8-1f72-4918-ab05-e8b15ba56523	\N
e454e2fb-830e-4dff-b03f-d5cb18466c43	\N	auth-username-password-form	master	12b68dd8-1f72-4918-ab05-e8b15ba56523	0	10	f	\N	\N
d4c6f0c1-8007-4935-b025-339993c5c278	\N	\N	master	12b68dd8-1f72-4918-ab05-e8b15ba56523	1	20	t	90ce92a4-b769-4a03-9ffe-2386564adfa2	\N
70e7238d-048a-41f4-ac3a-363c03f039f7	\N	conditional-user-configured	master	90ce92a4-b769-4a03-9ffe-2386564adfa2	0	10	f	\N	\N
0e959b3b-1927-4cc4-9e78-619791529a38	\N	auth-otp-form	master	90ce92a4-b769-4a03-9ffe-2386564adfa2	0	20	f	\N	\N
47d4f25d-b4f1-40ae-b6e9-dfccfb1776f5	\N	direct-grant-validate-username	master	c737ea31-f9dc-49fc-beb6-404c3f7aa304	0	10	f	\N	\N
7a88f13c-b2dd-44e6-9eab-f0dca09a345a	\N	direct-grant-validate-password	master	c737ea31-f9dc-49fc-beb6-404c3f7aa304	0	20	f	\N	\N
df549c0d-878e-407b-a792-fbeece4db404	\N	\N	master	c737ea31-f9dc-49fc-beb6-404c3f7aa304	1	30	t	f5c531bd-e944-43e8-881f-1fc013b59cc3	\N
ad7a346e-361d-4fe1-a8d6-d651fe588db6	\N	conditional-user-configured	master	f5c531bd-e944-43e8-881f-1fc013b59cc3	0	10	f	\N	\N
bcd86474-b802-43f8-8597-b83cbc519b9c	\N	direct-grant-validate-otp	master	f5c531bd-e944-43e8-881f-1fc013b59cc3	0	20	f	\N	\N
a3de5f86-44ef-4cba-ac16-3881605bd080	\N	registration-page-form	master	aead836b-1e31-4616-a3a4-dc7a2ba36e3a	0	10	t	5a07a799-1507-45ad-b69d-1eb4a0ff6b88	\N
a3527d79-e719-46d4-b5b8-52fabc580377	\N	registration-user-creation	master	5a07a799-1507-45ad-b69d-1eb4a0ff6b88	0	20	f	\N	\N
7e3f38fb-6a0f-477e-8583-1f0f6c259bb8	\N	registration-profile-action	master	5a07a799-1507-45ad-b69d-1eb4a0ff6b88	0	40	f	\N	\N
095ffcd6-37ea-44dd-a8d7-1b25db159fd5	\N	registration-password-action	master	5a07a799-1507-45ad-b69d-1eb4a0ff6b88	0	50	f	\N	\N
008fbf34-ab86-40b2-aa3f-53063fd57d51	\N	registration-recaptcha-action	master	5a07a799-1507-45ad-b69d-1eb4a0ff6b88	3	60	f	\N	\N
67742c80-421e-4ea9-b028-a93fc2989633	\N	reset-credentials-choose-user	master	1c0a6861-fdcf-4c68-a046-b710e4895112	0	10	f	\N	\N
c33d1abe-67c0-43d1-bc87-0f49cbf979e2	\N	reset-credential-email	master	1c0a6861-fdcf-4c68-a046-b710e4895112	0	20	f	\N	\N
b4be32cd-fc03-4ace-8cfb-36b6a33eba38	\N	reset-password	master	1c0a6861-fdcf-4c68-a046-b710e4895112	0	30	f	\N	\N
7125fa35-0342-45fa-8a34-069e2ed1b953	\N	\N	master	1c0a6861-fdcf-4c68-a046-b710e4895112	1	40	t	ec54b30b-eca5-46d9-9b24-dc72dd1c6584	\N
890cc662-8fb9-4087-8a39-8ab276256de9	\N	conditional-user-configured	master	ec54b30b-eca5-46d9-9b24-dc72dd1c6584	0	10	f	\N	\N
5e3cd1f4-89c5-4018-865d-5e96bc85ab2f	\N	reset-otp	master	ec54b30b-eca5-46d9-9b24-dc72dd1c6584	0	20	f	\N	\N
862d3433-eb8a-4617-a94a-af85402a1905	\N	client-secret	master	32e4dc68-6969-41d6-9a34-2bd8ec480f5f	2	10	f	\N	\N
31d5c5e4-ed4c-4070-8520-72340424c569	\N	client-jwt	master	32e4dc68-6969-41d6-9a34-2bd8ec480f5f	2	20	f	\N	\N
2e33f3d6-27b7-427d-8858-0dce78ee6672	\N	client-secret-jwt	master	32e4dc68-6969-41d6-9a34-2bd8ec480f5f	2	30	f	\N	\N
5e8aca63-506c-493e-a0d8-14b89e697d97	\N	client-x509	master	32e4dc68-6969-41d6-9a34-2bd8ec480f5f	2	40	f	\N	\N
cc8576a8-e2be-47d3-8db5-0b6384e3a92b	\N	idp-review-profile	master	8016d4b9-55e3-4ac1-be33-bc5d983af673	0	10	f	\N	0f22d9e4-07fa-429b-9786-7ecb522694bd
47a61595-a17d-4aa2-a24d-8365e973a292	\N	\N	master	8016d4b9-55e3-4ac1-be33-bc5d983af673	0	20	t	98cf52e6-6909-4bc2-b3e5-fef277f71f24	\N
c85fe774-59af-47a7-a848-a4b91fc941b1	\N	idp-create-user-if-unique	master	98cf52e6-6909-4bc2-b3e5-fef277f71f24	2	10	f	\N	7e461e01-9e7b-4d64-bf34-1cba149fc605
aa4fa83d-ddf5-44e5-a841-3a8d53726db4	\N	\N	master	98cf52e6-6909-4bc2-b3e5-fef277f71f24	2	20	t	87e3f020-d700-4ff9-8be6-97064ab70f52	\N
b56b1eab-0b95-4f3d-8b0a-2ef6bb7f58e8	\N	idp-confirm-link	master	87e3f020-d700-4ff9-8be6-97064ab70f52	0	10	f	\N	\N
ecd0775f-2847-4d4f-be96-ca20f1ce300c	\N	\N	master	87e3f020-d700-4ff9-8be6-97064ab70f52	0	20	t	d624dc45-7a2e-4c98-945d-f060b9bd909b	\N
fca706a1-6d70-4d8c-8bd3-bc37057034e1	\N	idp-email-verification	master	d624dc45-7a2e-4c98-945d-f060b9bd909b	2	10	f	\N	\N
812eafed-9d2d-4b48-ad7f-2308f3d62cab	\N	\N	master	d624dc45-7a2e-4c98-945d-f060b9bd909b	2	20	t	d1a05460-9906-461c-b42d-79b1f8f3400f	\N
20cfa904-dbf7-4f8a-bf35-a1972f8ebe50	\N	idp-username-password-form	master	d1a05460-9906-461c-b42d-79b1f8f3400f	0	10	f	\N	\N
133373db-1d3f-447d-af02-dc0aea09303c	\N	\N	master	d1a05460-9906-461c-b42d-79b1f8f3400f	1	20	t	2502e9aa-c040-4b80-a59c-e294a71cac8d	\N
1eb753fc-8436-4bd5-95e9-beb4992de765	\N	conditional-user-configured	master	2502e9aa-c040-4b80-a59c-e294a71cac8d	0	10	f	\N	\N
29a505ce-25ae-4301-a9e2-a2a84a48e65a	\N	auth-otp-form	master	2502e9aa-c040-4b80-a59c-e294a71cac8d	0	20	f	\N	\N
22d2ecf2-b4c5-43a7-8982-5a007fea81e0	\N	http-basic-authenticator	master	8f176e75-b044-45e1-8ff7-b7098d261b22	0	10	f	\N	\N
49e9b69b-47bd-4ab0-8d23-93a6f79e755e	\N	docker-http-basic-authenticator	master	50b1df1c-0a6f-45f9-aaf7-b857609f9f56	0	10	f	\N	\N
d33e1b2c-f8f1-47be-b5d5-350bc15727ce	\N	no-cookie-redirect	master	7392652c-d5ad-43cb-8a6a-997c546c7d13	0	10	f	\N	\N
1384e9cc-08fb-4523-9c9c-9fa5cc740a35	\N	\N	master	7392652c-d5ad-43cb-8a6a-997c546c7d13	0	20	t	1120130e-e159-4ef0-847e-ceddb4059cab	\N
b6e37fbc-b347-4392-a582-5fe79bf95e3e	\N	basic-auth	master	1120130e-e159-4ef0-847e-ceddb4059cab	0	10	f	\N	\N
eb4e87d0-af0e-4fac-88ea-692d2eeff9fa	\N	basic-auth-otp	master	1120130e-e159-4ef0-847e-ceddb4059cab	3	20	f	\N	\N
dab826d6-3ccc-4f82-9574-946374c891b8	\N	auth-spnego	master	1120130e-e159-4ef0-847e-ceddb4059cab	3	30	f	\N	\N
c855cdcb-87f6-49e2-8da9-c744a3ee8e1f	\N	auth-cookie	SpringBootKeycloak	1d558401-0aa7-4ff6-a92f-cb2abb45e926	2	10	f	\N	\N
ed4b96e0-9bc6-4713-8dbe-8c808b15c3cf	\N	auth-spnego	SpringBootKeycloak	1d558401-0aa7-4ff6-a92f-cb2abb45e926	3	20	f	\N	\N
df17dddf-a126-4e0d-a79c-89308e65e307	\N	identity-provider-redirector	SpringBootKeycloak	1d558401-0aa7-4ff6-a92f-cb2abb45e926	2	25	f	\N	\N
d2d662b9-22ef-4b38-a2b4-338cb14f43d8	\N	\N	SpringBootKeycloak	1d558401-0aa7-4ff6-a92f-cb2abb45e926	2	30	t	39a22ac4-00a4-4f1a-917b-2852d20c9bd2	\N
e91d4e8c-ce6b-41ff-b167-fcbc2d0dfde9	\N	auth-username-password-form	SpringBootKeycloak	39a22ac4-00a4-4f1a-917b-2852d20c9bd2	0	10	f	\N	\N
b2f8ed0b-e1dc-4b49-b044-7bde335f42bf	\N	\N	SpringBootKeycloak	39a22ac4-00a4-4f1a-917b-2852d20c9bd2	1	20	t	d8943bcf-9cf9-4605-a26e-b1aeedcbbe3f	\N
ab713030-3477-4a32-881a-69304c4f83d5	\N	conditional-user-configured	SpringBootKeycloak	d8943bcf-9cf9-4605-a26e-b1aeedcbbe3f	0	10	f	\N	\N
5a7652a0-8108-4d09-a224-60455c31280f	\N	auth-otp-form	SpringBootKeycloak	d8943bcf-9cf9-4605-a26e-b1aeedcbbe3f	0	20	f	\N	\N
ef52ec5a-bd84-4e9f-a82f-9bba4c4ca013	\N	direct-grant-validate-username	SpringBootKeycloak	bd5495ef-cc38-4f77-9bb8-d254aa320673	0	10	f	\N	\N
968411f8-a37f-4150-83b2-f06a24cac9d8	\N	direct-grant-validate-password	SpringBootKeycloak	bd5495ef-cc38-4f77-9bb8-d254aa320673	0	20	f	\N	\N
3765d066-a29d-4ea2-9f46-f262d20e4a73	\N	\N	SpringBootKeycloak	bd5495ef-cc38-4f77-9bb8-d254aa320673	1	30	t	f4da7e64-374e-4b44-9681-d5b2af90a30d	\N
1576751e-b9bf-45a2-98bb-5a404c902915	\N	conditional-user-configured	SpringBootKeycloak	f4da7e64-374e-4b44-9681-d5b2af90a30d	0	10	f	\N	\N
a7f17aef-3c02-4fd1-ac13-a6e4ee84a889	\N	direct-grant-validate-otp	SpringBootKeycloak	f4da7e64-374e-4b44-9681-d5b2af90a30d	0	20	f	\N	\N
856c1545-aca8-45c6-b321-305b0c11c5fe	\N	registration-page-form	SpringBootKeycloak	7d9b84f5-b4de-46ef-ae61-1aae9c1e63ad	0	10	t	195610ac-697d-489f-938d-7c6b0cdde621	\N
e7c6e622-9eb0-4d39-86c1-47b985a97994	\N	registration-user-creation	SpringBootKeycloak	195610ac-697d-489f-938d-7c6b0cdde621	0	20	f	\N	\N
f96f4ec9-2280-45df-b141-36cb5c6aafcf	\N	registration-profile-action	SpringBootKeycloak	195610ac-697d-489f-938d-7c6b0cdde621	0	40	f	\N	\N
02c00093-278e-4610-a302-f3e18b5db1a2	\N	registration-password-action	SpringBootKeycloak	195610ac-697d-489f-938d-7c6b0cdde621	0	50	f	\N	\N
685eebc9-91e6-4684-9dbc-64eb0d13e02f	\N	registration-recaptcha-action	SpringBootKeycloak	195610ac-697d-489f-938d-7c6b0cdde621	3	60	f	\N	\N
06ce9610-d54a-4dc2-b81a-9f5b0b2b3be9	\N	reset-credentials-choose-user	SpringBootKeycloak	e9e28535-a132-486d-b9e5-40967be2ef3c	0	10	f	\N	\N
ee1f2101-0e24-42f6-be98-264148d9f327	\N	reset-credential-email	SpringBootKeycloak	e9e28535-a132-486d-b9e5-40967be2ef3c	0	20	f	\N	\N
7203a8ac-cbba-4b75-bf2f-244fc1bdf4b6	\N	reset-password	SpringBootKeycloak	e9e28535-a132-486d-b9e5-40967be2ef3c	0	30	f	\N	\N
378d3e48-d8a3-4750-beef-5528d57a1cec	\N	\N	SpringBootKeycloak	e9e28535-a132-486d-b9e5-40967be2ef3c	1	40	t	20ddb0e7-2ebf-49a8-8d1f-6b1f4966a764	\N
aa852117-c657-49e4-9b0a-a2aaf297fbd2	\N	conditional-user-configured	SpringBootKeycloak	20ddb0e7-2ebf-49a8-8d1f-6b1f4966a764	0	10	f	\N	\N
281a0115-6dab-40aa-8198-19293e9734eb	\N	reset-otp	SpringBootKeycloak	20ddb0e7-2ebf-49a8-8d1f-6b1f4966a764	0	20	f	\N	\N
98aa5e68-847e-4520-83c1-e6ce395b4233	\N	client-secret	SpringBootKeycloak	26153dfc-b3f9-458c-933e-1f97db10c09f	2	10	f	\N	\N
13bf2764-9915-4fb0-ab7e-7f1a2c0693b5	\N	client-jwt	SpringBootKeycloak	26153dfc-b3f9-458c-933e-1f97db10c09f	2	20	f	\N	\N
ee981cae-1565-41f8-b232-3ced77d844cd	\N	client-secret-jwt	SpringBootKeycloak	26153dfc-b3f9-458c-933e-1f97db10c09f	2	30	f	\N	\N
1912c050-61c1-4029-8af9-1d9b95d10838	\N	client-x509	SpringBootKeycloak	26153dfc-b3f9-458c-933e-1f97db10c09f	2	40	f	\N	\N
64568dff-ad38-4d78-8271-8f09aac273ff	\N	idp-review-profile	SpringBootKeycloak	e97ed5c5-afc5-4ccb-be76-7adcb66b153c	0	10	f	\N	150b38b4-5337-4a87-872e-8a885ada0084
c9db5601-497f-4b1b-8050-bd7882ec7bdc	\N	\N	SpringBootKeycloak	e97ed5c5-afc5-4ccb-be76-7adcb66b153c	0	20	t	19950827-7950-47b4-a9f3-d49419ba4a34	\N
8d9e5894-12a9-402a-bdae-465eb0c85a5f	\N	idp-create-user-if-unique	SpringBootKeycloak	19950827-7950-47b4-a9f3-d49419ba4a34	2	10	f	\N	d8d8cb16-38da-4882-834f-1a15422c65ff
1aac696f-41f0-4c2b-807e-8cee54655909	\N	\N	SpringBootKeycloak	19950827-7950-47b4-a9f3-d49419ba4a34	2	20	t	d485d90f-668e-4cdd-a370-9d32d49c1d49	\N
05d46516-5910-4142-861a-3ae3c52db15a	\N	idp-confirm-link	SpringBootKeycloak	d485d90f-668e-4cdd-a370-9d32d49c1d49	0	10	f	\N	\N
c0603fed-5d8a-46fd-8293-1094f7dfcf33	\N	\N	SpringBootKeycloak	d485d90f-668e-4cdd-a370-9d32d49c1d49	0	20	t	285a43a9-53df-4e7a-a7a4-4d21e01f568f	\N
9caa8bde-822f-4ebc-bd06-1b254f1aec23	\N	idp-email-verification	SpringBootKeycloak	285a43a9-53df-4e7a-a7a4-4d21e01f568f	2	10	f	\N	\N
b24b5065-a531-4f6c-bdfa-9a556e27ac57	\N	\N	SpringBootKeycloak	285a43a9-53df-4e7a-a7a4-4d21e01f568f	2	20	t	2e672716-aaf3-46cd-b60e-307c475b468a	\N
cc0df9f2-47a9-44b9-8295-ea6be3716855	\N	idp-username-password-form	SpringBootKeycloak	2e672716-aaf3-46cd-b60e-307c475b468a	0	10	f	\N	\N
b19744f1-a3cd-4675-9221-dc25c6e23e3e	\N	\N	SpringBootKeycloak	2e672716-aaf3-46cd-b60e-307c475b468a	1	20	t	896e1ef9-95bb-41dc-827b-eef9cf4ae79f	\N
3e5fd06c-1e05-4b79-8b6b-d19423d42d5f	\N	conditional-user-configured	SpringBootKeycloak	896e1ef9-95bb-41dc-827b-eef9cf4ae79f	0	10	f	\N	\N
0523c396-b9a1-4316-bacc-9f7cf4e9390b	\N	auth-otp-form	SpringBootKeycloak	896e1ef9-95bb-41dc-827b-eef9cf4ae79f	0	20	f	\N	\N
e091e936-4a39-40f7-a5bd-cfd16b9475be	\N	http-basic-authenticator	SpringBootKeycloak	8902c4b7-0eff-4cc2-8a0d-e54dca6c82fc	0	10	f	\N	\N
3d1d3f01-6e61-4d72-88f9-b2c13481bf16	\N	docker-http-basic-authenticator	SpringBootKeycloak	65b125d7-6c20-4329-b9e8-3b52ca81de54	0	10	f	\N	\N
ba8d9fcd-c408-47db-8200-ed349469e7f3	\N	no-cookie-redirect	SpringBootKeycloak	1d8583c7-7248-4e95-ba9d-63691f323b26	0	10	f	\N	\N
a8286547-46ef-4e7f-970f-9846b425ffff	\N	\N	SpringBootKeycloak	1d8583c7-7248-4e95-ba9d-63691f323b26	0	20	t	7b617c93-2a58-48b1-a1be-386d0608deee	\N
357fa275-dfe1-48ba-9c50-d1f1df86372f	\N	basic-auth	SpringBootKeycloak	7b617c93-2a58-48b1-a1be-386d0608deee	0	10	f	\N	\N
1b1fd403-795b-4c6d-8241-d65fcd7bb890	\N	basic-auth-otp	SpringBootKeycloak	7b617c93-2a58-48b1-a1be-386d0608deee	3	20	f	\N	\N
aaacea39-b43a-431f-8a55-827904580126	\N	auth-spnego	SpringBootKeycloak	7b617c93-2a58-48b1-a1be-386d0608deee	3	30	f	\N	\N
\.


--
-- TOC entry 3805 (class 0 OID 21380)
-- Dependencies: 241
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
7e5491f9-9087-4a4c-9ad2-6f91b7b10917	browser	browser based authentication	master	basic-flow	t	t
12b68dd8-1f72-4918-ab05-e8b15ba56523	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
90ce92a4-b769-4a03-9ffe-2386564adfa2	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
c737ea31-f9dc-49fc-beb6-404c3f7aa304	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
f5c531bd-e944-43e8-881f-1fc013b59cc3	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
aead836b-1e31-4616-a3a4-dc7a2ba36e3a	registration	registration flow	master	basic-flow	t	t
5a07a799-1507-45ad-b69d-1eb4a0ff6b88	registration form	registration form	master	form-flow	f	t
1c0a6861-fdcf-4c68-a046-b710e4895112	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
ec54b30b-eca5-46d9-9b24-dc72dd1c6584	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
32e4dc68-6969-41d6-9a34-2bd8ec480f5f	clients	Base authentication for clients	master	client-flow	t	t
8016d4b9-55e3-4ac1-be33-bc5d983af673	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
98cf52e6-6909-4bc2-b3e5-fef277f71f24	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
87e3f020-d700-4ff9-8be6-97064ab70f52	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
d624dc45-7a2e-4c98-945d-f060b9bd909b	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
d1a05460-9906-461c-b42d-79b1f8f3400f	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
2502e9aa-c040-4b80-a59c-e294a71cac8d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
8f176e75-b044-45e1-8ff7-b7098d261b22	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
50b1df1c-0a6f-45f9-aaf7-b857609f9f56	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
7392652c-d5ad-43cb-8a6a-997c546c7d13	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
1120130e-e159-4ef0-847e-ceddb4059cab	Authentication Options	Authentication options.	master	basic-flow	f	t
1d558401-0aa7-4ff6-a92f-cb2abb45e926	browser	browser based authentication	SpringBootKeycloak	basic-flow	t	t
39a22ac4-00a4-4f1a-917b-2852d20c9bd2	forms	Username, password, otp and other auth forms.	SpringBootKeycloak	basic-flow	f	t
d8943bcf-9cf9-4605-a26e-b1aeedcbbe3f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	SpringBootKeycloak	basic-flow	f	t
bd5495ef-cc38-4f77-9bb8-d254aa320673	direct grant	OpenID Connect Resource Owner Grant	SpringBootKeycloak	basic-flow	t	t
f4da7e64-374e-4b44-9681-d5b2af90a30d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	SpringBootKeycloak	basic-flow	f	t
7d9b84f5-b4de-46ef-ae61-1aae9c1e63ad	registration	registration flow	SpringBootKeycloak	basic-flow	t	t
195610ac-697d-489f-938d-7c6b0cdde621	registration form	registration form	SpringBootKeycloak	form-flow	f	t
e9e28535-a132-486d-b9e5-40967be2ef3c	reset credentials	Reset credentials for a user if they forgot their password or something	SpringBootKeycloak	basic-flow	t	t
20ddb0e7-2ebf-49a8-8d1f-6b1f4966a764	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	SpringBootKeycloak	basic-flow	f	t
26153dfc-b3f9-458c-933e-1f97db10c09f	clients	Base authentication for clients	SpringBootKeycloak	client-flow	t	t
e97ed5c5-afc5-4ccb-be76-7adcb66b153c	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	SpringBootKeycloak	basic-flow	t	t
19950827-7950-47b4-a9f3-d49419ba4a34	User creation or linking	Flow for the existing/non-existing user alternatives	SpringBootKeycloak	basic-flow	f	t
d485d90f-668e-4cdd-a370-9d32d49c1d49	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	SpringBootKeycloak	basic-flow	f	t
285a43a9-53df-4e7a-a7a4-4d21e01f568f	Account verification options	Method with which to verity the existing account	SpringBootKeycloak	basic-flow	f	t
2e672716-aaf3-46cd-b60e-307c475b468a	Verify Existing Account by Re-authentication	Reauthentication of existing account	SpringBootKeycloak	basic-flow	f	t
896e1ef9-95bb-41dc-827b-eef9cf4ae79f	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	SpringBootKeycloak	basic-flow	f	t
8902c4b7-0eff-4cc2-8a0d-e54dca6c82fc	saml ecp	SAML ECP Profile Authentication Flow	SpringBootKeycloak	basic-flow	t	t
65b125d7-6c20-4329-b9e8-3b52ca81de54	docker auth	Used by Docker clients to authenticate against the IDP	SpringBootKeycloak	basic-flow	t	t
1d8583c7-7248-4e95-ba9d-63691f323b26	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	SpringBootKeycloak	basic-flow	t	t
7b617c93-2a58-48b1-a1be-386d0608deee	Authentication Options	Authentication options.	SpringBootKeycloak	basic-flow	f	t
\.


--
-- TOC entry 3804 (class 0 OID 21374)
-- Dependencies: 240
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
0f22d9e4-07fa-429b-9786-7ecb522694bd	review profile config	master
7e461e01-9e7b-4d64-bf34-1cba149fc605	create unique user config	master
150b38b4-5337-4a87-872e-8a885ada0084	review profile config	SpringBootKeycloak
d8d8cb16-38da-4882-834f-1a15422c65ff	create unique user config	SpringBootKeycloak
\.


--
-- TOC entry 3807 (class 0 OID 21391)
-- Dependencies: 243
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
0f22d9e4-07fa-429b-9786-7ecb522694bd	missing	update.profile.on.first.login
7e461e01-9e7b-4d64-bf34-1cba149fc605	false	require.password.update.after.registration
150b38b4-5337-4a87-872e-8a885ada0084	missing	update.profile.on.first.login
d8d8cb16-38da-4882-834f-1a15422c65ff	false	require.password.update.after.registration
\.


--
-- TOC entry 3833 (class 0 OID 21846)
-- Dependencies: 269
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 3763 (class 0 OID 20723)
-- Dependencies: 199
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	t	master-realm	0	f	f2c63bab-148b-4898-9a44-859f8dabab8f	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
335fff2e-b205-4fdd-8600-f87a2ba4c930	t	f	account	0	f	ac49ff68-bf5d-451c-86a2-25d2d2409444	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2838a207-e8bd-472c-b530-4aa5e8e8799f	t	f	account-console	0	t	a69e0774-04cd-45b7-8299-af07f4baa7a0	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
becec056-0b5c-44f0-a38c-be3c2bbc3f21	t	f	broker	0	f	eb1c4e6d-b1c5-43ac-986a-f2428905e57e	\N	f	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
464a276e-f380-4188-bb97-91a65aadd58f	t	f	security-admin-console	0	t	c60a2ea5-381e-445d-823a-cbf81eb1dad5	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	t	f	admin-cli	0	t	5b2dfb2c-db76-40ed-bf1f-c4c36aed9d09	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
88970e97-34e2-4296-bfbc-4996d44813c1	t	t	SpringBootKeycloak-realm	0	f	9503fd4e-0526-4719-8b3e-714cfea0286c	\N	t	\N	f	master	\N	0	f	f	SpringBootKeycloak Realm	f	client-secret	\N	\N	\N	t	f	f	f
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	f	realm-management	0	f	32322dde-28e5-4296-9a23-2f016030871e	\N	t	\N	f	SpringBootKeycloak	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
25f1c990-8983-4f82-ac2c-335368c68457	t	f	account	0	f	d063f551-74ec-447c-96a8-8690b20d8edb	/realms/SpringBootKeycloak/account/	f	\N	f	SpringBootKeycloak	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
c536097d-46a6-4ffb-abd5-20aa7403d251	t	f	account-console	0	t	871f9e1b-2013-49ef-8ed7-8c328c2a1d0e	/realms/SpringBootKeycloak/account/	f	\N	f	SpringBootKeycloak	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	t	f	broker	0	f	e972443a-1b84-480b-9939-9d0970cdfcb7	\N	f	\N	f	SpringBootKeycloak	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
8d3fee78-8370-4abb-8753-0772dea06afc	t	f	security-admin-console	0	t	7252826a-9c9f-4365-a82e-6303cf3c72a9	/admin/SpringBootKeycloak/console/	f	\N	f	SpringBootKeycloak	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	t	f	admin-cli	0	t	442014eb-dcf2-4e6d-9839-cd5b29b2423f	\N	f	\N	f	SpringBootKeycloak	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	t	t	shogun-app	0	t	9163166a-aa98-49cf-a863-ca773af38f18	\N	f	\N	f	SpringBootKeycloak	openid-connect	-1	f	f	\N	f	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- TOC entry 3787 (class 0 OID 21097)
-- Dependencies: 223
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
2838a207-e8bd-472c-b530-4aa5e8e8799f	S256	pkce.code.challenge.method
464a276e-f380-4188-bb97-91a65aadd58f	S256	pkce.code.challenge.method
c536097d-46a6-4ffb-abd5-20aa7403d251	S256	pkce.code.challenge.method
8d3fee78-8370-4abb-8753-0772dea06afc	S256	pkce.code.challenge.method
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml.server.signature
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml.server.signature.keyinfo.ext
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml.assertion.signature
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml.client.signature
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml.encrypt
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml.authnstatement
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml.onetimeuse.condition
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml_force_name_id_format
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml.multivalued.roles
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	saml.force.post.binding
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	exclude.session.state.from.auth.response
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	tls.client.certificate.bound.access.tokens
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	false	display.on.consent.screen
\.


--
-- TOC entry 3844 (class 0 OID 22105)
-- Dependencies: 280
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- TOC entry 3762 (class 0 OID 20720)
-- Dependencies: 198
-- Data for Name: client_default_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_default_roles (client_id, role_id) FROM stdin;
335fff2e-b205-4fdd-8600-f87a2ba4c930	3ecc9bc3-bc92-4e24-8cd8-a417039e8b8b
335fff2e-b205-4fdd-8600-f87a2ba4c930	d2d4716c-16e6-4dd3-a6b3-a5bc53945ff5
25f1c990-8983-4f82-ac2c-335368c68457	d97fb25a-d8e8-4d55-aabc-489ffdc0e576
25f1c990-8983-4f82-ac2c-335368c68457	a30db9ce-a621-4acf-8c7a-d91468d7d8c9
\.


--
-- TOC entry 3843 (class 0 OID 21980)
-- Dependencies: 279
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- TOC entry 3789 (class 0 OID 21109)
-- Dependencies: 225
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- TOC entry 3821 (class 0 OID 21629)
-- Dependencies: 257
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
d894a28e-1d9c-41da-bdf7-5408d184f22e	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
30ffadc7-5ecd-463f-93ce-2a57e32dfb66	role_list	master	SAML role list	saml
f7f00bb7-1d8f-4e94-90d7-9902bf39a503	profile	master	OpenID Connect built-in scope: profile	openid-connect
6943da30-3e63-4254-8668-97aff9ecbdc3	email	master	OpenID Connect built-in scope: email	openid-connect
216918b6-e49c-4398-99cc-5b7004b618b5	address	master	OpenID Connect built-in scope: address	openid-connect
f12c60e4-655d-44ef-9bf1-fb9247a6b634	phone	master	OpenID Connect built-in scope: phone	openid-connect
18e8eb55-cdab-48ec-b509-f97659669327	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
a18f35dd-3e19-42c0-aa01-9d41078642f6	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
ebb5ce8c-b63d-4a46-902a-668873fc2ab9	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
f4fb089e-80a9-48f7-bf50-75bca1279696	offline_access	SpringBootKeycloak	OpenID Connect built-in scope: offline_access	openid-connect
9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	role_list	SpringBootKeycloak	SAML role list	saml
1eb31e46-1a19-4937-83f6-9cb8e079e47f	profile	SpringBootKeycloak	OpenID Connect built-in scope: profile	openid-connect
c9a0646f-a17b-4efe-b678-ff97b200adeb	email	SpringBootKeycloak	OpenID Connect built-in scope: email	openid-connect
de5865df-f1b0-4c1c-9a0b-26374cec52cc	address	SpringBootKeycloak	OpenID Connect built-in scope: address	openid-connect
1890ab4e-72c5-406f-8e78-6bdcf15ae09b	phone	SpringBootKeycloak	OpenID Connect built-in scope: phone	openid-connect
a7d14333-728d-461d-a865-32ee7040a601	roles	SpringBootKeycloak	OpenID Connect scope for add user roles to the access token	openid-connect
1891fce2-87a3-4ea3-a365-1af7f1425ccd	web-origins	SpringBootKeycloak	OpenID Connect scope for add allowed web origins to the access token	openid-connect
f6e4b664-06bb-4980-9444-9e077ac85e6f	microprofile-jwt	SpringBootKeycloak	Microprofile - JWT built-in scope	openid-connect
\.


--
-- TOC entry 3822 (class 0 OID 21644)
-- Dependencies: 258
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
d894a28e-1d9c-41da-bdf7-5408d184f22e	true	display.on.consent.screen
d894a28e-1d9c-41da-bdf7-5408d184f22e	${offlineAccessScopeConsentText}	consent.screen.text
30ffadc7-5ecd-463f-93ce-2a57e32dfb66	true	display.on.consent.screen
30ffadc7-5ecd-463f-93ce-2a57e32dfb66	${samlRoleListScopeConsentText}	consent.screen.text
f7f00bb7-1d8f-4e94-90d7-9902bf39a503	true	display.on.consent.screen
f7f00bb7-1d8f-4e94-90d7-9902bf39a503	${profileScopeConsentText}	consent.screen.text
f7f00bb7-1d8f-4e94-90d7-9902bf39a503	true	include.in.token.scope
6943da30-3e63-4254-8668-97aff9ecbdc3	true	display.on.consent.screen
6943da30-3e63-4254-8668-97aff9ecbdc3	${emailScopeConsentText}	consent.screen.text
6943da30-3e63-4254-8668-97aff9ecbdc3	true	include.in.token.scope
216918b6-e49c-4398-99cc-5b7004b618b5	true	display.on.consent.screen
216918b6-e49c-4398-99cc-5b7004b618b5	${addressScopeConsentText}	consent.screen.text
216918b6-e49c-4398-99cc-5b7004b618b5	true	include.in.token.scope
f12c60e4-655d-44ef-9bf1-fb9247a6b634	true	display.on.consent.screen
f12c60e4-655d-44ef-9bf1-fb9247a6b634	${phoneScopeConsentText}	consent.screen.text
f12c60e4-655d-44ef-9bf1-fb9247a6b634	true	include.in.token.scope
18e8eb55-cdab-48ec-b509-f97659669327	true	display.on.consent.screen
18e8eb55-cdab-48ec-b509-f97659669327	${rolesScopeConsentText}	consent.screen.text
18e8eb55-cdab-48ec-b509-f97659669327	false	include.in.token.scope
a18f35dd-3e19-42c0-aa01-9d41078642f6	false	display.on.consent.screen
a18f35dd-3e19-42c0-aa01-9d41078642f6		consent.screen.text
a18f35dd-3e19-42c0-aa01-9d41078642f6	false	include.in.token.scope
ebb5ce8c-b63d-4a46-902a-668873fc2ab9	false	display.on.consent.screen
ebb5ce8c-b63d-4a46-902a-668873fc2ab9	true	include.in.token.scope
f4fb089e-80a9-48f7-bf50-75bca1279696	true	display.on.consent.screen
f4fb089e-80a9-48f7-bf50-75bca1279696	${offlineAccessScopeConsentText}	consent.screen.text
9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	true	display.on.consent.screen
9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	${samlRoleListScopeConsentText}	consent.screen.text
1eb31e46-1a19-4937-83f6-9cb8e079e47f	true	display.on.consent.screen
1eb31e46-1a19-4937-83f6-9cb8e079e47f	${profileScopeConsentText}	consent.screen.text
1eb31e46-1a19-4937-83f6-9cb8e079e47f	true	include.in.token.scope
c9a0646f-a17b-4efe-b678-ff97b200adeb	true	display.on.consent.screen
c9a0646f-a17b-4efe-b678-ff97b200adeb	${emailScopeConsentText}	consent.screen.text
c9a0646f-a17b-4efe-b678-ff97b200adeb	true	include.in.token.scope
de5865df-f1b0-4c1c-9a0b-26374cec52cc	true	display.on.consent.screen
de5865df-f1b0-4c1c-9a0b-26374cec52cc	${addressScopeConsentText}	consent.screen.text
de5865df-f1b0-4c1c-9a0b-26374cec52cc	true	include.in.token.scope
1890ab4e-72c5-406f-8e78-6bdcf15ae09b	true	display.on.consent.screen
1890ab4e-72c5-406f-8e78-6bdcf15ae09b	${phoneScopeConsentText}	consent.screen.text
1890ab4e-72c5-406f-8e78-6bdcf15ae09b	true	include.in.token.scope
a7d14333-728d-461d-a865-32ee7040a601	true	display.on.consent.screen
a7d14333-728d-461d-a865-32ee7040a601	${rolesScopeConsentText}	consent.screen.text
a7d14333-728d-461d-a865-32ee7040a601	false	include.in.token.scope
1891fce2-87a3-4ea3-a365-1af7f1425ccd	false	display.on.consent.screen
1891fce2-87a3-4ea3-a365-1af7f1425ccd		consent.screen.text
1891fce2-87a3-4ea3-a365-1af7f1425ccd	false	include.in.token.scope
f6e4b664-06bb-4980-9444-9e077ac85e6f	false	display.on.consent.screen
f6e4b664-06bb-4980-9444-9e077ac85e6f	true	include.in.token.scope
\.


--
-- TOC entry 3845 (class 0 OID 22147)
-- Dependencies: 281
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
335fff2e-b205-4fdd-8600-f87a2ba4c930	30ffadc7-5ecd-463f-93ce-2a57e32dfb66	t
2838a207-e8bd-472c-b530-4aa5e8e8799f	30ffadc7-5ecd-463f-93ce-2a57e32dfb66	t
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	30ffadc7-5ecd-463f-93ce-2a57e32dfb66	t
becec056-0b5c-44f0-a38c-be3c2bbc3f21	30ffadc7-5ecd-463f-93ce-2a57e32dfb66	t
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	30ffadc7-5ecd-463f-93ce-2a57e32dfb66	t
464a276e-f380-4188-bb97-91a65aadd58f	30ffadc7-5ecd-463f-93ce-2a57e32dfb66	t
335fff2e-b205-4fdd-8600-f87a2ba4c930	f7f00bb7-1d8f-4e94-90d7-9902bf39a503	t
335fff2e-b205-4fdd-8600-f87a2ba4c930	6943da30-3e63-4254-8668-97aff9ecbdc3	t
335fff2e-b205-4fdd-8600-f87a2ba4c930	18e8eb55-cdab-48ec-b509-f97659669327	t
335fff2e-b205-4fdd-8600-f87a2ba4c930	a18f35dd-3e19-42c0-aa01-9d41078642f6	t
335fff2e-b205-4fdd-8600-f87a2ba4c930	d894a28e-1d9c-41da-bdf7-5408d184f22e	f
335fff2e-b205-4fdd-8600-f87a2ba4c930	216918b6-e49c-4398-99cc-5b7004b618b5	f
335fff2e-b205-4fdd-8600-f87a2ba4c930	f12c60e4-655d-44ef-9bf1-fb9247a6b634	f
335fff2e-b205-4fdd-8600-f87a2ba4c930	ebb5ce8c-b63d-4a46-902a-668873fc2ab9	f
2838a207-e8bd-472c-b530-4aa5e8e8799f	f7f00bb7-1d8f-4e94-90d7-9902bf39a503	t
2838a207-e8bd-472c-b530-4aa5e8e8799f	6943da30-3e63-4254-8668-97aff9ecbdc3	t
2838a207-e8bd-472c-b530-4aa5e8e8799f	18e8eb55-cdab-48ec-b509-f97659669327	t
2838a207-e8bd-472c-b530-4aa5e8e8799f	a18f35dd-3e19-42c0-aa01-9d41078642f6	t
2838a207-e8bd-472c-b530-4aa5e8e8799f	d894a28e-1d9c-41da-bdf7-5408d184f22e	f
2838a207-e8bd-472c-b530-4aa5e8e8799f	216918b6-e49c-4398-99cc-5b7004b618b5	f
2838a207-e8bd-472c-b530-4aa5e8e8799f	f12c60e4-655d-44ef-9bf1-fb9247a6b634	f
2838a207-e8bd-472c-b530-4aa5e8e8799f	ebb5ce8c-b63d-4a46-902a-668873fc2ab9	f
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	f7f00bb7-1d8f-4e94-90d7-9902bf39a503	t
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	6943da30-3e63-4254-8668-97aff9ecbdc3	t
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	18e8eb55-cdab-48ec-b509-f97659669327	t
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	a18f35dd-3e19-42c0-aa01-9d41078642f6	t
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	d894a28e-1d9c-41da-bdf7-5408d184f22e	f
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	216918b6-e49c-4398-99cc-5b7004b618b5	f
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	f12c60e4-655d-44ef-9bf1-fb9247a6b634	f
7d9283cf-cf7e-42f0-bcfc-daa053fd3def	ebb5ce8c-b63d-4a46-902a-668873fc2ab9	f
becec056-0b5c-44f0-a38c-be3c2bbc3f21	f7f00bb7-1d8f-4e94-90d7-9902bf39a503	t
becec056-0b5c-44f0-a38c-be3c2bbc3f21	6943da30-3e63-4254-8668-97aff9ecbdc3	t
becec056-0b5c-44f0-a38c-be3c2bbc3f21	18e8eb55-cdab-48ec-b509-f97659669327	t
becec056-0b5c-44f0-a38c-be3c2bbc3f21	a18f35dd-3e19-42c0-aa01-9d41078642f6	t
becec056-0b5c-44f0-a38c-be3c2bbc3f21	d894a28e-1d9c-41da-bdf7-5408d184f22e	f
becec056-0b5c-44f0-a38c-be3c2bbc3f21	216918b6-e49c-4398-99cc-5b7004b618b5	f
becec056-0b5c-44f0-a38c-be3c2bbc3f21	f12c60e4-655d-44ef-9bf1-fb9247a6b634	f
becec056-0b5c-44f0-a38c-be3c2bbc3f21	ebb5ce8c-b63d-4a46-902a-668873fc2ab9	f
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	f7f00bb7-1d8f-4e94-90d7-9902bf39a503	t
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	6943da30-3e63-4254-8668-97aff9ecbdc3	t
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	18e8eb55-cdab-48ec-b509-f97659669327	t
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	a18f35dd-3e19-42c0-aa01-9d41078642f6	t
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	d894a28e-1d9c-41da-bdf7-5408d184f22e	f
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	216918b6-e49c-4398-99cc-5b7004b618b5	f
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	f12c60e4-655d-44ef-9bf1-fb9247a6b634	f
9e1fe29c-0379-4c0a-9fa8-11b308cef13b	ebb5ce8c-b63d-4a46-902a-668873fc2ab9	f
464a276e-f380-4188-bb97-91a65aadd58f	f7f00bb7-1d8f-4e94-90d7-9902bf39a503	t
464a276e-f380-4188-bb97-91a65aadd58f	6943da30-3e63-4254-8668-97aff9ecbdc3	t
464a276e-f380-4188-bb97-91a65aadd58f	18e8eb55-cdab-48ec-b509-f97659669327	t
464a276e-f380-4188-bb97-91a65aadd58f	a18f35dd-3e19-42c0-aa01-9d41078642f6	t
464a276e-f380-4188-bb97-91a65aadd58f	d894a28e-1d9c-41da-bdf7-5408d184f22e	f
464a276e-f380-4188-bb97-91a65aadd58f	216918b6-e49c-4398-99cc-5b7004b618b5	f
464a276e-f380-4188-bb97-91a65aadd58f	f12c60e4-655d-44ef-9bf1-fb9247a6b634	f
464a276e-f380-4188-bb97-91a65aadd58f	ebb5ce8c-b63d-4a46-902a-668873fc2ab9	f
88970e97-34e2-4296-bfbc-4996d44813c1	30ffadc7-5ecd-463f-93ce-2a57e32dfb66	t
88970e97-34e2-4296-bfbc-4996d44813c1	f7f00bb7-1d8f-4e94-90d7-9902bf39a503	t
88970e97-34e2-4296-bfbc-4996d44813c1	6943da30-3e63-4254-8668-97aff9ecbdc3	t
88970e97-34e2-4296-bfbc-4996d44813c1	18e8eb55-cdab-48ec-b509-f97659669327	t
88970e97-34e2-4296-bfbc-4996d44813c1	a18f35dd-3e19-42c0-aa01-9d41078642f6	t
88970e97-34e2-4296-bfbc-4996d44813c1	d894a28e-1d9c-41da-bdf7-5408d184f22e	f
88970e97-34e2-4296-bfbc-4996d44813c1	216918b6-e49c-4398-99cc-5b7004b618b5	f
88970e97-34e2-4296-bfbc-4996d44813c1	f12c60e4-655d-44ef-9bf1-fb9247a6b634	f
88970e97-34e2-4296-bfbc-4996d44813c1	ebb5ce8c-b63d-4a46-902a-668873fc2ab9	f
25f1c990-8983-4f82-ac2c-335368c68457	9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	t
c536097d-46a6-4ffb-abd5-20aa7403d251	9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	t
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	t
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	t
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	t
8d3fee78-8370-4abb-8753-0772dea06afc	9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	t
25f1c990-8983-4f82-ac2c-335368c68457	1eb31e46-1a19-4937-83f6-9cb8e079e47f	t
25f1c990-8983-4f82-ac2c-335368c68457	c9a0646f-a17b-4efe-b678-ff97b200adeb	t
25f1c990-8983-4f82-ac2c-335368c68457	a7d14333-728d-461d-a865-32ee7040a601	t
25f1c990-8983-4f82-ac2c-335368c68457	1891fce2-87a3-4ea3-a365-1af7f1425ccd	t
25f1c990-8983-4f82-ac2c-335368c68457	f4fb089e-80a9-48f7-bf50-75bca1279696	f
25f1c990-8983-4f82-ac2c-335368c68457	de5865df-f1b0-4c1c-9a0b-26374cec52cc	f
25f1c990-8983-4f82-ac2c-335368c68457	1890ab4e-72c5-406f-8e78-6bdcf15ae09b	f
25f1c990-8983-4f82-ac2c-335368c68457	f6e4b664-06bb-4980-9444-9e077ac85e6f	f
c536097d-46a6-4ffb-abd5-20aa7403d251	1eb31e46-1a19-4937-83f6-9cb8e079e47f	t
c536097d-46a6-4ffb-abd5-20aa7403d251	c9a0646f-a17b-4efe-b678-ff97b200adeb	t
c536097d-46a6-4ffb-abd5-20aa7403d251	a7d14333-728d-461d-a865-32ee7040a601	t
c536097d-46a6-4ffb-abd5-20aa7403d251	1891fce2-87a3-4ea3-a365-1af7f1425ccd	t
c536097d-46a6-4ffb-abd5-20aa7403d251	f4fb089e-80a9-48f7-bf50-75bca1279696	f
c536097d-46a6-4ffb-abd5-20aa7403d251	de5865df-f1b0-4c1c-9a0b-26374cec52cc	f
c536097d-46a6-4ffb-abd5-20aa7403d251	1890ab4e-72c5-406f-8e78-6bdcf15ae09b	f
c536097d-46a6-4ffb-abd5-20aa7403d251	f6e4b664-06bb-4980-9444-9e077ac85e6f	f
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	1eb31e46-1a19-4937-83f6-9cb8e079e47f	t
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	c9a0646f-a17b-4efe-b678-ff97b200adeb	t
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	a7d14333-728d-461d-a865-32ee7040a601	t
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	1891fce2-87a3-4ea3-a365-1af7f1425ccd	t
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	f4fb089e-80a9-48f7-bf50-75bca1279696	f
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	de5865df-f1b0-4c1c-9a0b-26374cec52cc	f
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	1890ab4e-72c5-406f-8e78-6bdcf15ae09b	f
d2cf6f78-9787-43d7-ba9c-6c2f4974fc66	f6e4b664-06bb-4980-9444-9e077ac85e6f	f
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	1eb31e46-1a19-4937-83f6-9cb8e079e47f	t
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	c9a0646f-a17b-4efe-b678-ff97b200adeb	t
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	a7d14333-728d-461d-a865-32ee7040a601	t
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	1891fce2-87a3-4ea3-a365-1af7f1425ccd	t
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	f4fb089e-80a9-48f7-bf50-75bca1279696	f
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	de5865df-f1b0-4c1c-9a0b-26374cec52cc	f
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	1890ab4e-72c5-406f-8e78-6bdcf15ae09b	f
2cc1ecd1-62c4-4163-8a89-08225ceae2b2	f6e4b664-06bb-4980-9444-9e077ac85e6f	f
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	1eb31e46-1a19-4937-83f6-9cb8e079e47f	t
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	c9a0646f-a17b-4efe-b678-ff97b200adeb	t
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	a7d14333-728d-461d-a865-32ee7040a601	t
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	1891fce2-87a3-4ea3-a365-1af7f1425ccd	t
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	f4fb089e-80a9-48f7-bf50-75bca1279696	f
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	de5865df-f1b0-4c1c-9a0b-26374cec52cc	f
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	1890ab4e-72c5-406f-8e78-6bdcf15ae09b	f
2311b4a7-04c7-4e9e-b67d-783a3098ed4c	f6e4b664-06bb-4980-9444-9e077ac85e6f	f
8d3fee78-8370-4abb-8753-0772dea06afc	1eb31e46-1a19-4937-83f6-9cb8e079e47f	t
8d3fee78-8370-4abb-8753-0772dea06afc	c9a0646f-a17b-4efe-b678-ff97b200adeb	t
8d3fee78-8370-4abb-8753-0772dea06afc	a7d14333-728d-461d-a865-32ee7040a601	t
8d3fee78-8370-4abb-8753-0772dea06afc	1891fce2-87a3-4ea3-a365-1af7f1425ccd	t
8d3fee78-8370-4abb-8753-0772dea06afc	f4fb089e-80a9-48f7-bf50-75bca1279696	f
8d3fee78-8370-4abb-8753-0772dea06afc	de5865df-f1b0-4c1c-9a0b-26374cec52cc	f
8d3fee78-8370-4abb-8753-0772dea06afc	1890ab4e-72c5-406f-8e78-6bdcf15ae09b	f
8d3fee78-8370-4abb-8753-0772dea06afc	f6e4b664-06bb-4980-9444-9e077ac85e6f	f
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	t
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	1eb31e46-1a19-4937-83f6-9cb8e079e47f	t
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	c9a0646f-a17b-4efe-b678-ff97b200adeb	t
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	a7d14333-728d-461d-a865-32ee7040a601	t
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	1891fce2-87a3-4ea3-a365-1af7f1425ccd	t
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	f4fb089e-80a9-48f7-bf50-75bca1279696	f
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	de5865df-f1b0-4c1c-9a0b-26374cec52cc	f
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	1890ab4e-72c5-406f-8e78-6bdcf15ae09b	f
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	f6e4b664-06bb-4980-9444-9e077ac85e6f	f
\.


--
-- TOC entry 3823 (class 0 OID 21650)
-- Dependencies: 259
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
d894a28e-1d9c-41da-bdf7-5408d184f22e	fbb73b9b-139a-4397-95b9-330f88bee545
f4fb089e-80a9-48f7-bf50-75bca1279696	3218a301-b54c-4b46-adba-02d293af190e
\.


--
-- TOC entry 3764 (class 0 OID 20735)
-- Dependencies: 200
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- TOC entry 3810 (class 0 OID 21412)
-- Dependencies: 246
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- TOC entry 3788 (class 0 OID 21103)
-- Dependencies: 224
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 3802 (class 0 OID 21290)
-- Dependencies: 238
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- TOC entry 3765 (class 0 OID 20741)
-- Dependencies: 201
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- TOC entry 3811 (class 0 OID 21493)
-- Dependencies: 247
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 3841 (class 0 OID 21896)
-- Dependencies: 277
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
e4b8eee2-b7e1-40b6-9edb-a77f2e16e7ef	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
1076585d-67f4-4d21-a3e7-c08eaac5e5a3	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
407574e3-1cb4-4214-9edb-bc28536ca87b	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
ee4c6bfe-1c23-4064-89a4-a46189a021b8	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
d46e2db1-c793-4810-bb62-622f5ef2ab08	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
4e8567d1-a525-482d-bdbc-1551314ae02a	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
39db9c45-84e6-418a-9b41-54885bf6e2e3	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
aa3e2c6b-c0da-4621-9f70-de86eaeeccc4	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
2cedfba4-19a8-49b7-b669-2786d78a59cb	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
01a02236-6985-40f2-83de-40ef9fae7b0e	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
2bf3736e-82f3-4d31-b0cf-d3c5832613ad	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
5fe95c93-af3f-44ea-ae3f-3f63f28dbfb3	rsa-generated	SpringBootKeycloak	rsa-generated	org.keycloak.keys.KeyProvider	SpringBootKeycloak	\N
74d5d2fc-a719-48f6-935e-bafeac135f8e	hmac-generated	SpringBootKeycloak	hmac-generated	org.keycloak.keys.KeyProvider	SpringBootKeycloak	\N
8e9416e1-b773-4387-9964-431393243508	aes-generated	SpringBootKeycloak	aes-generated	org.keycloak.keys.KeyProvider	SpringBootKeycloak	\N
607fa58b-3ad1-4733-bd18-ce66bc9288b5	Trusted Hosts	SpringBootKeycloak	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeycloak	anonymous
60117b58-6d38-4e9c-8caa-9987c98cec5b	Consent Required	SpringBootKeycloak	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeycloak	anonymous
93c35c97-3568-431a-8849-062afa045894	Full Scope Disabled	SpringBootKeycloak	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeycloak	anonymous
b57f722b-f9bf-496a-82e9-fca1bcb232d5	Max Clients Limit	SpringBootKeycloak	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeycloak	anonymous
23e8ff09-39ef-4e2a-9b4a-6b1b7e37d28f	Allowed Protocol Mapper Types	SpringBootKeycloak	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeycloak	anonymous
922bb9c0-151f-4f50-a4fb-04a3335dd22f	Allowed Client Scopes	SpringBootKeycloak	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeycloak	anonymous
8637ab32-aa1e-4046-b088-91d8bb76fcaa	Allowed Protocol Mapper Types	SpringBootKeycloak	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeycloak	authenticated
e0dde975-a312-4164-82be-e4dbbeb11178	Allowed Client Scopes	SpringBootKeycloak	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	SpringBootKeycloak	authenticated
\.


--
-- TOC entry 3840 (class 0 OID 21890)
-- Dependencies: 276
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
82dc10a0-77c7-4a1f-8ff0-56d6f6dfd186	d46e2db1-c793-4810-bb62-622f5ef2ab08	allowed-protocol-mapper-types	oidc-address-mapper
1a743fd0-a304-4464-a550-a9cbe533cba9	d46e2db1-c793-4810-bb62-622f5ef2ab08	allowed-protocol-mapper-types	saml-role-list-mapper
53f0d896-450c-46b1-bca6-c91a6e4566ce	d46e2db1-c793-4810-bb62-622f5ef2ab08	allowed-protocol-mapper-types	saml-user-attribute-mapper
9ff23c5b-94db-4312-a91f-b6711b0cbd3d	d46e2db1-c793-4810-bb62-622f5ef2ab08	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
c37009b4-bd76-4737-a7fa-e78de18de475	d46e2db1-c793-4810-bb62-622f5ef2ab08	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d5be8118-7c8e-4200-89d1-6fc5ea7f1858	d46e2db1-c793-4810-bb62-622f5ef2ab08	allowed-protocol-mapper-types	saml-user-property-mapper
0fbc1000-3000-4b50-92be-78d93e780e31	d46e2db1-c793-4810-bb62-622f5ef2ab08	allowed-protocol-mapper-types	oidc-full-name-mapper
fcd1d53b-69d3-4b4a-84fb-0d225d0fff00	d46e2db1-c793-4810-bb62-622f5ef2ab08	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
b36dbead-daf7-4739-bce7-7be9f7c4827d	e4b8eee2-b7e1-40b6-9edb-a77f2e16e7ef	host-sending-registration-request-must-match	true
9cd22c67-1a9f-4d52-b7d1-d56ab89d92a7	e4b8eee2-b7e1-40b6-9edb-a77f2e16e7ef	client-uris-must-match	true
2bc2d949-f690-46e6-9798-63a62083cf1c	4e8567d1-a525-482d-bdbc-1551314ae02a	allow-default-scopes	true
05fe7425-404d-41b1-8051-3e2450994362	39db9c45-84e6-418a-9b41-54885bf6e2e3	allowed-protocol-mapper-types	oidc-address-mapper
af0012fb-9325-484f-90d0-6e27d423c56c	39db9c45-84e6-418a-9b41-54885bf6e2e3	allowed-protocol-mapper-types	saml-role-list-mapper
286e5456-1811-4f96-82d8-095c7f8d5df7	39db9c45-84e6-418a-9b41-54885bf6e2e3	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0ac42243-b9a5-42a7-b860-6139aa43a2cb	39db9c45-84e6-418a-9b41-54885bf6e2e3	allowed-protocol-mapper-types	saml-user-property-mapper
d387d981-5680-4b31-baf8-4f4513ffa5de	39db9c45-84e6-418a-9b41-54885bf6e2e3	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
b4d1536f-2fcd-4220-8743-43fe2559c63e	39db9c45-84e6-418a-9b41-54885bf6e2e3	allowed-protocol-mapper-types	saml-user-attribute-mapper
ef69b412-4e35-4cb5-974e-8ab84c9e0f40	39db9c45-84e6-418a-9b41-54885bf6e2e3	allowed-protocol-mapper-types	oidc-full-name-mapper
4890a1b6-7cee-4383-83fd-806622cc2ca3	39db9c45-84e6-418a-9b41-54885bf6e2e3	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
11edde60-6385-4607-a921-6ccae570158b	aa3e2c6b-c0da-4621-9f70-de86eaeeccc4	allow-default-scopes	true
298773af-deb4-4773-87b1-d8116245b9d5	ee4c6bfe-1c23-4064-89a4-a46189a021b8	max-clients	200
d626ba96-ffbf-4339-ab5e-362ae2372f67	2cedfba4-19a8-49b7-b669-2786d78a59cb	privateKey	MIIEpAIBAAKCAQEAtPgMUXvReREC5h31WUs90NAd1a6+M0C8MOLvHNTTiwY1QjvIOCfP6wMWqmilDT24375+qr6u8J+ituALHLbGWGLzRQkckxUd0cSUguBxycQJvRycvD+FiYd26AnALkTjy7ojfDeAhK2Nr51/V+Ffa2gShcTr+r5BTYrH4PCuw1aROjSNUhgznTGxYZRmP+xgk8rFG3XnuwrKihdekJ4U3EDEA0AyLOFJ8A0tx7lvA2pQekc6gFRvmHCwAFw/1FhrnBDcZBWLyQ7LKskOcSt/12gsVh6vsWdwQ54UKgHfIUCCGiPVyGXtShVHYQh7mup5MGQq59/0BHBNVoTfgcQSdQIDAQABAoIBABsOMplED68v8eUBeZrd+uHrG2rE8z6qYPhWFTWURAQ262N5mJd8rEMQdSUI/BQctDUPP9S7KWBkHWmF2WNzl/fC42fg0trSf2DLKQDgGWL24hXZ3zztqkNDc22Bd6/zMLNWotOBYL91SweEXnN/CEsAhjRlmnokU5MKOpPQp/AgEkluK6VdLA9qAkYAWxt6HzPhABP0nifktSgX08XXiFIUegr7I/6iDCp7eyJJfB5aY5rjhQycEjdBLewtTedpY1vbF0lohL/ckgW054y5A9SoSQeINda21tVcP0z2t2OKKv9zUe8I2jP7I0PuMtaHvCmxhXnO651NWqcvNAR/i0ECgYEA8nTrY5JWFJrsnRiGMpYzlPNwH7rRkHyakkyPemDDfOIwgmhw9xZrS/njtnbyDR8ofqMhcT8OPRKucN/UDr2zHcPT0OWl4B1rgiKFfbrdB6iMI8l+VuCinZzuXXvQLO5ao7mizcS1CAr9hBWru2kDkACVMxTjIqM3udAf3q1bV2kCgYEAvxPdv/GWtjidI1WvVDj5eFS8J/BuW565CVigMZYIGqA3IZYTWLj5f5gBtamY3UVwbshh1FRsN8QCzb/TwE1gM7yVYRNRQPRlNW3gdLaAM8oA1FnNMtqTPoBa1VKkVeing4O3SeZAJd1kY6OIDPB2ixbkDHuNvNZnqOIouJ7ObS0CgYEAhMqQmYpuZv6rFSd3aIFnYu8pu9cgLBhyuCoCcy5IIz/m/aWiKVI4FfaZRzhCPfmQvjsud83nSH/Q1rVgeWpgja7RdhoxDVxPo4iwwDn2ENm5V2hmL8L8jYKD8uN7EwDA1+c2Saiw1eTfENalphFQCDCphr6r4C6wuK5KpjUgT/ECgYBiqa9m3SglDzaUeDoAEys9pwNA3DUfueVxngGZmQ62MORGw2dZ+Klb6PF5DAmSt7hGe9GIAc+fO+b2toZwVYPHMyku5vqdv5RC8mlj2ph4JWYoP/Zku9gr/brpS7LvaSKWFf0ee3XEF30utdIaXE/Zogg/Kc0WJN+BpMXCDr4oQQKBgQCpp/jsnGCmhBPGqTt6nxHIHlSo7P/G7Hhrl2hL5yzug17L1ErB/q1skBLrQxl3vJ9Cc56ilPO6wmH2d/xf13pAGVWurMjKbDHOuPNGbFaQiodG1hrH73msVuzUjfrUo4mzj9P2QAccSVaKq1iiVOWXSQIxXhybiBuIdIoAbVx/zA==
760ac9c2-46b6-4ace-b708-5d84a42282f7	2cedfba4-19a8-49b7-b669-2786d78a59cb	certificate	MIICmzCCAYMCBgFwqgAfmTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjAwMzA1MDkxOTU5WhcNMzAwMzA1MDkyMTM5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0+AxRe9F5EQLmHfVZSz3Q0B3Vrr4zQLww4u8c1NOLBjVCO8g4J8/rAxaqaKUNPbjfvn6qvq7wn6K24AsctsZYYvNFCRyTFR3RxJSC4HHJxAm9HJy8P4WJh3boCcAuROPLuiN8N4CErY2vnX9X4V9raBKFxOv6vkFNisfg8K7DVpE6NI1SGDOdMbFhlGY/7GCTysUbdee7CsqKF16QnhTcQMQDQDIs4UnwDS3HuW8DalB6RzqAVG+YcLAAXD/UWGucENxkFYvJDssqyQ5xK3/XaCxWHq+xZ3BDnhQqAd8hQIIaI9XIZe1KFUdhCHua6nkwZCrn3/QEcE1WhN+BxBJ1AgMBAAEwDQYJKoZIhvcNAQELBQADggEBADdiOZIW0C5z4NdyyiGKs3U++nWAi2uKQwhHujA0YtxRhH3Te3iEQZ9z3YOMViGPDB8ONjQajkKo8b+7QD5Var6dXww5sXv55RR0vgw/tLNer7GbCUT/v3Pfn9zwX4De0siEmSekKMGuKgrGSCIEDJXYL8XiplWsTut9UyB6+eax6qCyCdlqb5oeOtfkDkdlKrvT/SZ9ytpDWaLNSB3uokfpIMaCCdqvtvd/B+FLEETlRzUmIZYEeTsIwhuVDdUEfhyRb9cFVIXAUD6789+obxirQwLDMB1MdRW0PsiSCiWlJFgGQK9Cindl6MUvTgGTnvn3HVtq62/HklDaK1fc55s=
68defc14-2bb4-49b3-9dac-19cd8130cac0	2cedfba4-19a8-49b7-b669-2786d78a59cb	priority	100
2faa783c-ffd4-4a0b-9b91-6d711ce1880a	01a02236-6985-40f2-83de-40ef9fae7b0e	priority	100
be082b25-462a-46d7-91d9-715d0dd98c3b	01a02236-6985-40f2-83de-40ef9fae7b0e	secret	0CMd_6EYOGup0qLI_jgnirkntrIq_xB-wG-qW6JCSjwBtqTl2XqWrbfcnOkk1pbMGNGqMVD-xZ5F2x5MU5uOLg
9083d6bc-992a-4003-baa3-8c2fde5e80eb	01a02236-6985-40f2-83de-40ef9fae7b0e	kid	5b09e38a-9568-49e2-899d-db3c820063a5
313c0ead-78dd-478e-862c-8987825ba517	01a02236-6985-40f2-83de-40ef9fae7b0e	algorithm	HS256
63890a84-b088-4f3b-ae31-0e788a039994	2bf3736e-82f3-4d31-b0cf-d3c5832613ad	priority	100
3f948396-5dd7-4170-9719-b79bfb746d98	2bf3736e-82f3-4d31-b0cf-d3c5832613ad	kid	1130eaeb-7ebc-412e-9cc9-c1cb2057e4af
d697b685-33bb-4ae5-9f4b-50409a661bf8	2bf3736e-82f3-4d31-b0cf-d3c5832613ad	secret	SBuQ9RtFgRDMdYnkQUqYRg
dea04bc0-0aa8-4f1f-a46d-ffc3abbc44ab	5fe95c93-af3f-44ea-ae3f-3f63f28dbfb3	certificate	MIICszCCAZsCBgFwq2pq9jANBgkqhkiG9w0BAQsFADAdMRswGQYDVQQDDBJTcHJpbmdCb290S2V5Y2xvYWswHhcNMjAwMzA1MTU1NTQzWhcNMzAwMzA1MTU1NzIzWjAdMRswGQYDVQQDDBJTcHJpbmdCb290S2V5Y2xvYWswggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCn7Dol1l5sQY/ZFazHfCd2KGaoVJzn2yNZ171CKJBQnslmBLYJq1aL7yP+h5TjdnEM67r6Uhh0Syqx9d3cZkDd3PYKt9eEd+POLp494CWkVjZbBJLAt9p7fcoYvZdfN1S7wHh/9E8VK4wZpZyxAadMvOoAWD6ZPV/BrwzeraMPv0YWJYWMsI2euA215PmUCZ4+xWc7aQLwnpQblWAQerSpNgHiKbhStjNJDpr4ySqLk/eFFcKjnD/i6HGpVo7xtiWZf0MJUt61D+oEEEvBkBq2yv+CCJeHZsQKQpydwu9R3LsOWZMK4gJBFjwI70W02Bwh5FY6K0qbdCidXpDUhbULAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJoC1FgEEV6thcrLLbpWhtckMG3HUBoldoqv4BLaNdFERlgP3Qdyc5+rIAmWiipj7Cy8f12Hp7U/rS6AJ1fAns8vYM9I71xvKPpVyBtGldhee44BQp+Eh5Q/auY6l7XbvKTZ8u1raWq54m2Wdg77K/oWc+CJ89tQIws1BA3ysZZmeC72jClL6LVt6QCDVVk3wXX+bOtTyb0gQt4UUMS+5IzoMoPgfbMfwd2WuTnkfnDEzZej11xaBNhqL/g+c0rxLtGX3DI/YabloZVNf6JejAX+Zux2v0wLG4WgH6nNeORQDA6iKiBcFt84sYJ1xMclaZZYO5FNCJikfNqo8n9jZBk=
44e44fe6-b160-4613-b6dc-8a1f8c8e997b	5fe95c93-af3f-44ea-ae3f-3f63f28dbfb3	priority	100
727d5e96-c642-4c7b-8e38-1ff49d1d0103	5fe95c93-af3f-44ea-ae3f-3f63f28dbfb3	privateKey	MIIEpAIBAAKCAQEAp+w6JdZebEGP2RWsx3wndihmqFSc59sjWde9QiiQUJ7JZgS2CatWi+8j/oeU43ZxDOu6+lIYdEsqsfXd3GZA3dz2CrfXhHfjzi6ePeAlpFY2WwSSwLfae33KGL2XXzdUu8B4f/RPFSuMGaWcsQGnTLzqAFg+mT1fwa8M3q2jD79GFiWFjLCNnrgNteT5lAmePsVnO2kC8J6UG5VgEHq0qTYB4im4UrYzSQ6a+Mkqi5P3hRXCo5w/4uhxqVaO8bYlmX9DCVLetQ/qBBBLwZAatsr/ggiXh2bECkKcncLvUdy7DlmTCuICQRY8CO9FtNgcIeRWOitKm3QonV6Q1IW1CwIDAQABAoIBAB5lZVUqC6d+6qH6CW+GqsH5qDN6NXjGswx1P93058KgK4aa/bScXiswW4ycUDgoXWhgV1UufRy36n+SKNnXbJB8idEA3DMvXH4a9CvxIf8wV+B74HCgFx1ZdLarwvXKVz0xJt7Kg3Iqks6lqspjqTv7ykPLtXEZqfauUB8SwTx9MG6cdqhYOWPKKvblLaTuV7lCzS9IvGR3C+2TTeCcr5ctmQgbC3JDIUoc8jWAFGBOTyqndFRFJ6OjLEmWskcwSCh9NCdfIA6Y1em/eKJuop0y1Kt/PFxqELtU6qGrYKP94Ar+GOc7qT/xwkQvcCMrkGSHh4lubZTK1XqzFxOfbwkCgYEA65pxTJPNGuMHoTlKmciDZPDxzSHZEyVugZJipP4WWnpBFr8quaUoIMjGFKpDDlGglmgVROfHDkNmYLNyD5+f18Mc+NV6biMN+xkXACPAJfvTewHoimba3JFgiBqhOMnzHTVRRbf5/GhmT0a02n+gtktOll14pUBKc3w1uqN6voUCgYEAtnXQoyB9YcVuX6U8CaWATAAmX0AKYwvq25onoQbmQflTvDUOf6y+fDb+WScBVUDR4KDnvVXFnYEmRJAO7QjKVgVl91L1FpxNqsGu/PtrVC5ShaMboWioGw+J4npTtNx+bfGWTHmhNZxfK0a749jMBtIeoMnF8Bp6xtA5LWa+Yk8CgYEAlHJqQtK5n+A+NXJQs9aoG1jJMfPKv4qNNyzR5J2H3hg7nKZ0uCX8w7NdQzYILCR4Z2xLQnA7dpw3DGTkUD3GS/9O6OYxTuXdcEHdwSPFdOlX1aBdMZ8e9WzQAtGslYiBGv02KRSDeWsaU4b8etOBonqOmKVqV8zLXDp97AwHUbUCgYEAmgVV+33/mTrp8v8ucQ4uAPnXamxK2FVFCd9VOI70bBil4KgA9zHBEmXxyxwr+eVfxXjOZnsy98P/o7zffKQA+SBRdLeogE+tGEmrB47MiSEZNAn91wDbdwxk3rNYWcIPT4uxzhiWRwUbKRLqpGlrwQ46IIxy9D3GCnHW8kZay+0CgYB2GqEV9sPTm8Liy8uYQAToqvcPd3QafN59hxW/v+MxcAt7x8lPFg1lYR6kxGYZ1j7tGMc6iUVS0XS3lHJN1512Mjlo6CeAuTSjer0yAL3b9JqcLh7Dfcbd3HshDpG57WEG+buGuBC2L8qVzc+b9xcMP3VriewU/Cpn5WiK3iyVsQ==
35257753-7040-4f7f-afb0-b0d0d927cdae	8e9416e1-b773-4387-9964-431393243508	priority	100
9a1d1782-3f4d-4fd7-be74-1c81c5569a28	8e9416e1-b773-4387-9964-431393243508	kid	1ee22266-f3b3-4b2d-8415-e47444fc7d76
6da11f2e-1a4b-44c2-85c7-3f2b9112519d	8e9416e1-b773-4387-9964-431393243508	secret	viLY7MZK13JSekDOXlNlnw
45aa8fd1-c175-4696-8923-c3cee440faaf	74d5d2fc-a719-48f6-935e-bafeac135f8e	priority	100
bbcbc5c3-33c2-4b02-91ee-bc4abd93568f	74d5d2fc-a719-48f6-935e-bafeac135f8e	secret	8H4uOs9KhvUCR-ibV6rWsgUL10XnLkT0n2mhU_gRXnOC2MwPIkQNEONBYndL5Y5mpwQ1JzIqi_eiapa3YFXKtw
c2170a4c-4fdb-4089-94ff-36dc15c029ea	74d5d2fc-a719-48f6-935e-bafeac135f8e	kid	1cd7bd3e-1d2b-4042-a1c8-2c3d8bd39465
d403a1c3-81d4-4307-880d-2461cc9223ed	74d5d2fc-a719-48f6-935e-bafeac135f8e	algorithm	HS256
d7e7edd2-c8cc-43fe-8c02-dc709bb8d2b5	922bb9c0-151f-4f50-a4fb-04a3335dd22f	allow-default-scopes	true
d378fac3-dbf2-4614-8597-3c9676401ea1	23e8ff09-39ef-4e2a-9b4a-6b1b7e37d28f	allowed-protocol-mapper-types	saml-user-attribute-mapper
f02112fa-110b-4897-bd82-2bfa3f5f0e59	23e8ff09-39ef-4e2a-9b4a-6b1b7e37d28f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e0e86e5e-a301-4eba-bd40-3a804914f595	23e8ff09-39ef-4e2a-9b4a-6b1b7e37d28f	allowed-protocol-mapper-types	saml-user-property-mapper
028dd3f1-a285-45a7-9f09-ccfc473a62a9	23e8ff09-39ef-4e2a-9b4a-6b1b7e37d28f	allowed-protocol-mapper-types	oidc-full-name-mapper
56833062-4840-40e9-995b-e9f1a488df9c	23e8ff09-39ef-4e2a-9b4a-6b1b7e37d28f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
3bb37540-8864-48d6-9bbb-d0396f622c25	23e8ff09-39ef-4e2a-9b4a-6b1b7e37d28f	allowed-protocol-mapper-types	saml-role-list-mapper
d0b74a41-b010-4df8-ba2f-ef4be2b221ea	23e8ff09-39ef-4e2a-9b4a-6b1b7e37d28f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ac881d7f-ddac-401c-9b25-13d721cf6f94	23e8ff09-39ef-4e2a-9b4a-6b1b7e37d28f	allowed-protocol-mapper-types	oidc-address-mapper
a928e248-9e35-4d87-87e2-c77dc6a568ab	607fa58b-3ad1-4733-bd18-ce66bc9288b5	client-uris-must-match	true
a719e7fc-3703-4f88-8348-e7582a6ffba0	607fa58b-3ad1-4733-bd18-ce66bc9288b5	host-sending-registration-request-must-match	true
f8beffd9-f866-4f5b-b202-77ccd1b6aae8	8637ab32-aa1e-4046-b088-91d8bb76fcaa	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d8c67122-922b-48ff-b6bf-dbdb4edcdc29	8637ab32-aa1e-4046-b088-91d8bb76fcaa	allowed-protocol-mapper-types	saml-user-attribute-mapper
07bc1abb-d883-4530-a0b0-758fd06c13e4	8637ab32-aa1e-4046-b088-91d8bb76fcaa	allowed-protocol-mapper-types	saml-role-list-mapper
af7b1569-0975-457f-a54e-a32dcd5f967f	8637ab32-aa1e-4046-b088-91d8bb76fcaa	allowed-protocol-mapper-types	oidc-address-mapper
f44bd03d-e21d-4f09-89cf-2a80f0985c54	8637ab32-aa1e-4046-b088-91d8bb76fcaa	allowed-protocol-mapper-types	oidc-full-name-mapper
32535788-a1c1-4c3c-938f-4201825532f7	8637ab32-aa1e-4046-b088-91d8bb76fcaa	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
85b37c1c-afcf-4336-8312-25d3a74eb416	8637ab32-aa1e-4046-b088-91d8bb76fcaa	allowed-protocol-mapper-types	saml-user-property-mapper
c42f60bd-9eed-455a-85ba-44df410b10c8	8637ab32-aa1e-4046-b088-91d8bb76fcaa	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8df9ec87-028d-4bd7-9b4f-492e86422f16	b57f722b-f9bf-496a-82e9-fca1bcb232d5	max-clients	200
a6915f4c-ac56-4184-959e-44f339f3cb3c	e0dde975-a312-4164-82be-e4dbbeb11178	allow-default-scopes	true
\.


--
-- TOC entry 3766 (class 0 OID 20744)
-- Dependencies: 202
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.composite_role (composite, child_role) FROM stdin;
038e2a9b-e49c-45c4-a598-6652fcb8c40c	1c298ffb-905b-4dd1-8e18-6de2bf65c08a
038e2a9b-e49c-45c4-a598-6652fcb8c40c	8bba00de-5118-4734-8ad7-1bd5bba4c15c
038e2a9b-e49c-45c4-a598-6652fcb8c40c	01032b4f-c57a-471f-836a-53a99a8e8601
038e2a9b-e49c-45c4-a598-6652fcb8c40c	968ea859-275a-4470-913d-a559b8154acb
038e2a9b-e49c-45c4-a598-6652fcb8c40c	cf519a1c-867d-41c5-bb45-a09c468142f3
038e2a9b-e49c-45c4-a598-6652fcb8c40c	cfa67e73-33cf-4bda-a752-5c2603d81e6f
038e2a9b-e49c-45c4-a598-6652fcb8c40c	9461ab37-674f-479d-b29f-fc4ce5e0a4b8
038e2a9b-e49c-45c4-a598-6652fcb8c40c	889b25ea-222c-463a-b891-4bd7867ee193
038e2a9b-e49c-45c4-a598-6652fcb8c40c	62fe8891-fe45-403e-a0a7-98ac59a08db8
038e2a9b-e49c-45c4-a598-6652fcb8c40c	9b901acb-ffd1-49a2-9edc-0d55969e8e87
038e2a9b-e49c-45c4-a598-6652fcb8c40c	384b886d-71f3-4a9c-90f7-356f0149178c
038e2a9b-e49c-45c4-a598-6652fcb8c40c	32868315-0aef-4330-9203-0e70d907d097
038e2a9b-e49c-45c4-a598-6652fcb8c40c	9cba6450-2b0b-4692-86ca-208dc9576195
038e2a9b-e49c-45c4-a598-6652fcb8c40c	769a8c0f-9a5e-4e0d-8209-8178de2278ff
038e2a9b-e49c-45c4-a598-6652fcb8c40c	31af7748-9fb7-476b-93cc-7f517fb4e5c8
038e2a9b-e49c-45c4-a598-6652fcb8c40c	381bfd96-6626-47cf-8c8b-1c9a2792d000
038e2a9b-e49c-45c4-a598-6652fcb8c40c	439c856b-08d7-4522-ab88-14774977d231
038e2a9b-e49c-45c4-a598-6652fcb8c40c	bb3f608a-0949-4ea9-883b-efb50aaa984c
968ea859-275a-4470-913d-a559b8154acb	31af7748-9fb7-476b-93cc-7f517fb4e5c8
968ea859-275a-4470-913d-a559b8154acb	bb3f608a-0949-4ea9-883b-efb50aaa984c
cf519a1c-867d-41c5-bb45-a09c468142f3	381bfd96-6626-47cf-8c8b-1c9a2792d000
d2d4716c-16e6-4dd3-a6b3-a5bc53945ff5	25e46f22-41b2-4696-9651-75c479174e90
3ac161c6-453e-44e2-9ce8-77bb1798734a	49db1298-97ab-47dc-847d-a70d36b18e69
038e2a9b-e49c-45c4-a598-6652fcb8c40c	270dc091-d82c-437e-80a6-de5483364ffc
038e2a9b-e49c-45c4-a598-6652fcb8c40c	8fd14801-c38b-439a-8a45-e1125a842db7
038e2a9b-e49c-45c4-a598-6652fcb8c40c	bb79cc83-f713-4916-9662-cd0ca241dc5c
038e2a9b-e49c-45c4-a598-6652fcb8c40c	035eb74c-f243-4401-83a8-5a036c0f92aa
038e2a9b-e49c-45c4-a598-6652fcb8c40c	71baf006-afcc-454e-8ffe-ae81c1a9df57
038e2a9b-e49c-45c4-a598-6652fcb8c40c	15578c5a-9e5b-43dd-be11-6eca463712c0
038e2a9b-e49c-45c4-a598-6652fcb8c40c	38cc7704-65ae-4cdb-98ec-f013e9ef180e
038e2a9b-e49c-45c4-a598-6652fcb8c40c	16a9c379-2039-4418-a266-0db09628e62e
038e2a9b-e49c-45c4-a598-6652fcb8c40c	019f5b0d-4315-447e-972b-c5fa279ba493
038e2a9b-e49c-45c4-a598-6652fcb8c40c	c1918ae9-c539-4f01-89fa-1fb050f87a84
038e2a9b-e49c-45c4-a598-6652fcb8c40c	49645490-a6ed-45df-a43a-4c2c32df4cf2
038e2a9b-e49c-45c4-a598-6652fcb8c40c	2f27f55d-2e30-4813-9c5f-46685ae30555
038e2a9b-e49c-45c4-a598-6652fcb8c40c	a7bdccc4-68b6-4cd8-84b8-1613e3d1e95c
038e2a9b-e49c-45c4-a598-6652fcb8c40c	b429baf9-7e68-4edc-a51f-4c6176d17b08
038e2a9b-e49c-45c4-a598-6652fcb8c40c	d8d99018-a103-4c6b-bb6a-a11ca67c8db7
038e2a9b-e49c-45c4-a598-6652fcb8c40c	e2787b59-7f9e-44db-b88c-c213857d0ff1
038e2a9b-e49c-45c4-a598-6652fcb8c40c	9fa128e8-2a12-453b-8b35-98d2c200ede3
038e2a9b-e49c-45c4-a598-6652fcb8c40c	66ee04d2-9038-4d0b-ba7b-edb091ae1942
035eb74c-f243-4401-83a8-5a036c0f92aa	66ee04d2-9038-4d0b-ba7b-edb091ae1942
035eb74c-f243-4401-83a8-5a036c0f92aa	d8d99018-a103-4c6b-bb6a-a11ca67c8db7
71baf006-afcc-454e-8ffe-ae81c1a9df57	e2787b59-7f9e-44db-b88c-c213857d0ff1
c2094593-4109-465e-a4c8-f13749be658f	dda690c3-a82a-4e81-829f-e35f62a82786
c2094593-4109-465e-a4c8-f13749be658f	bdd72192-b531-4044-9d37-bf5bf34eb5a9
c2094593-4109-465e-a4c8-f13749be658f	da6c4955-5e01-41f2-bc2a-8f9cc1a49153
c2094593-4109-465e-a4c8-f13749be658f	5e686391-4081-4735-860c-08fe639308c8
c2094593-4109-465e-a4c8-f13749be658f	601e654c-a627-4e25-8694-9123547c0cb0
c2094593-4109-465e-a4c8-f13749be658f	95582322-ea7b-4954-9224-3b04d33db6ab
c2094593-4109-465e-a4c8-f13749be658f	7da0a8d6-3608-4d52-b180-93178a29e158
c2094593-4109-465e-a4c8-f13749be658f	09f85a78-07de-494e-8593-6532575fcd29
c2094593-4109-465e-a4c8-f13749be658f	82e8b52f-e487-48e2-904e-3047fe3a1aaa
c2094593-4109-465e-a4c8-f13749be658f	f6eb012e-3abc-4ba1-b0de-ad4edfb2c181
c2094593-4109-465e-a4c8-f13749be658f	4cd7c7c9-f9cc-45e1-a718-725fa642a359
c2094593-4109-465e-a4c8-f13749be658f	f72a8140-f6e2-41fe-bd39-6aeb44433226
c2094593-4109-465e-a4c8-f13749be658f	f6919737-b706-4e24-935d-898c063480f9
c2094593-4109-465e-a4c8-f13749be658f	e26bc8d6-7bf8-42c9-8485-95b5805ca3a1
c2094593-4109-465e-a4c8-f13749be658f	2f9d635b-cbac-4bfd-afaa-cda9e178152a
c2094593-4109-465e-a4c8-f13749be658f	bd43fcd1-ec7e-42f8-9acf-8ffeb47a0e84
c2094593-4109-465e-a4c8-f13749be658f	2ff98fa5-afb5-405c-bc41-88378ccc4dee
da6c4955-5e01-41f2-bc2a-8f9cc1a49153	e26bc8d6-7bf8-42c9-8485-95b5805ca3a1
da6c4955-5e01-41f2-bc2a-8f9cc1a49153	2ff98fa5-afb5-405c-bc41-88378ccc4dee
5e686391-4081-4735-860c-08fe639308c8	2f9d635b-cbac-4bfd-afaa-cda9e178152a
a30db9ce-a621-4acf-8c7a-d91468d7d8c9	45542fb6-08e3-49c3-943b-5e91f1e86f17
fc3a0128-c50c-423d-9082-9f60c2a2abe6	368d528a-1006-42ff-8a83-5c562efb44c7
038e2a9b-e49c-45c4-a598-6652fcb8c40c	a366ecc1-9d83-4042-a773-61c2a726e134
c2094593-4109-465e-a4c8-f13749be658f	c227d967-8683-4eaa-b22b-3dee89312292
\.


--
-- TOC entry 3767 (class 0 OID 20747)
-- Dependencies: 203
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
c37ca30a-c1c8-4c6e-8500-1963f14bfd8c	\N	password	b192959c-754b-49e7-9bd9-58df41e29818	1583400100108	\N	{"value":"B5ZHP1dIskC2uZgmGSdJ/dcdI77nOU+AJ/eN9liDC7B3JiPMIW9KOeVNAncPScQ+7fyYD38GpCs5hCUov5j1yw==","salt":"kjna9Jk27Ds7bAlJkUrjPQ=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
dffe5475-8032-4278-aa82-68593c3afff7	\N	password	96ff7058-59a9-4fc3-a851-5c901b5731c9	1583424678531	\N	{"value":"j7/JZo0IZjoTpW+B5fj/bn0tQg29uRgCFf7saNM3QiJ4EA4jFkUmE87GJycBFEyCp6yXprojh1UghOX9MAjUfQ==","salt":"O0GIVrarTjVp5xEp1LBOKw=="}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256"}	10
\.


--
-- TOC entry 3761 (class 0 OID 20714)
-- Dependencies: 197
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2020-03-05 09:21:34.091527	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3400093679
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2020-03-05 09:21:34.099942	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	3400093679
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2020-03-05 09:21:34.163278	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	3400093679
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2020-03-05 09:21:34.168104	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	3400093679
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2020-03-05 09:21:34.290652	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3400093679
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2020-03-05 09:21:34.296404	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	3400093679
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2020-03-05 09:21:34.402978	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3400093679
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2020-03-05 09:21:34.40729	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	3400093679
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2020-03-05 09:21:34.411897	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	3400093679
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2020-03-05 09:21:34.571903	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	3400093679
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2020-03-05 09:21:34.674502	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3400093679
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2020-03-05 09:21:34.681913	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3400093679
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2020-03-05 09:21:34.737409	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	3400093679
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-05 09:21:34.764844	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	3400093679
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-05 09:21:34.767443	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3400093679
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-05 09:21:34.769938	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	3400093679
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2020-03-05 09:21:34.774871	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	3400093679
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2020-03-05 09:21:34.84599	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	3400093679
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2020-03-05 09:21:34.889368	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3400093679
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2020-03-05 09:21:34.894339	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3400093679
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-05 09:21:35.545799	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3400093679
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2020-03-05 09:21:34.897152	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	3400093679
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2020-03-05 09:21:34.900288	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	3400093679
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2020-03-05 09:21:34.921432	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	3400093679
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2020-03-05 09:21:34.929442	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3400093679
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2020-03-05 09:21:34.931746	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	3400093679
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2020-03-05 09:21:34.983811	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	3400093679
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2020-03-05 09:21:35.091973	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	3400093679
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2020-03-05 09:21:35.101662	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3400093679
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2020-03-05 09:21:35.182762	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	3400093679
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2020-03-05 09:21:35.19965	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	3400093679
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2020-03-05 09:21:35.218511	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	3400093679
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2020-03-05 09:21:35.230153	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	3400093679
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-05 09:21:35.246003	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	3400093679
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-05 09:21:35.248618	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3400093679
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-05 09:21:35.277389	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	3400093679
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2020-03-05 09:21:35.282598	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	3400093679
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2020-03-05 09:21:35.290612	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	3400093679
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2020-03-05 09:21:35.295001	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	3400093679
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2020-03-05 09:21:35.301316	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	3400093679
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-03-05 09:21:35.303391	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3400093679
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-03-05 09:21:35.305593	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	3400093679
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2020-03-05 09:21:35.309482	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	3400093679
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2020-03-05 09:21:35.531876	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	3400093679
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2020-03-05 09:21:35.539168	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	3400093679
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-05 09:21:35.552132	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	3400093679
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-05 09:21:35.555451	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	3400093679
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-05 09:21:35.618329	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	3400093679
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2020-03-05 09:21:35.628348	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	3400093679
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2020-03-05 09:21:35.721954	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	3400093679
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2020-03-05 09:21:35.783027	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	3400093679
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2020-03-05 09:21:35.790491	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	3400093679
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2020-03-05 09:21:35.796588	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	3400093679
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2020-03-05 09:21:35.802889	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	3400093679
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-05 09:21:35.816887	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	3400093679
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-05 09:21:35.830121	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	3400093679
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-05 09:21:35.881459	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	3400093679
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2020-03-05 09:21:36.088068	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	3400093679
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2020-03-05 09:21:36.143184	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	3400093679
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2020-03-05 09:21:36.155185	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	3400093679
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-03-05 09:21:36.171831	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	3400093679
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2020-03-05 09:21:36.183544	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	3400093679
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2020-03-05 09:21:36.19059	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3400093679
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2020-03-05 09:21:36.196499	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	3400093679
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2020-03-05 09:21:36.202688	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	3400093679
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2020-03-05 09:21:36.230377	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	3400093679
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2020-03-05 09:21:36.240984	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	3400093679
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2020-03-05 09:21:36.247352	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	3400093679
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2020-03-05 09:21:36.261579	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	3400093679
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2020-03-05 09:21:36.267587	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	3400093679
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2020-03-05 09:21:36.272077	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	3400093679
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-05 09:21:36.278028	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3400093679
8.0.0-updating-credential-data-not-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-05 09:21:36.282892	73	EXECUTED	7:03b3f4b264c3c68ba082250a80b74216	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3400093679
8.0.0-updating-credential-data-oracle	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-05 09:21:36.285662	74	MARK_RAN	7:64c5728f5ca1f5aa4392217701c4fe23	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	3400093679
8.0.0-credential-cleanup	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-05 09:21:36.298082	75	EXECUTED	7:41f3566ac5177459e1ed3ce8f0ad35d2	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	3400093679
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2020-03-05 09:21:36.307141	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	3400093679
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-03-05 09:21:36.314411	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	3400093679
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-03-05 09:21:36.316742	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	3400093679
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-03-05 09:21:36.346418	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	3400093679
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2020-03-05 09:21:36.354225	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	3400093679
\.


--
-- TOC entry 3760 (class 0 OID 20709)
-- Dependencies: 196
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- TOC entry 3846 (class 0 OID 22163)
-- Dependencies: 282
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	d894a28e-1d9c-41da-bdf7-5408d184f22e	f
master	30ffadc7-5ecd-463f-93ce-2a57e32dfb66	t
master	f7f00bb7-1d8f-4e94-90d7-9902bf39a503	t
master	6943da30-3e63-4254-8668-97aff9ecbdc3	t
master	216918b6-e49c-4398-99cc-5b7004b618b5	f
master	f12c60e4-655d-44ef-9bf1-fb9247a6b634	f
master	18e8eb55-cdab-48ec-b509-f97659669327	t
master	a18f35dd-3e19-42c0-aa01-9d41078642f6	t
master	ebb5ce8c-b63d-4a46-902a-668873fc2ab9	f
SpringBootKeycloak	f4fb089e-80a9-48f7-bf50-75bca1279696	f
SpringBootKeycloak	9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1	t
SpringBootKeycloak	1eb31e46-1a19-4937-83f6-9cb8e079e47f	t
SpringBootKeycloak	c9a0646f-a17b-4efe-b678-ff97b200adeb	t
SpringBootKeycloak	de5865df-f1b0-4c1c-9a0b-26374cec52cc	f
SpringBootKeycloak	1890ab4e-72c5-406f-8e78-6bdcf15ae09b	f
SpringBootKeycloak	a7d14333-728d-461d-a865-32ee7040a601	t
SpringBootKeycloak	1891fce2-87a3-4ea3-a365-1af7f1425ccd	t
SpringBootKeycloak	f6e4b664-06bb-4980-9444-9e077ac85e6f	f
\.


--
-- TOC entry 3768 (class 0 OID 20753)
-- Dependencies: 204
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- TOC entry 3834 (class 0 OID 21852)
-- Dependencies: 270
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- TOC entry 3835 (class 0 OID 21858)
-- Dependencies: 271
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 3848 (class 0 OID 22189)
-- Dependencies: 284
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 3836 (class 0 OID 21867)
-- Dependencies: 272
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- TOC entry 3837 (class 0 OID 21877)
-- Dependencies: 273
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 3838 (class 0 OID 21880)
-- Dependencies: 274
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 3839 (class 0 OID 21887)
-- Dependencies: 275
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 3792 (class 0 OID 21147)
-- Dependencies: 228
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 3842 (class 0 OID 21956)
-- Dependencies: 278
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- TOC entry 3818 (class 0 OID 21566)
-- Dependencies: 254
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- TOC entry 3817 (class 0 OID 21563)
-- Dependencies: 253
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- TOC entry 3793 (class 0 OID 21153)
-- Dependencies: 229
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- TOC entry 3794 (class 0 OID 21163)
-- Dependencies: 230
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 3799 (class 0 OID 21269)
-- Dependencies: 235
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- TOC entry 3800 (class 0 OID 21275)
-- Dependencies: 236
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 3816 (class 0 OID 21560)
-- Dependencies: 252
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- TOC entry 3769 (class 0 OID 20762)
-- Dependencies: 205
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
038e2a9b-e49c-45c4-a598-6652fcb8c40c	master	f	${role_admin}	admin	master	\N	master
1c298ffb-905b-4dd1-8e18-6de2bf65c08a	master	f	${role_create-realm}	create-realm	master	\N	master
8bba00de-5118-4734-8ad7-1bd5bba4c15c	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_create-client}	create-client	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
01032b4f-c57a-471f-836a-53a99a8e8601	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_view-realm}	view-realm	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
968ea859-275a-4470-913d-a559b8154acb	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_view-users}	view-users	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
cf519a1c-867d-41c5-bb45-a09c468142f3	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_view-clients}	view-clients	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
cfa67e73-33cf-4bda-a752-5c2603d81e6f	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_view-events}	view-events	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
9461ab37-674f-479d-b29f-fc4ce5e0a4b8	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_view-identity-providers}	view-identity-providers	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
889b25ea-222c-463a-b891-4bd7867ee193	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_view-authorization}	view-authorization	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
62fe8891-fe45-403e-a0a7-98ac59a08db8	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_manage-realm}	manage-realm	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
9b901acb-ffd1-49a2-9edc-0d55969e8e87	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_manage-users}	manage-users	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
384b886d-71f3-4a9c-90f7-356f0149178c	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_manage-clients}	manage-clients	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
32868315-0aef-4330-9203-0e70d907d097	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_manage-events}	manage-events	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
9cba6450-2b0b-4692-86ca-208dc9576195	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_manage-identity-providers}	manage-identity-providers	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
769a8c0f-9a5e-4e0d-8209-8178de2278ff	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_manage-authorization}	manage-authorization	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
31af7748-9fb7-476b-93cc-7f517fb4e5c8	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_query-users}	query-users	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
381bfd96-6626-47cf-8c8b-1c9a2792d000	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_query-clients}	query-clients	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
439c856b-08d7-4522-ab88-14774977d231	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_query-realms}	query-realms	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
bb3f608a-0949-4ea9-883b-efb50aaa984c	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_query-groups}	query-groups	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
3ecc9bc3-bc92-4e24-8cd8-a417039e8b8b	335fff2e-b205-4fdd-8600-f87a2ba4c930	t	${role_view-profile}	view-profile	master	335fff2e-b205-4fdd-8600-f87a2ba4c930	\N
d2d4716c-16e6-4dd3-a6b3-a5bc53945ff5	335fff2e-b205-4fdd-8600-f87a2ba4c930	t	${role_manage-account}	manage-account	master	335fff2e-b205-4fdd-8600-f87a2ba4c930	\N
25e46f22-41b2-4696-9651-75c479174e90	335fff2e-b205-4fdd-8600-f87a2ba4c930	t	${role_manage-account-links}	manage-account-links	master	335fff2e-b205-4fdd-8600-f87a2ba4c930	\N
1e06891d-4547-4f62-8d46-0546e6936b87	335fff2e-b205-4fdd-8600-f87a2ba4c930	t	${role_view-applications}	view-applications	master	335fff2e-b205-4fdd-8600-f87a2ba4c930	\N
49db1298-97ab-47dc-847d-a70d36b18e69	335fff2e-b205-4fdd-8600-f87a2ba4c930	t	${role_view-consent}	view-consent	master	335fff2e-b205-4fdd-8600-f87a2ba4c930	\N
3ac161c6-453e-44e2-9ce8-77bb1798734a	335fff2e-b205-4fdd-8600-f87a2ba4c930	t	${role_manage-consent}	manage-consent	master	335fff2e-b205-4fdd-8600-f87a2ba4c930	\N
2fe367ca-bb05-4b57-8f5b-db4b6ad78daa	becec056-0b5c-44f0-a38c-be3c2bbc3f21	t	${role_read-token}	read-token	master	becec056-0b5c-44f0-a38c-be3c2bbc3f21	\N
270dc091-d82c-437e-80a6-de5483364ffc	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	t	${role_impersonation}	impersonation	master	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	\N
fbb73b9b-139a-4397-95b9-330f88bee545	master	f	${role_offline-access}	offline_access	master	\N	master
72c67b15-67de-4dde-8be3-776cd9927954	master	f	${role_uma_authorization}	uma_authorization	master	\N	master
8fd14801-c38b-439a-8a45-e1125a842db7	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_create-client}	create-client	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
bb79cc83-f713-4916-9662-cd0ca241dc5c	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_view-realm}	view-realm	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
035eb74c-f243-4401-83a8-5a036c0f92aa	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_view-users}	view-users	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
71baf006-afcc-454e-8ffe-ae81c1a9df57	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_view-clients}	view-clients	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
15578c5a-9e5b-43dd-be11-6eca463712c0	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_view-events}	view-events	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
38cc7704-65ae-4cdb-98ec-f013e9ef180e	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_view-identity-providers}	view-identity-providers	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
16a9c379-2039-4418-a266-0db09628e62e	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_view-authorization}	view-authorization	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
019f5b0d-4315-447e-972b-c5fa279ba493	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_manage-realm}	manage-realm	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
c1918ae9-c539-4f01-89fa-1fb050f87a84	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_manage-users}	manage-users	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
49645490-a6ed-45df-a43a-4c2c32df4cf2	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_manage-clients}	manage-clients	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
2f27f55d-2e30-4813-9c5f-46685ae30555	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_manage-events}	manage-events	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
a7bdccc4-68b6-4cd8-84b8-1613e3d1e95c	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_manage-identity-providers}	manage-identity-providers	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
b429baf9-7e68-4edc-a51f-4c6176d17b08	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_manage-authorization}	manage-authorization	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
d8d99018-a103-4c6b-bb6a-a11ca67c8db7	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_query-users}	query-users	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
e2787b59-7f9e-44db-b88c-c213857d0ff1	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_query-clients}	query-clients	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
9fa128e8-2a12-453b-8b35-98d2c200ede3	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_query-realms}	query-realms	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
66ee04d2-9038-4d0b-ba7b-edb091ae1942	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_query-groups}	query-groups	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
c2094593-4109-465e-a4c8-f13749be658f	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_realm-admin}	realm-admin	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
dda690c3-a82a-4e81-829f-e35f62a82786	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_create-client}	create-client	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
bdd72192-b531-4044-9d37-bf5bf34eb5a9	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_view-realm}	view-realm	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
da6c4955-5e01-41f2-bc2a-8f9cc1a49153	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_view-users}	view-users	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
5e686391-4081-4735-860c-08fe639308c8	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_view-clients}	view-clients	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
601e654c-a627-4e25-8694-9123547c0cb0	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_view-events}	view-events	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
95582322-ea7b-4954-9224-3b04d33db6ab	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_view-identity-providers}	view-identity-providers	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
7da0a8d6-3608-4d52-b180-93178a29e158	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_view-authorization}	view-authorization	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
09f85a78-07de-494e-8593-6532575fcd29	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_manage-realm}	manage-realm	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
82e8b52f-e487-48e2-904e-3047fe3a1aaa	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_manage-users}	manage-users	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
f6eb012e-3abc-4ba1-b0de-ad4edfb2c181	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_manage-clients}	manage-clients	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
4cd7c7c9-f9cc-45e1-a718-725fa642a359	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_manage-events}	manage-events	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
f72a8140-f6e2-41fe-bd39-6aeb44433226	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_manage-identity-providers}	manage-identity-providers	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
f6919737-b706-4e24-935d-898c063480f9	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_manage-authorization}	manage-authorization	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
e26bc8d6-7bf8-42c9-8485-95b5805ca3a1	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_query-users}	query-users	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
2f9d635b-cbac-4bfd-afaa-cda9e178152a	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_query-clients}	query-clients	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
bd43fcd1-ec7e-42f8-9acf-8ffeb47a0e84	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_query-realms}	query-realms	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
2ff98fa5-afb5-405c-bc41-88378ccc4dee	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_query-groups}	query-groups	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
d97fb25a-d8e8-4d55-aabc-489ffdc0e576	25f1c990-8983-4f82-ac2c-335368c68457	t	${role_view-profile}	view-profile	SpringBootKeycloak	25f1c990-8983-4f82-ac2c-335368c68457	\N
a30db9ce-a621-4acf-8c7a-d91468d7d8c9	25f1c990-8983-4f82-ac2c-335368c68457	t	${role_manage-account}	manage-account	SpringBootKeycloak	25f1c990-8983-4f82-ac2c-335368c68457	\N
45542fb6-08e3-49c3-943b-5e91f1e86f17	25f1c990-8983-4f82-ac2c-335368c68457	t	${role_manage-account-links}	manage-account-links	SpringBootKeycloak	25f1c990-8983-4f82-ac2c-335368c68457	\N
9c2af1a9-b62b-45f0-a1ce-0903ceeb9dd0	25f1c990-8983-4f82-ac2c-335368c68457	t	${role_view-applications}	view-applications	SpringBootKeycloak	25f1c990-8983-4f82-ac2c-335368c68457	\N
368d528a-1006-42ff-8a83-5c562efb44c7	25f1c990-8983-4f82-ac2c-335368c68457	t	${role_view-consent}	view-consent	SpringBootKeycloak	25f1c990-8983-4f82-ac2c-335368c68457	\N
fc3a0128-c50c-423d-9082-9f60c2a2abe6	25f1c990-8983-4f82-ac2c-335368c68457	t	${role_manage-consent}	manage-consent	SpringBootKeycloak	25f1c990-8983-4f82-ac2c-335368c68457	\N
a366ecc1-9d83-4042-a773-61c2a726e134	88970e97-34e2-4296-bfbc-4996d44813c1	t	${role_impersonation}	impersonation	master	88970e97-34e2-4296-bfbc-4996d44813c1	\N
c227d967-8683-4eaa-b22b-3dee89312292	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	t	${role_impersonation}	impersonation	SpringBootKeycloak	2311b4a7-04c7-4e9e-b67d-783a3098ed4c	\N
8e828cf9-63f0-4ea2-8fdd-db733ad13268	2cc1ecd1-62c4-4163-8a89-08225ceae2b2	t	${role_read-token}	read-token	SpringBootKeycloak	2cc1ecd1-62c4-4163-8a89-08225ceae2b2	\N
3218a301-b54c-4b46-adba-02d293af190e	SpringBootKeycloak	f	${role_offline-access}	offline_access	SpringBootKeycloak	\N	SpringBootKeycloak
f83c25e0-275a-4bb1-acec-f2c11ac06240	SpringBootKeycloak	f	${role_uma_authorization}	uma_authorization	SpringBootKeycloak	\N	SpringBootKeycloak
0b8f2e5e-f4e7-40af-95f5-67b41280b62d	SpringBootKeycloak	f	\N	user	SpringBootKeycloak	\N	SpringBootKeycloak
\.


--
-- TOC entry 3798 (class 0 OID 21266)
-- Dependencies: 234
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migration_model (id, version, update_time) FROM stdin;
bn7th	9.0.0	1583400098
\.


--
-- TOC entry 3815 (class 0 OID 21550)
-- Dependencies: 251
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 3814 (class 0 OID 21544)
-- Dependencies: 250
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- TOC entry 3828 (class 0 OID 21773)
-- Dependencies: 264
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- TOC entry 3790 (class 0 OID 21134)
-- Dependencies: 226
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
b6a28628-cc2e-4c26-9806-8f628942f27a	audience resolve	openid-connect	oidc-audience-resolve-mapper	2838a207-e8bd-472c-b530-4aa5e8e8799f	\N
0df8e04f-44e1-4934-981b-daf71f03edc9	locale	openid-connect	oidc-usermodel-attribute-mapper	464a276e-f380-4188-bb97-91a65aadd58f	\N
f318f0b7-1167-47ed-9a95-60499eaeb444	role list	saml	saml-role-list-mapper	\N	30ffadc7-5ecd-463f-93ce-2a57e32dfb66
5ab6c53a-f99b-4c65-9818-a0822241e0d4	full name	openid-connect	oidc-full-name-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
0f29fcef-d283-4e7f-bda2-054399246ab7	family name	openid-connect	oidc-usermodel-property-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
ef7eaae2-3c9a-4f09-bcb4-ea3a2c2a3efb	given name	openid-connect	oidc-usermodel-property-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
c4c1c811-c796-44d5-b8cb-e0b381caa0b4	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
99f691ee-76a7-4bff-9699-1d3716ab821a	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
cc1d35cc-a327-4ce2-a683-149e82b669f9	username	openid-connect	oidc-usermodel-property-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
9321e978-a435-45eb-8727-d298ab7f0032	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
cacd46bb-3705-4620-9d98-da2f2a5bfaa0	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
fa1e7d89-3f17-46fc-abbf-4979250203b8	website	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
dbf1cf3d-7972-4761-a381-95a1f3fe05f9	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
2c613320-b753-440d-b683-cd4519eeb118	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
d343b5d9-ad4f-4c8f-8389-4f933cfd6926	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
74f638da-7b48-4ddf-ac8f-48d07f055052	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
1fd1e27c-a4b2-4fc5-a21f-da9f4341938e	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	f7f00bb7-1d8f-4e94-90d7-9902bf39a503
dae5fdb2-355c-4f99-ba05-08856456ef68	email	openid-connect	oidc-usermodel-property-mapper	\N	6943da30-3e63-4254-8668-97aff9ecbdc3
60bf39c9-e967-4f4f-9a15-bb1f7a92b24d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	6943da30-3e63-4254-8668-97aff9ecbdc3
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	address	openid-connect	oidc-address-mapper	\N	216918b6-e49c-4398-99cc-5b7004b618b5
7803ca29-2096-4241-bcbe-4b3b73d2e5fe	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f12c60e4-655d-44ef-9bf1-fb9247a6b634
d70283b5-d091-4bba-a7a8-bdc51522fba0	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f12c60e4-655d-44ef-9bf1-fb9247a6b634
884687ac-9304-4c8e-9b06-4bb859e0526c	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	18e8eb55-cdab-48ec-b509-f97659669327
2f091dc6-63c9-45bd-8052-6082fb415b10	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	18e8eb55-cdab-48ec-b509-f97659669327
690e0ff0-6fb7-4a66-b6f4-51d54ca54d3b	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	18e8eb55-cdab-48ec-b509-f97659669327
548612e3-a84a-4d02-9b9e-a365ca443687	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	a18f35dd-3e19-42c0-aa01-9d41078642f6
4702fc35-8ce6-4a97-b214-5e1f0e65a523	upn	openid-connect	oidc-usermodel-property-mapper	\N	ebb5ce8c-b63d-4a46-902a-668873fc2ab9
a3f4caeb-6840-41b2-8f3d-d3b647b6b9eb	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	ebb5ce8c-b63d-4a46-902a-668873fc2ab9
d7b2b7d4-3cf0-48b4-b55d-14d9cf6ca383	audience resolve	openid-connect	oidc-audience-resolve-mapper	c536097d-46a6-4ffb-abd5-20aa7403d251	\N
bbff90c9-cd03-49ef-a7c7-e0a3759c3498	role list	saml	saml-role-list-mapper	\N	9b2b1026-eec7-447a-9f91-7ccb5bb7f7d1
f2e0feab-38e0-49be-b121-c3aa33a8a298	full name	openid-connect	oidc-full-name-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
150fa4cd-4bf9-40a2-a8f6-bf7f46a53cd2	family name	openid-connect	oidc-usermodel-property-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
2f9b7152-c35e-49c3-a34c-462816984f85	given name	openid-connect	oidc-usermodel-property-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
5baee53f-f3ac-49a9-ab45-fa0dd15be029	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
d4ae7274-208a-4b8f-a67a-e34be20828de	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
5295d98e-5b77-4ef9-80af-7906b3331a0b	username	openid-connect	oidc-usermodel-property-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
27816d93-6d8a-48b6-97c0-5018ee31566d	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
e714acb4-07c7-461b-9185-940dd586dba2	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
d5791309-3478-413f-9907-8fb5bb65a83b	website	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
e879a008-8537-443e-9720-b424dbcdfe75	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
02667b43-f6a7-44c9-8bff-90bba5244699	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
a061765e-ac02-43a6-b338-646d90516eae	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
3291c47a-7283-430d-a8f0-30de09951a3a	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
d551d838-3bff-4291-91e4-171f63187704	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	1eb31e46-1a19-4937-83f6-9cb8e079e47f
b8805f86-e24c-41ee-a0ae-05c8f7095660	email	openid-connect	oidc-usermodel-property-mapper	\N	c9a0646f-a17b-4efe-b678-ff97b200adeb
9376b2b5-2690-4859-a544-fd90f761cc01	email verified	openid-connect	oidc-usermodel-property-mapper	\N	c9a0646f-a17b-4efe-b678-ff97b200adeb
5e1f75ea-493c-4ac8-8165-e35649437d78	address	openid-connect	oidc-address-mapper	\N	de5865df-f1b0-4c1c-9a0b-26374cec52cc
78a9b724-9157-442b-9d42-5a258dc9c8ac	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	1890ab4e-72c5-406f-8e78-6bdcf15ae09b
9bb0d713-a031-49a8-9c66-a4f9c21a0ed0	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	1890ab4e-72c5-406f-8e78-6bdcf15ae09b
4028857a-193c-4425-b0da-870546e28b08	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	a7d14333-728d-461d-a865-32ee7040a601
f4b3fb52-dc32-4b20-8434-43deed3dc7de	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	a7d14333-728d-461d-a865-32ee7040a601
bdb37113-5d2d-488d-804b-d9eff2ac229a	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	a7d14333-728d-461d-a865-32ee7040a601
2766cd92-8b96-4970-9a46-3f11195c7874	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	1891fce2-87a3-4ea3-a365-1af7f1425ccd
a74dacac-d38d-41e3-9c11-fbb08b6fb509	upn	openid-connect	oidc-usermodel-property-mapper	\N	f6e4b664-06bb-4980-9444-9e077ac85e6f
eb62e778-c17b-4969-8154-03e5aa2fbf7a	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	f6e4b664-06bb-4980-9444-9e077ac85e6f
606cc17a-933c-4d84-a18b-52e70dd53641	locale	openid-connect	oidc-usermodel-attribute-mapper	8d3fee78-8370-4abb-8753-0772dea06afc	\N
\.


--
-- TOC entry 3791 (class 0 OID 21141)
-- Dependencies: 227
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
0df8e04f-44e1-4934-981b-daf71f03edc9	true	userinfo.token.claim
0df8e04f-44e1-4934-981b-daf71f03edc9	locale	user.attribute
0df8e04f-44e1-4934-981b-daf71f03edc9	true	id.token.claim
0df8e04f-44e1-4934-981b-daf71f03edc9	true	access.token.claim
0df8e04f-44e1-4934-981b-daf71f03edc9	locale	claim.name
0df8e04f-44e1-4934-981b-daf71f03edc9	String	jsonType.label
f318f0b7-1167-47ed-9a95-60499eaeb444	false	single
f318f0b7-1167-47ed-9a95-60499eaeb444	Basic	attribute.nameformat
f318f0b7-1167-47ed-9a95-60499eaeb444	Role	attribute.name
5ab6c53a-f99b-4c65-9818-a0822241e0d4	true	userinfo.token.claim
5ab6c53a-f99b-4c65-9818-a0822241e0d4	true	id.token.claim
5ab6c53a-f99b-4c65-9818-a0822241e0d4	true	access.token.claim
0f29fcef-d283-4e7f-bda2-054399246ab7	true	userinfo.token.claim
0f29fcef-d283-4e7f-bda2-054399246ab7	lastName	user.attribute
0f29fcef-d283-4e7f-bda2-054399246ab7	true	id.token.claim
0f29fcef-d283-4e7f-bda2-054399246ab7	true	access.token.claim
0f29fcef-d283-4e7f-bda2-054399246ab7	family_name	claim.name
0f29fcef-d283-4e7f-bda2-054399246ab7	String	jsonType.label
ef7eaae2-3c9a-4f09-bcb4-ea3a2c2a3efb	true	userinfo.token.claim
ef7eaae2-3c9a-4f09-bcb4-ea3a2c2a3efb	firstName	user.attribute
ef7eaae2-3c9a-4f09-bcb4-ea3a2c2a3efb	true	id.token.claim
ef7eaae2-3c9a-4f09-bcb4-ea3a2c2a3efb	true	access.token.claim
ef7eaae2-3c9a-4f09-bcb4-ea3a2c2a3efb	given_name	claim.name
ef7eaae2-3c9a-4f09-bcb4-ea3a2c2a3efb	String	jsonType.label
c4c1c811-c796-44d5-b8cb-e0b381caa0b4	true	userinfo.token.claim
c4c1c811-c796-44d5-b8cb-e0b381caa0b4	middleName	user.attribute
c4c1c811-c796-44d5-b8cb-e0b381caa0b4	true	id.token.claim
c4c1c811-c796-44d5-b8cb-e0b381caa0b4	true	access.token.claim
c4c1c811-c796-44d5-b8cb-e0b381caa0b4	middle_name	claim.name
c4c1c811-c796-44d5-b8cb-e0b381caa0b4	String	jsonType.label
99f691ee-76a7-4bff-9699-1d3716ab821a	true	userinfo.token.claim
99f691ee-76a7-4bff-9699-1d3716ab821a	nickname	user.attribute
99f691ee-76a7-4bff-9699-1d3716ab821a	true	id.token.claim
99f691ee-76a7-4bff-9699-1d3716ab821a	true	access.token.claim
99f691ee-76a7-4bff-9699-1d3716ab821a	nickname	claim.name
99f691ee-76a7-4bff-9699-1d3716ab821a	String	jsonType.label
cc1d35cc-a327-4ce2-a683-149e82b669f9	true	userinfo.token.claim
cc1d35cc-a327-4ce2-a683-149e82b669f9	username	user.attribute
cc1d35cc-a327-4ce2-a683-149e82b669f9	true	id.token.claim
cc1d35cc-a327-4ce2-a683-149e82b669f9	true	access.token.claim
cc1d35cc-a327-4ce2-a683-149e82b669f9	preferred_username	claim.name
cc1d35cc-a327-4ce2-a683-149e82b669f9	String	jsonType.label
9321e978-a435-45eb-8727-d298ab7f0032	true	userinfo.token.claim
9321e978-a435-45eb-8727-d298ab7f0032	profile	user.attribute
9321e978-a435-45eb-8727-d298ab7f0032	true	id.token.claim
9321e978-a435-45eb-8727-d298ab7f0032	true	access.token.claim
9321e978-a435-45eb-8727-d298ab7f0032	profile	claim.name
9321e978-a435-45eb-8727-d298ab7f0032	String	jsonType.label
cacd46bb-3705-4620-9d98-da2f2a5bfaa0	true	userinfo.token.claim
cacd46bb-3705-4620-9d98-da2f2a5bfaa0	picture	user.attribute
cacd46bb-3705-4620-9d98-da2f2a5bfaa0	true	id.token.claim
cacd46bb-3705-4620-9d98-da2f2a5bfaa0	true	access.token.claim
cacd46bb-3705-4620-9d98-da2f2a5bfaa0	picture	claim.name
cacd46bb-3705-4620-9d98-da2f2a5bfaa0	String	jsonType.label
fa1e7d89-3f17-46fc-abbf-4979250203b8	true	userinfo.token.claim
fa1e7d89-3f17-46fc-abbf-4979250203b8	website	user.attribute
fa1e7d89-3f17-46fc-abbf-4979250203b8	true	id.token.claim
fa1e7d89-3f17-46fc-abbf-4979250203b8	true	access.token.claim
fa1e7d89-3f17-46fc-abbf-4979250203b8	website	claim.name
fa1e7d89-3f17-46fc-abbf-4979250203b8	String	jsonType.label
dbf1cf3d-7972-4761-a381-95a1f3fe05f9	true	userinfo.token.claim
dbf1cf3d-7972-4761-a381-95a1f3fe05f9	gender	user.attribute
dbf1cf3d-7972-4761-a381-95a1f3fe05f9	true	id.token.claim
dbf1cf3d-7972-4761-a381-95a1f3fe05f9	true	access.token.claim
dbf1cf3d-7972-4761-a381-95a1f3fe05f9	gender	claim.name
dbf1cf3d-7972-4761-a381-95a1f3fe05f9	String	jsonType.label
2c613320-b753-440d-b683-cd4519eeb118	true	userinfo.token.claim
2c613320-b753-440d-b683-cd4519eeb118	birthdate	user.attribute
2c613320-b753-440d-b683-cd4519eeb118	true	id.token.claim
2c613320-b753-440d-b683-cd4519eeb118	true	access.token.claim
2c613320-b753-440d-b683-cd4519eeb118	birthdate	claim.name
2c613320-b753-440d-b683-cd4519eeb118	String	jsonType.label
d343b5d9-ad4f-4c8f-8389-4f933cfd6926	true	userinfo.token.claim
d343b5d9-ad4f-4c8f-8389-4f933cfd6926	zoneinfo	user.attribute
d343b5d9-ad4f-4c8f-8389-4f933cfd6926	true	id.token.claim
d343b5d9-ad4f-4c8f-8389-4f933cfd6926	true	access.token.claim
d343b5d9-ad4f-4c8f-8389-4f933cfd6926	zoneinfo	claim.name
d343b5d9-ad4f-4c8f-8389-4f933cfd6926	String	jsonType.label
74f638da-7b48-4ddf-ac8f-48d07f055052	true	userinfo.token.claim
74f638da-7b48-4ddf-ac8f-48d07f055052	locale	user.attribute
74f638da-7b48-4ddf-ac8f-48d07f055052	true	id.token.claim
74f638da-7b48-4ddf-ac8f-48d07f055052	true	access.token.claim
74f638da-7b48-4ddf-ac8f-48d07f055052	locale	claim.name
74f638da-7b48-4ddf-ac8f-48d07f055052	String	jsonType.label
1fd1e27c-a4b2-4fc5-a21f-da9f4341938e	true	userinfo.token.claim
1fd1e27c-a4b2-4fc5-a21f-da9f4341938e	updatedAt	user.attribute
1fd1e27c-a4b2-4fc5-a21f-da9f4341938e	true	id.token.claim
1fd1e27c-a4b2-4fc5-a21f-da9f4341938e	true	access.token.claim
1fd1e27c-a4b2-4fc5-a21f-da9f4341938e	updated_at	claim.name
1fd1e27c-a4b2-4fc5-a21f-da9f4341938e	String	jsonType.label
dae5fdb2-355c-4f99-ba05-08856456ef68	true	userinfo.token.claim
dae5fdb2-355c-4f99-ba05-08856456ef68	email	user.attribute
dae5fdb2-355c-4f99-ba05-08856456ef68	true	id.token.claim
dae5fdb2-355c-4f99-ba05-08856456ef68	true	access.token.claim
dae5fdb2-355c-4f99-ba05-08856456ef68	email	claim.name
dae5fdb2-355c-4f99-ba05-08856456ef68	String	jsonType.label
60bf39c9-e967-4f4f-9a15-bb1f7a92b24d	true	userinfo.token.claim
60bf39c9-e967-4f4f-9a15-bb1f7a92b24d	emailVerified	user.attribute
60bf39c9-e967-4f4f-9a15-bb1f7a92b24d	true	id.token.claim
60bf39c9-e967-4f4f-9a15-bb1f7a92b24d	true	access.token.claim
60bf39c9-e967-4f4f-9a15-bb1f7a92b24d	email_verified	claim.name
60bf39c9-e967-4f4f-9a15-bb1f7a92b24d	boolean	jsonType.label
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	formatted	user.attribute.formatted
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	country	user.attribute.country
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	postal_code	user.attribute.postal_code
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	true	userinfo.token.claim
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	street	user.attribute.street
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	true	id.token.claim
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	region	user.attribute.region
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	true	access.token.claim
e94ba0b7-2ab3-49f5-8fdf-8d58ead06b9e	locality	user.attribute.locality
7803ca29-2096-4241-bcbe-4b3b73d2e5fe	true	userinfo.token.claim
7803ca29-2096-4241-bcbe-4b3b73d2e5fe	phoneNumber	user.attribute
7803ca29-2096-4241-bcbe-4b3b73d2e5fe	true	id.token.claim
7803ca29-2096-4241-bcbe-4b3b73d2e5fe	true	access.token.claim
7803ca29-2096-4241-bcbe-4b3b73d2e5fe	phone_number	claim.name
7803ca29-2096-4241-bcbe-4b3b73d2e5fe	String	jsonType.label
d70283b5-d091-4bba-a7a8-bdc51522fba0	true	userinfo.token.claim
d70283b5-d091-4bba-a7a8-bdc51522fba0	phoneNumberVerified	user.attribute
d70283b5-d091-4bba-a7a8-bdc51522fba0	true	id.token.claim
d70283b5-d091-4bba-a7a8-bdc51522fba0	true	access.token.claim
d70283b5-d091-4bba-a7a8-bdc51522fba0	phone_number_verified	claim.name
d70283b5-d091-4bba-a7a8-bdc51522fba0	boolean	jsonType.label
884687ac-9304-4c8e-9b06-4bb859e0526c	true	multivalued
884687ac-9304-4c8e-9b06-4bb859e0526c	foo	user.attribute
884687ac-9304-4c8e-9b06-4bb859e0526c	true	access.token.claim
884687ac-9304-4c8e-9b06-4bb859e0526c	realm_access.roles	claim.name
884687ac-9304-4c8e-9b06-4bb859e0526c	String	jsonType.label
2f091dc6-63c9-45bd-8052-6082fb415b10	true	multivalued
2f091dc6-63c9-45bd-8052-6082fb415b10	foo	user.attribute
2f091dc6-63c9-45bd-8052-6082fb415b10	true	access.token.claim
2f091dc6-63c9-45bd-8052-6082fb415b10	resource_access.${client_id}.roles	claim.name
2f091dc6-63c9-45bd-8052-6082fb415b10	String	jsonType.label
4702fc35-8ce6-4a97-b214-5e1f0e65a523	true	userinfo.token.claim
4702fc35-8ce6-4a97-b214-5e1f0e65a523	username	user.attribute
4702fc35-8ce6-4a97-b214-5e1f0e65a523	true	id.token.claim
4702fc35-8ce6-4a97-b214-5e1f0e65a523	true	access.token.claim
4702fc35-8ce6-4a97-b214-5e1f0e65a523	upn	claim.name
4702fc35-8ce6-4a97-b214-5e1f0e65a523	String	jsonType.label
a3f4caeb-6840-41b2-8f3d-d3b647b6b9eb	true	multivalued
a3f4caeb-6840-41b2-8f3d-d3b647b6b9eb	foo	user.attribute
a3f4caeb-6840-41b2-8f3d-d3b647b6b9eb	true	id.token.claim
a3f4caeb-6840-41b2-8f3d-d3b647b6b9eb	true	access.token.claim
a3f4caeb-6840-41b2-8f3d-d3b647b6b9eb	groups	claim.name
a3f4caeb-6840-41b2-8f3d-d3b647b6b9eb	String	jsonType.label
bbff90c9-cd03-49ef-a7c7-e0a3759c3498	false	single
bbff90c9-cd03-49ef-a7c7-e0a3759c3498	Basic	attribute.nameformat
bbff90c9-cd03-49ef-a7c7-e0a3759c3498	Role	attribute.name
f2e0feab-38e0-49be-b121-c3aa33a8a298	true	userinfo.token.claim
f2e0feab-38e0-49be-b121-c3aa33a8a298	true	id.token.claim
f2e0feab-38e0-49be-b121-c3aa33a8a298	true	access.token.claim
150fa4cd-4bf9-40a2-a8f6-bf7f46a53cd2	true	userinfo.token.claim
150fa4cd-4bf9-40a2-a8f6-bf7f46a53cd2	lastName	user.attribute
150fa4cd-4bf9-40a2-a8f6-bf7f46a53cd2	true	id.token.claim
150fa4cd-4bf9-40a2-a8f6-bf7f46a53cd2	true	access.token.claim
150fa4cd-4bf9-40a2-a8f6-bf7f46a53cd2	family_name	claim.name
150fa4cd-4bf9-40a2-a8f6-bf7f46a53cd2	String	jsonType.label
2f9b7152-c35e-49c3-a34c-462816984f85	true	userinfo.token.claim
2f9b7152-c35e-49c3-a34c-462816984f85	firstName	user.attribute
2f9b7152-c35e-49c3-a34c-462816984f85	true	id.token.claim
2f9b7152-c35e-49c3-a34c-462816984f85	true	access.token.claim
2f9b7152-c35e-49c3-a34c-462816984f85	given_name	claim.name
2f9b7152-c35e-49c3-a34c-462816984f85	String	jsonType.label
5baee53f-f3ac-49a9-ab45-fa0dd15be029	true	userinfo.token.claim
5baee53f-f3ac-49a9-ab45-fa0dd15be029	middleName	user.attribute
5baee53f-f3ac-49a9-ab45-fa0dd15be029	true	id.token.claim
5baee53f-f3ac-49a9-ab45-fa0dd15be029	true	access.token.claim
5baee53f-f3ac-49a9-ab45-fa0dd15be029	middle_name	claim.name
5baee53f-f3ac-49a9-ab45-fa0dd15be029	String	jsonType.label
d4ae7274-208a-4b8f-a67a-e34be20828de	true	userinfo.token.claim
d4ae7274-208a-4b8f-a67a-e34be20828de	nickname	user.attribute
d4ae7274-208a-4b8f-a67a-e34be20828de	true	id.token.claim
d4ae7274-208a-4b8f-a67a-e34be20828de	true	access.token.claim
d4ae7274-208a-4b8f-a67a-e34be20828de	nickname	claim.name
d4ae7274-208a-4b8f-a67a-e34be20828de	String	jsonType.label
5295d98e-5b77-4ef9-80af-7906b3331a0b	true	userinfo.token.claim
5295d98e-5b77-4ef9-80af-7906b3331a0b	username	user.attribute
5295d98e-5b77-4ef9-80af-7906b3331a0b	true	id.token.claim
5295d98e-5b77-4ef9-80af-7906b3331a0b	true	access.token.claim
5295d98e-5b77-4ef9-80af-7906b3331a0b	preferred_username	claim.name
5295d98e-5b77-4ef9-80af-7906b3331a0b	String	jsonType.label
27816d93-6d8a-48b6-97c0-5018ee31566d	true	userinfo.token.claim
27816d93-6d8a-48b6-97c0-5018ee31566d	profile	user.attribute
27816d93-6d8a-48b6-97c0-5018ee31566d	true	id.token.claim
27816d93-6d8a-48b6-97c0-5018ee31566d	true	access.token.claim
27816d93-6d8a-48b6-97c0-5018ee31566d	profile	claim.name
27816d93-6d8a-48b6-97c0-5018ee31566d	String	jsonType.label
e714acb4-07c7-461b-9185-940dd586dba2	true	userinfo.token.claim
e714acb4-07c7-461b-9185-940dd586dba2	picture	user.attribute
e714acb4-07c7-461b-9185-940dd586dba2	true	id.token.claim
e714acb4-07c7-461b-9185-940dd586dba2	true	access.token.claim
e714acb4-07c7-461b-9185-940dd586dba2	picture	claim.name
e714acb4-07c7-461b-9185-940dd586dba2	String	jsonType.label
d5791309-3478-413f-9907-8fb5bb65a83b	true	userinfo.token.claim
d5791309-3478-413f-9907-8fb5bb65a83b	website	user.attribute
d5791309-3478-413f-9907-8fb5bb65a83b	true	id.token.claim
d5791309-3478-413f-9907-8fb5bb65a83b	true	access.token.claim
d5791309-3478-413f-9907-8fb5bb65a83b	website	claim.name
d5791309-3478-413f-9907-8fb5bb65a83b	String	jsonType.label
e879a008-8537-443e-9720-b424dbcdfe75	true	userinfo.token.claim
e879a008-8537-443e-9720-b424dbcdfe75	gender	user.attribute
e879a008-8537-443e-9720-b424dbcdfe75	true	id.token.claim
e879a008-8537-443e-9720-b424dbcdfe75	true	access.token.claim
e879a008-8537-443e-9720-b424dbcdfe75	gender	claim.name
e879a008-8537-443e-9720-b424dbcdfe75	String	jsonType.label
02667b43-f6a7-44c9-8bff-90bba5244699	true	userinfo.token.claim
02667b43-f6a7-44c9-8bff-90bba5244699	birthdate	user.attribute
02667b43-f6a7-44c9-8bff-90bba5244699	true	id.token.claim
02667b43-f6a7-44c9-8bff-90bba5244699	true	access.token.claim
02667b43-f6a7-44c9-8bff-90bba5244699	birthdate	claim.name
02667b43-f6a7-44c9-8bff-90bba5244699	String	jsonType.label
a061765e-ac02-43a6-b338-646d90516eae	true	userinfo.token.claim
a061765e-ac02-43a6-b338-646d90516eae	zoneinfo	user.attribute
a061765e-ac02-43a6-b338-646d90516eae	true	id.token.claim
a061765e-ac02-43a6-b338-646d90516eae	true	access.token.claim
a061765e-ac02-43a6-b338-646d90516eae	zoneinfo	claim.name
a061765e-ac02-43a6-b338-646d90516eae	String	jsonType.label
3291c47a-7283-430d-a8f0-30de09951a3a	true	userinfo.token.claim
3291c47a-7283-430d-a8f0-30de09951a3a	locale	user.attribute
3291c47a-7283-430d-a8f0-30de09951a3a	true	id.token.claim
3291c47a-7283-430d-a8f0-30de09951a3a	true	access.token.claim
3291c47a-7283-430d-a8f0-30de09951a3a	locale	claim.name
3291c47a-7283-430d-a8f0-30de09951a3a	String	jsonType.label
d551d838-3bff-4291-91e4-171f63187704	true	userinfo.token.claim
d551d838-3bff-4291-91e4-171f63187704	updatedAt	user.attribute
d551d838-3bff-4291-91e4-171f63187704	true	id.token.claim
d551d838-3bff-4291-91e4-171f63187704	true	access.token.claim
d551d838-3bff-4291-91e4-171f63187704	updated_at	claim.name
d551d838-3bff-4291-91e4-171f63187704	String	jsonType.label
b8805f86-e24c-41ee-a0ae-05c8f7095660	true	userinfo.token.claim
b8805f86-e24c-41ee-a0ae-05c8f7095660	email	user.attribute
b8805f86-e24c-41ee-a0ae-05c8f7095660	true	id.token.claim
b8805f86-e24c-41ee-a0ae-05c8f7095660	true	access.token.claim
b8805f86-e24c-41ee-a0ae-05c8f7095660	email	claim.name
b8805f86-e24c-41ee-a0ae-05c8f7095660	String	jsonType.label
9376b2b5-2690-4859-a544-fd90f761cc01	true	userinfo.token.claim
9376b2b5-2690-4859-a544-fd90f761cc01	emailVerified	user.attribute
9376b2b5-2690-4859-a544-fd90f761cc01	true	id.token.claim
9376b2b5-2690-4859-a544-fd90f761cc01	true	access.token.claim
9376b2b5-2690-4859-a544-fd90f761cc01	email_verified	claim.name
9376b2b5-2690-4859-a544-fd90f761cc01	boolean	jsonType.label
5e1f75ea-493c-4ac8-8165-e35649437d78	formatted	user.attribute.formatted
5e1f75ea-493c-4ac8-8165-e35649437d78	country	user.attribute.country
5e1f75ea-493c-4ac8-8165-e35649437d78	postal_code	user.attribute.postal_code
5e1f75ea-493c-4ac8-8165-e35649437d78	true	userinfo.token.claim
5e1f75ea-493c-4ac8-8165-e35649437d78	street	user.attribute.street
5e1f75ea-493c-4ac8-8165-e35649437d78	true	id.token.claim
5e1f75ea-493c-4ac8-8165-e35649437d78	region	user.attribute.region
5e1f75ea-493c-4ac8-8165-e35649437d78	true	access.token.claim
5e1f75ea-493c-4ac8-8165-e35649437d78	locality	user.attribute.locality
78a9b724-9157-442b-9d42-5a258dc9c8ac	true	userinfo.token.claim
78a9b724-9157-442b-9d42-5a258dc9c8ac	phoneNumber	user.attribute
78a9b724-9157-442b-9d42-5a258dc9c8ac	true	id.token.claim
78a9b724-9157-442b-9d42-5a258dc9c8ac	true	access.token.claim
78a9b724-9157-442b-9d42-5a258dc9c8ac	phone_number	claim.name
78a9b724-9157-442b-9d42-5a258dc9c8ac	String	jsonType.label
9bb0d713-a031-49a8-9c66-a4f9c21a0ed0	true	userinfo.token.claim
9bb0d713-a031-49a8-9c66-a4f9c21a0ed0	phoneNumberVerified	user.attribute
9bb0d713-a031-49a8-9c66-a4f9c21a0ed0	true	id.token.claim
9bb0d713-a031-49a8-9c66-a4f9c21a0ed0	true	access.token.claim
9bb0d713-a031-49a8-9c66-a4f9c21a0ed0	phone_number_verified	claim.name
9bb0d713-a031-49a8-9c66-a4f9c21a0ed0	boolean	jsonType.label
4028857a-193c-4425-b0da-870546e28b08	true	multivalued
4028857a-193c-4425-b0da-870546e28b08	foo	user.attribute
4028857a-193c-4425-b0da-870546e28b08	true	access.token.claim
4028857a-193c-4425-b0da-870546e28b08	realm_access.roles	claim.name
4028857a-193c-4425-b0da-870546e28b08	String	jsonType.label
f4b3fb52-dc32-4b20-8434-43deed3dc7de	true	multivalued
f4b3fb52-dc32-4b20-8434-43deed3dc7de	foo	user.attribute
f4b3fb52-dc32-4b20-8434-43deed3dc7de	true	access.token.claim
f4b3fb52-dc32-4b20-8434-43deed3dc7de	resource_access.${client_id}.roles	claim.name
f4b3fb52-dc32-4b20-8434-43deed3dc7de	String	jsonType.label
a74dacac-d38d-41e3-9c11-fbb08b6fb509	true	userinfo.token.claim
a74dacac-d38d-41e3-9c11-fbb08b6fb509	username	user.attribute
a74dacac-d38d-41e3-9c11-fbb08b6fb509	true	id.token.claim
a74dacac-d38d-41e3-9c11-fbb08b6fb509	true	access.token.claim
a74dacac-d38d-41e3-9c11-fbb08b6fb509	upn	claim.name
a74dacac-d38d-41e3-9c11-fbb08b6fb509	String	jsonType.label
eb62e778-c17b-4969-8154-03e5aa2fbf7a	true	multivalued
eb62e778-c17b-4969-8154-03e5aa2fbf7a	foo	user.attribute
eb62e778-c17b-4969-8154-03e5aa2fbf7a	true	id.token.claim
eb62e778-c17b-4969-8154-03e5aa2fbf7a	true	access.token.claim
eb62e778-c17b-4969-8154-03e5aa2fbf7a	groups	claim.name
eb62e778-c17b-4969-8154-03e5aa2fbf7a	String	jsonType.label
606cc17a-933c-4d84-a18b-52e70dd53641	true	userinfo.token.claim
606cc17a-933c-4d84-a18b-52e70dd53641	locale	user.attribute
606cc17a-933c-4d84-a18b-52e70dd53641	true	id.token.claim
606cc17a-933c-4d84-a18b-52e70dd53641	true	access.token.claim
606cc17a-933c-4d84-a18b-52e70dd53641	locale	claim.name
606cc17a-933c-4d84-a18b-52e70dd53641	String	jsonType.label
\.


--
-- TOC entry 3770 (class 0 OID 20769)
-- Dependencies: 206
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	9e1fe29c-0379-4c0a-9fa8-11b308cef13b	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	7e5491f9-9087-4a4c-9ad2-6f91b7b10917	aead836b-1e31-4616-a3a4-dc7a2ba36e3a	c737ea31-f9dc-49fc-beb6-404c3f7aa304	1c0a6861-fdcf-4c68-a046-b710e4895112	32e4dc68-6969-41d6-9a34-2bd8ec480f5f	2592000	f	900	t	f	50b1df1c-0a6f-45f9-aaf7-b857609f9f56	0	f	0	0
SpringBootKeycloak	60	300	300	\N	\N	\N	t	f	0	\N	SpringBootKeycloak	1583424789	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	88970e97-34e2-4296-bfbc-4996d44813c1	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	1d558401-0aa7-4ff6-a92f-cb2abb45e926	7d9b84f5-b4de-46ef-ae61-1aae9c1e63ad	bd5495ef-cc38-4f77-9bb8-d254aa320673	e9e28535-a132-486d-b9e5-40967be2ef3c	26153dfc-b3f9-458c-933e-1f97db10c09f	2592000	f	900	t	f	65b125d7-6c20-4329-b9e8-3b52ca81de54	0	f	0	0
\.


--
-- TOC entry 3771 (class 0 OID 20787)
-- Dependencies: 207
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_attribute (name, value, realm_id) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly		master
_browser_header.xContentTypeOptions	nosniff	master
_browser_header.xRobotsTag	none	master
_browser_header.xFrameOptions	SAMEORIGIN	master
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	master
_browser_header.xXSSProtection	1; mode=block	master
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	master
bruteForceProtected	false	master
permanentLockout	false	master
maxFailureWaitSeconds	900	master
minimumQuickLoginWaitSeconds	60	master
waitIncrementSeconds	60	master
quickLoginCheckMilliSeconds	1000	master
maxDeltaTimeSeconds	43200	master
failureFactor	30	master
displayName	Keycloak	master
displayNameHtml	<div class="kc-logo-text"><span>Keycloak</span></div>	master
offlineSessionMaxLifespanEnabled	false	master
offlineSessionMaxLifespan	5184000	master
_browser_header.contentSecurityPolicyReportOnly		SpringBootKeycloak
_browser_header.xContentTypeOptions	nosniff	SpringBootKeycloak
_browser_header.xRobotsTag	none	SpringBootKeycloak
_browser_header.xFrameOptions	SAMEORIGIN	SpringBootKeycloak
_browser_header.contentSecurityPolicy	frame-src 'self'; frame-ancestors 'self'; object-src 'none';	SpringBootKeycloak
_browser_header.xXSSProtection	1; mode=block	SpringBootKeycloak
_browser_header.strictTransportSecurity	max-age=31536000; includeSubDomains	SpringBootKeycloak
bruteForceProtected	false	SpringBootKeycloak
permanentLockout	false	SpringBootKeycloak
maxFailureWaitSeconds	900	SpringBootKeycloak
minimumQuickLoginWaitSeconds	60	SpringBootKeycloak
waitIncrementSeconds	60	SpringBootKeycloak
quickLoginCheckMilliSeconds	1000	SpringBootKeycloak
maxDeltaTimeSeconds	43200	SpringBootKeycloak
failureFactor	30	SpringBootKeycloak
offlineSessionMaxLifespanEnabled	false	SpringBootKeycloak
offlineSessionMaxLifespan	5184000	SpringBootKeycloak
actionTokenGeneratedByAdminLifespan	43200	SpringBootKeycloak
actionTokenGeneratedByUserLifespan	300	SpringBootKeycloak
webAuthnPolicyRpEntityName	keycloak	SpringBootKeycloak
webAuthnPolicySignatureAlgorithms	ES256	SpringBootKeycloak
webAuthnPolicyRpId		SpringBootKeycloak
webAuthnPolicyAttestationConveyancePreference	not specified	SpringBootKeycloak
webAuthnPolicyAuthenticatorAttachment	not specified	SpringBootKeycloak
webAuthnPolicyRequireResidentKey	not specified	SpringBootKeycloak
webAuthnPolicyUserVerificationRequirement	not specified	SpringBootKeycloak
webAuthnPolicyCreateTimeout	0	SpringBootKeycloak
webAuthnPolicyAvoidSameAuthenticatorRegister	false	SpringBootKeycloak
webAuthnPolicyRpEntityNamePasswordless	keycloak	SpringBootKeycloak
webAuthnPolicySignatureAlgorithmsPasswordless	ES256	SpringBootKeycloak
webAuthnPolicyRpIdPasswordless		SpringBootKeycloak
webAuthnPolicyAttestationConveyancePreferencePasswordless	not specified	SpringBootKeycloak
webAuthnPolicyAuthenticatorAttachmentPasswordless	not specified	SpringBootKeycloak
webAuthnPolicyRequireResidentKeyPasswordless	not specified	SpringBootKeycloak
webAuthnPolicyUserVerificationRequirementPasswordless	not specified	SpringBootKeycloak
webAuthnPolicyCreateTimeoutPasswordless	0	SpringBootKeycloak
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	false	SpringBootKeycloak
\.


--
-- TOC entry 3820 (class 0 OID 21576)
-- Dependencies: 256
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- TOC entry 3772 (class 0 OID 20793)
-- Dependencies: 208
-- Data for Name: realm_default_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_default_roles (realm_id, role_id) FROM stdin;
master	fbb73b9b-139a-4397-95b9-330f88bee545
master	72c67b15-67de-4dde-8be3-776cd9927954
SpringBootKeycloak	3218a301-b54c-4b46-adba-02d293af190e
SpringBootKeycloak	f83c25e0-275a-4bb1-acec-f2c11ac06240
\.


--
-- TOC entry 3797 (class 0 OID 21258)
-- Dependencies: 233
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- TOC entry 3773 (class 0 OID 20796)
-- Dependencies: 209
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
SpringBootKeycloak	jboss-logging
\.


--
-- TOC entry 3774 (class 0 OID 20799)
-- Dependencies: 210
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	SpringBootKeycloak
\.


--
-- TOC entry 3775 (class 0 OID 20807)
-- Dependencies: 211
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- TOC entry 3795 (class 0 OID 21173)
-- Dependencies: 231
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- TOC entry 3776 (class 0 OID 20819)
-- Dependencies: 212
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.redirect_uris (client_id, value) FROM stdin;
335fff2e-b205-4fdd-8600-f87a2ba4c930	/realms/master/account/*
2838a207-e8bd-472c-b530-4aa5e8e8799f	/realms/master/account/*
464a276e-f380-4188-bb97-91a65aadd58f	/admin/master/console/*
25f1c990-8983-4f82-ac2c-335368c68457	/realms/SpringBootKeycloak/account/*
c536097d-46a6-4ffb-abd5-20aa7403d251	/realms/SpringBootKeycloak/account/*
8d3fee78-8370-4abb-8753-0772dea06afc	/admin/SpringBootKeycloak/console/*
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	http://localhost:8080/shogun-boot/*
63bb9911-eaa2-49e4-aa52-fbc0582f9c73	http://localhost:8082/shogun-gs-interceptor/*
\.


--
-- TOC entry 3813 (class 0 OID 21507)
-- Dependencies: 249
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- TOC entry 3812 (class 0 OID 21499)
-- Dependencies: 248
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
19c4fea0-764b-4339-b3ed-52bcf517fe8d	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
9e81f062-ddf1-4547-abbe-079bf03d1e68	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
e7593690-1613-4818-a47e-6af8009092b2	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
fb6e78b5-3091-42a4-a2d3-80fff93e4d62	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
20a3b34c-00dd-408d-b98f-5a22409b0c4c	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
4fa08e9c-1fd4-4838-b606-f1d2d2f39b7a	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
5086043a-dc15-4333-9969-c462b89cdd52	VERIFY_EMAIL	Verify Email	SpringBootKeycloak	t	f	VERIFY_EMAIL	50
56bb9be9-2bf4-4568-b67c-e4bedc682fc2	UPDATE_PROFILE	Update Profile	SpringBootKeycloak	t	f	UPDATE_PROFILE	40
a189f16b-2977-43d8-a7ba-1321c73eabe6	CONFIGURE_TOTP	Configure OTP	SpringBootKeycloak	t	f	CONFIGURE_TOTP	10
a0c08bcf-bd0d-4b0c-8e43-7536a7252ace	UPDATE_PASSWORD	Update Password	SpringBootKeycloak	t	f	UPDATE_PASSWORD	30
ef80db1a-90ae-43bb-a422-3e5375093671	terms_and_conditions	Terms and Conditions	SpringBootKeycloak	f	f	terms_and_conditions	20
cb6d6993-f27b-4176-9950-5b449c5ef0dd	update_user_locale	Update User Locale	SpringBootKeycloak	t	f	update_user_locale	1000
\.


--
-- TOC entry 3850 (class 0 OID 22228)
-- Dependencies: 286
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- TOC entry 3830 (class 0 OID 21801)
-- Dependencies: 266
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- TOC entry 3829 (class 0 OID 21786)
-- Dependencies: 265
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- TOC entry 3824 (class 0 OID 21720)
-- Dependencies: 260
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- TOC entry 3849 (class 0 OID 22204)
-- Dependencies: 285
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- TOC entry 3827 (class 0 OID 21758)
-- Dependencies: 263
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- TOC entry 3825 (class 0 OID 21728)
-- Dependencies: 261
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- TOC entry 3826 (class 0 OID 21743)
-- Dependencies: 262
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- TOC entry 3851 (class 0 OID 22247)
-- Dependencies: 287
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- TOC entry 3852 (class 0 OID 22257)
-- Dependencies: 288
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- TOC entry 3777 (class 0 OID 20822)
-- Dependencies: 213
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
2838a207-e8bd-472c-b530-4aa5e8e8799f	d2d4716c-16e6-4dd3-a6b3-a5bc53945ff5
c536097d-46a6-4ffb-abd5-20aa7403d251	a30db9ce-a621-4acf-8c7a-d91468d7d8c9
\.


--
-- TOC entry 3831 (class 0 OID 21816)
-- Dependencies: 267
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- TOC entry 3779 (class 0 OID 20828)
-- Dependencies: 215
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- TOC entry 3801 (class 0 OID 21281)
-- Dependencies: 237
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 3847 (class 0 OID 22179)
-- Dependencies: 283
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 3780 (class 0 OID 20834)
-- Dependencies: 216
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
b192959c-754b-49e7-9bd9-58df41e29818	\N	81466f61-4557-4669-994f-214374ac4ab6	f	t	\N	\N	\N	master	admin	1583400099988	\N	0
96ff7058-59a9-4fc3-a851-5c901b5731c9	\N	3aced532-4e78-4f3f-8c00-31e3b9bcb586	f	t	\N	\N	\N	SpringBootKeycloak	shogun	1583424058096	\N	0
\.


--
-- TOC entry 3781 (class 0 OID 20843)
-- Dependencies: 217
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 3808 (class 0 OID 21397)
-- Dependencies: 244
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- TOC entry 3809 (class 0 OID 21403)
-- Dependencies: 245
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 3782 (class 0 OID 20849)
-- Dependencies: 218
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- TOC entry 3819 (class 0 OID 21573)
-- Dependencies: 255
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- TOC entry 3783 (class 0 OID 20855)
-- Dependencies: 219
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- TOC entry 3784 (class 0 OID 20858)
-- Dependencies: 220
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
d2d4716c-16e6-4dd3-a6b3-a5bc53945ff5	b192959c-754b-49e7-9bd9-58df41e29818
72c67b15-67de-4dde-8be3-776cd9927954	b192959c-754b-49e7-9bd9-58df41e29818
3ecc9bc3-bc92-4e24-8cd8-a417039e8b8b	b192959c-754b-49e7-9bd9-58df41e29818
fbb73b9b-139a-4397-95b9-330f88bee545	b192959c-754b-49e7-9bd9-58df41e29818
038e2a9b-e49c-45c4-a598-6652fcb8c40c	b192959c-754b-49e7-9bd9-58df41e29818
3218a301-b54c-4b46-adba-02d293af190e	96ff7058-59a9-4fc3-a851-5c901b5731c9
f83c25e0-275a-4bb1-acec-f2c11ac06240	96ff7058-59a9-4fc3-a851-5c901b5731c9
d97fb25a-d8e8-4d55-aabc-489ffdc0e576	96ff7058-59a9-4fc3-a851-5c901b5731c9
a30db9ce-a621-4acf-8c7a-d91468d7d8c9	96ff7058-59a9-4fc3-a851-5c901b5731c9
0b8f2e5e-f4e7-40af-95f5-67b41280b62d	96ff7058-59a9-4fc3-a851-5c901b5731c9
\.


--
-- TOC entry 3785 (class 0 OID 20861)
-- Dependencies: 221
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- TOC entry 3796 (class 0 OID 21176)
-- Dependencies: 232
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- TOC entry 3778 (class 0 OID 20825)
-- Dependencies: 214
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- TOC entry 3786 (class 0 OID 20874)
-- Dependencies: 222
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.web_origins (client_id, value) FROM stdin;
464a276e-f380-4188-bb97-91a65aadd58f	+
8d3fee78-8370-4abb-8753-0772dea06afc	+
\.


--
-- TOC entry 3316 (class 2606 OID 21970)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3284 (class 2606 OID 22284)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3524 (class 2606 OID 22109)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3526 (class 2606 OID 22152)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3521 (class 2606 OID 21984)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3438 (class 2606 OID 21615)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3486 (class 2606 OID 21903)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3412 (class 2606 OID 21520)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3261 (class 2606 OID 22078)
-- Name: client_default_roles constr_client_default_roles; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT constr_client_default_roles PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3512 (class 2606 OID 21923)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3515 (class 2606 OID 21921)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3504 (class 2606 OID 21919)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3488 (class 2606 OID 21905)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3491 (class 2606 OID 21907)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3496 (class 2606 OID 21913)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3500 (class 2606 OID 21915)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3508 (class 2606 OID 21917)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3519 (class 2606 OID 21963)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3440 (class 2606 OID 22068)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3372 (class 2606 OID 22085)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3303 (class 2606 OID 22087)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3367 (class 2606 OID 22089)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3360 (class 2606 OID 21186)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3344 (class 2606 OID 21114)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3282 (class 2606 OID 20886)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3356 (class 2606 OID 21188)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3290 (class 2606 OID 20888)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3273 (class 2606 OID 20890)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3339 (class 2606 OID 20892)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3330 (class 2606 OID 20894)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3346 (class 2606 OID 21116)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3266 (class 2606 OID 20898)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3270 (class 2606 OID 20900)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3313 (class 2606 OID 20902)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3348 (class 2606 OID 21118)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3295 (class 2606 OID 20904)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3306 (class 2606 OID 20906)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3286 (class 2606 OID 20908)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3390 (class 2606 OID 22072)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3402 (class 2606 OID 21425)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3398 (class 2606 OID 21423)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3395 (class 2606 OID 21421)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3392 (class 2606 OID 21419)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3410 (class 2606 OID 21429)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3336 (class 2606 OID 20910)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3275 (class 2606 OID 22066)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3388 (class 2606 OID 21306)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3365 (class 2606 OID 21190)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3472 (class 2606 OID 21780)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3308 (class 2606 OID 20912)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3279 (class 2606 OID 20914)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3328 (class 2606 OID 20916)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3539 (class 2606 OID 22208)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3457 (class 2606 OID 21735)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3467 (class 2606 OID 21765)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3483 (class 2606 OID 21835)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3477 (class 2606 OID 21805)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3462 (class 2606 OID 21750)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3474 (class 2606 OID 21790)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3480 (class 2606 OID 21820)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3321 (class 2606 OID 20918)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3408 (class 2606 OID 21433)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3404 (class 2606 OID 21431)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3537 (class 2606 OID 22193)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3534 (class 2606 OID 22183)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3383 (class 2606 OID 21300)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3425 (class 2606 OID 21582)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3432 (class 2606 OID 21589)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3429 (class 2606 OID 21603)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3378 (class 2606 OID 21296)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3381 (class 2606 OID 21482)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3375 (class 2606 OID 21294)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3422 (class 2606 OID 22291)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3419 (class 2606 OID 21557)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3350 (class 2606 OID 21184)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3354 (class 2606 OID 21475)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3298 (class 2606 OID 22064)
-- Name: realm_default_roles constraint_realm_default_roles; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT constraint_realm_default_roles PRIMARY KEY (realm_id, role_id);


--
-- TOC entry 3310 (class 2606 OID 22091)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3417 (class 2606 OID 21518)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3414 (class 2606 OID 21516)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3333 (class 2606 OID 21427)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3545 (class 2606 OID 22256)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3547 (class 2606 OID 22264)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3318 (class 2606 OID 21514)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3435 (class 2606 OID 21596)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3370 (class 2606 OID 21194)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3341 (class 2606 OID 22093)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3449 (class 2606 OID 21701)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3444 (class 2606 OID 21660)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3259 (class 2606 OID 20713)
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- TOC entry 3455 (class 2606 OID 22046)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3453 (class 2606 OID 21689)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3532 (class 2606 OID 22168)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3543 (class 2606 OID 22236)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3427 (class 2606 OID 21976)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3363 (class 2606 OID 21241)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3264 (class 2606 OID 20920)
-- Name: client_default_roles uk_8aelwnibji49avxsrtuf6xjow; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT uk_8aelwnibji49avxsrtuf6xjow UNIQUE (role_id);


--
-- TOC entry 3268 (class 2606 OID 20922)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3446 (class 2606 OID 22121)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3324 (class 2606 OID 20926)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3460 (class 2606 OID 22300)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3541 (class 2606 OID 22295)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3470 (class 2606 OID 22037)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3465 (class 2606 OID 22041)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3301 (class 2606 OID 20928)
-- Name: realm_default_roles uk_h4wpd7w4hsoolni3h0sw7btje; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT uk_h4wpd7w4hsoolni3h0sw7btje UNIQUE (role_id);


--
-- TOC entry 3386 (class 2606 OID 22286)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3293 (class 2606 OID 20934)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3326 (class 2606 OID 21965)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3484 (class 1259 OID 21990)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3393 (class 1259 OID 21994)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3399 (class 1259 OID 21992)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3400 (class 1259 OID 21991)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3396 (class 1259 OID 21993)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3527 (class 1259 OID 22200)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3262 (class 1259 OID 21996)
-- Name: idx_client_def_roles_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_def_roles_client ON public.client_default_roles USING btree (client_id);


--
-- TOC entry 3522 (class 1259 OID 22034)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3271 (class 1259 OID 21998)
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- TOC entry 3447 (class 1259 OID 22198)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3528 (class 1259 OID 22199)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3351 (class 1259 OID 22195)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3450 (class 1259 OID 22196)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3513 (class 1259 OID 22000)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3516 (class 1259 OID 22271)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3517 (class 1259 OID 21999)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3276 (class 1259 OID 22001)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3277 (class 1259 OID 22002)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3529 (class 1259 OID 22201)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3530 (class 1259 OID 22202)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3357 (class 1259 OID 21719)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3358 (class 1259 OID 21718)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3489 (class 1259 OID 22094)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3492 (class 1259 OID 22115)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3493 (class 1259 OID 22282)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3494 (class 1259 OID 22096)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3497 (class 1259 OID 22097)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3498 (class 1259 OID 22098)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3501 (class 1259 OID 22099)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3502 (class 1259 OID 22100)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3505 (class 1259 OID 22101)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3506 (class 1259 OID 22102)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3509 (class 1259 OID 22103)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3510 (class 1259 OID 22104)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3433 (class 1259 OID 22005)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3430 (class 1259 OID 22006)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3379 (class 1259 OID 22008)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3361 (class 1259 OID 22007)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3287 (class 1259 OID 22009)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3288 (class 1259 OID 22010)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3420 (class 1259 OID 22275)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- TOC entry 3352 (class 1259 OID 22011)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3296 (class 1259 OID 22014)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3442 (class 1259 OID 22194)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3441 (class 1259 OID 22015)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3299 (class 1259 OID 22016)
-- Name: idx_realm_def_roles_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_roles_realm ON public.realm_default_roles USING btree (realm_id);


--
-- TOC entry 3304 (class 1259 OID 22018)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3373 (class 1259 OID 22017)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3291 (class 1259 OID 22013)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3368 (class 1259 OID 22019)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3311 (class 1259 OID 22020)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3415 (class 1259 OID 22021)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3478 (class 1259 OID 22022)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3475 (class 1259 OID 22023)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3468 (class 1259 OID 22042)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3458 (class 1259 OID 22043)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3463 (class 1259 OID 22044)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3548 (class 1259 OID 22270)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3451 (class 1259 OID 22197)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3314 (class 1259 OID 22027)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3481 (class 1259 OID 22028)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3376 (class 1259 OID 22280)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3423 (class 1259 OID 21708)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3535 (class 1259 OID 22203)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3319 (class 1259 OID 21715)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3384 (class 1259 OID 21712)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3280 (class 1259 OID 21716)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3322 (class 1259 OID 21709)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3436 (class 1259 OID 21711)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3334 (class 1259 OID 21717)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3337 (class 1259 OID 21710)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3405 (class 1259 OID 22030)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3406 (class 1259 OID 22031)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3331 (class 1259 OID 22032)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3342 (class 1259 OID 22033)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3598 (class 2606 OID 21434)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3582 (class 2606 OID 21195)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3575 (class 2606 OID 21119)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3581 (class 2606 OID 21205)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3577 (class 2606 OID 21354)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3576 (class 2606 OID 21124)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3585 (class 2606 OID 21235)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- TOC entry 3553 (class 2606 OID 20937)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3566 (class 2606 OID 20942)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3571 (class 2606 OID 20947)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3590 (class 2606 OID 21332)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3564 (class 2606 OID 20957)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3636 (class 2606 OID 22237)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3569 (class 2606 OID 20962)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3572 (class 2606 OID 20972)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3557 (class 2606 OID 20977)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3565 (class 2606 OID 20982)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3549 (class 2606 OID 20992)
-- Name: client_default_roles fk_8aelwnibji49avxsrtuf6xjow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_8aelwnibji49avxsrtuf6xjow FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3560 (class 2606 OID 20997)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3554 (class 2606 OID 21002)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3594 (class 2606 OID 21454)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3593 (class 2606 OID 21449)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3592 (class 2606 OID 21444)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3591 (class 2606 OID 21439)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3552 (class 2606 OID 21007)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- TOC entry 3573 (class 2606 OID 21012)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3627 (class 2606 OID 22153)
-- Name: client_scope_client fk_c_cli_scope_client; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_client FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3628 (class 2606 OID 22158)
-- Name: client_scope_client fk_c_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT fk_c_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3609 (class 2606 OID 22142)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3611 (class 2606 OID 22137)
-- Name: client_scope_role_mapping fk_cl_scope_rm_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3610 (class 2606 OID 22132)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3599 (class 2606 OID 21526)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3579 (class 2606 OID 22127)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3626 (class 2606 OID 21985)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3624 (class 2606 OID 21929)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3625 (class 2606 OID 21924)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3607 (class 2606 OID 21621)
-- Name: realm_default_groups fk_def_groups_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3606 (class 2606 OID 21616)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3561 (class 2606 OID 21022)
-- Name: realm_default_roles fk_evudb1ppw84oxfax2drs03icc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_evudb1ppw84oxfax2drs03icc FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3597 (class 2606 OID 21469)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3596 (class 2606 OID 21464)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3595 (class 2606 OID 21459)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3623 (class 2606 OID 21841)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3621 (class 2606 OID 21826)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3632 (class 2606 OID 22209)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3612 (class 2606 OID 22052)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3633 (class 2606 OID 22214)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3634 (class 2606 OID 22219)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3622 (class 2606 OID 21836)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3620 (class 2606 OID 21821)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3635 (class 2606 OID 22242)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3614 (class 2606 OID 22047)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3616 (class 2606 OID 21791)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3618 (class 2606 OID 21806)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3619 (class 2606 OID 21811)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3617 (class 2606 OID 21796)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3613 (class 2606 OID 22057)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3555 (class 2606 OID 21027)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3631 (class 2606 OID 22184)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3589 (class 2606 OID 21317)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3604 (class 2606 OID 21590)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3601 (class 2606 OID 21583)
-- Name: keycloak_group fk_group_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT fk_group_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3602 (class 2606 OID 21604)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3603 (class 2606 OID 21609)
-- Name: group_role_mapping fk_group_role_role; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_role FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3562 (class 2606 OID 21032)
-- Name: realm_default_roles fk_h4wpd7w4hsoolni3h0sw7btje; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_roles
    ADD CONSTRAINT fk_h4wpd7w4hsoolni3h0sw7btje FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3586 (class 2606 OID 21261)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3563 (class 2606 OID 21037)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3587 (class 2606 OID 21307)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3588 (class 2606 OID 21483)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3558 (class 2606 OID 21359)
-- Name: keycloak_role fk_kjho5le2c0ral09fl8cm9wfw9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_kjho5le2c0ral09fl8cm9wfw9 FOREIGN KEY (client) REFERENCES public.client(id);


--
-- TOC entry 3574 (class 2606 OID 21047)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3550 (class 2606 OID 22079)
-- Name: client_default_roles fk_nuilts7klwqw2h8m2b5joytky; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_default_roles
    ADD CONSTRAINT fk_nuilts7klwqw2h8m2b5joytky FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3567 (class 2606 OID 21057)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3568 (class 2606 OID 21062)
-- Name: scope_mapping fk_p3rh9grku11kqfrs4fltt7rnq; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_p3rh9grku11kqfrs4fltt7rnq FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3551 (class 2606 OID 21067)
-- Name: client fk_p56ctinxxb9gsk57fo49f9tac; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT fk_p56ctinxxb9gsk57fo49f9tac FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3578 (class 2606 OID 21200)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3556 (class 2606 OID 21072)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3580 (class 2606 OID 21476)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3629 (class 2606 OID 22169)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3630 (class 2606 OID 22174)
-- Name: default_client_scope fk_r_def_cli_scope_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3608 (class 2606 OID 22122)
-- Name: client_scope fk_realm_cli_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT fk_realm_cli_scope FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3600 (class 2606 OID 21521)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3637 (class 2606 OID 22250)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3638 (class 2606 OID 22265)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3584 (class 2606 OID 21230)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3570 (class 2606 OID 21092)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3559 (class 2606 OID 21339)
-- Name: realm fk_traf444kk6qrkms7n56aiwq5y; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT fk_traf444kk6qrkms7n56aiwq5y FOREIGN KEY (master_admin_client) REFERENCES public.client(id);


--
-- TOC entry 3605 (class 2606 OID 21597)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3615 (class 2606 OID 21781)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3583 (class 2606 OID 21210)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2020-03-06 17:17:36 CET

--
-- PostgreSQL database dump complete
--

