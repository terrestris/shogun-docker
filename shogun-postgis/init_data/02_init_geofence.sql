CREATE DATABASE geofence;

\c geofence

CREATE EXTENSION postgis;

CREATE TABLE public.gf_adminrule (
  id bigint NOT NULL,
  grant_type character varying(255) NOT NULL,
  ip_high bigint,
  ip_low bigint,
  ip_size integer,
  priority bigint NOT NULL,
  rolename character varying(255),
  username character varying(255),
  workspace character varying(255),
  instance_id bigint
);

CREATE TABLE public.gf_gfuser (
  id bigint NOT NULL,
  datecreation timestamp without time zone,
  emailaddress character varying(255),
  enabled boolean NOT NULL,
  extid character varying(255),
  fullname character varying(255),
  name character varying(255) NOT NULL,
  password character varying(255)
);

CREATE TABLE public.gf_gsinstance (
  id bigint NOT NULL,
  baseurl character varying(255) NOT NULL,
  datecreation timestamp without time zone,
  description character varying(255),
  name character varying(255) NOT NULL,
  password character varying(255) NOT NULL,
  username character varying(255) NOT NULL
);

CREATE TABLE public.gf_gsuser (
  id bigint NOT NULL,
  admin boolean NOT NULL,
  datecreation timestamp without time zone,
  emailaddress character varying(255),
  enabled boolean NOT NULL,
  extid character varying(255),
  fullname character varying(255),
  name character varying(255) NOT NULL,
  password character varying(255)
);

CREATE TABLE public.gf_layer_attributes (
  details_id bigint NOT NULL,
  access_type character varying(255),
  data_type character varying(255),
  name character varying(255) NOT NULL
);

CREATE TABLE public.gf_layer_details (
  id bigint NOT NULL,
  area public.geometry,
  catalog_mode character varying(255),
  cqlfilterread character varying(4000),
  cqlfilterwrite character varying(4000),
  defaultstyle character varying(255),
  spatial_filter_type character varying(255),
  type character varying(255),
  rule_id bigint NOT NULL
);

CREATE TABLE public.gf_layer_styles (
  details_id bigint NOT NULL,
  stylename character varying(255)
);

CREATE TABLE public.gf_rule (
  id bigint NOT NULL,
  grant_type character varying(255) NOT NULL,
  ip_high bigint,
  ip_low bigint,
  ip_size integer,
  layer character varying(255),
  priority bigint NOT NULL,
  request character varying(255),
  rolename character varying(255),
  service character varying(255),
  subfield character varying(255),
  username character varying(255),
  workspace character varying(255),
  instance_id bigint
);

CREATE TABLE public.gf_rule_limits (
  id bigint NOT NULL,
  area public.geometry,
  catalog_mode character varying(255),
  spatial_filter_type character varying(255),
  rule_id bigint NOT NULL
);

CREATE TABLE public.gf_user_usergroups (
  user_id bigint NOT NULL,
  group_id bigint NOT NULL
);

CREATE TABLE public.gf_usergroup (
  id bigint NOT NULL,
  datecreation timestamp without time zone,
  enabled boolean NOT NULL,
  extid character varying(255),
  name character varying(255) NOT NULL
);

CREATE SEQUENCE public.hibernate_sequence
  START WITH 1
  INCREMENT BY 1
  NO MINVALUE
  NO MAXVALUE
  CACHE 1;

COPY public.gf_adminrule (id, grant_type, ip_high, ip_low, ip_size, priority, rolename, username, workspace, instance_id) FROM stdin;
\.

COPY public.gf_gfuser (id, datecreation, emailaddress, enabled, extid, fullname, name, password) FROM stdin;
\.

COPY public.gf_gsinstance (id, baseurl, datecreation, description, name, password, username) FROM stdin;
\.

COPY public.gf_gsuser (id, admin, datecreation, emailaddress, enabled, extid, fullname, name, password) FROM stdin;
\.

COPY public.gf_layer_attributes (details_id, access_type, data_type, name) FROM stdin;
\.

COPY public.gf_layer_details (id, area, catalog_mode, cqlfilterread, cqlfilterwrite, defaultstyle, spatial_filter_type, type, rule_id) FROM stdin;
\.

COPY public.gf_layer_styles (details_id, stylename) FROM stdin;
\.

COPY public.gf_rule (id, grant_type, ip_high, ip_low, ip_size, layer, priority, request, rolename, service, subfield, username, workspace, instance_id) FROM stdin;
2	DENY	\N	\N	\N	\N	1	\N	ROLE_ANONYMOUS	\N	\N	\N	\N	\N
1	ALLOW	\N	\N	\N	\N	0	\N	ROLE_AUTHENTICATED	\N	\N	\N	\N	\N
\.

COPY public.gf_rule_limits (id, area, catalog_mode, spatial_filter_type, rule_id) FROM stdin;
\.

COPY public.gf_user_usergroups (user_id, group_id) FROM stdin;
\.

COPY public.gf_usergroup (id, datecreation, enabled, extid, name) FROM stdin;
\.

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.

SELECT pg_catalog.setval('public.hibernate_sequence', 2, true);

ALTER TABLE ONLY public.gf_adminrule
  ADD CONSTRAINT gf_adminrule_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.gf_adminrule
  ADD CONSTRAINT gf_adminrule_username_rolename_instance_id_workspace_key UNIQUE (username, rolename, instance_id, workspace);

ALTER TABLE ONLY public.gf_gfuser
  ADD CONSTRAINT gf_gfuser_extid_key UNIQUE (extid);

ALTER TABLE ONLY public.gf_gfuser
  ADD CONSTRAINT gf_gfuser_name_key UNIQUE (name);

ALTER TABLE ONLY public.gf_gfuser
  ADD CONSTRAINT gf_gfuser_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.gf_gsinstance
  ADD CONSTRAINT gf_gsinstance_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.gf_gsuser
  ADD CONSTRAINT gf_gsuser_extid_key UNIQUE (extid);

ALTER TABLE ONLY public.gf_gsuser
  ADD CONSTRAINT gf_gsuser_name_key UNIQUE (name);

ALTER TABLE ONLY public.gf_gsuser
  ADD CONSTRAINT gf_gsuser_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.gf_layer_attributes
  ADD CONSTRAINT gf_layer_attributes_pkey PRIMARY KEY (details_id, name);

ALTER TABLE ONLY public.gf_layer_details
  ADD CONSTRAINT gf_layer_details_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.gf_layer_details
  ADD CONSTRAINT gf_layer_details_rule_id_key UNIQUE (rule_id);

ALTER TABLE ONLY public.gf_rule_limits
  ADD CONSTRAINT gf_rule_limits_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.gf_rule_limits
  ADD CONSTRAINT gf_rule_limits_rule_id_key UNIQUE (rule_id);

ALTER TABLE ONLY public.gf_rule
  ADD CONSTRAINT gf_rule_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.gf_rule
  ADD CONSTRAINT gf_rule_username_rolename_instance_id_service_request_works_key UNIQUE (username, rolename, instance_id, service, request, workspace, layer);

ALTER TABLE ONLY public.gf_user_usergroups
  ADD CONSTRAINT gf_user_usergroups_pkey PRIMARY KEY (user_id, group_id);

ALTER TABLE ONLY public.gf_usergroup
  ADD CONSTRAINT gf_usergroup_extid_key UNIQUE (extid);

ALTER TABLE ONLY public.gf_usergroup
  ADD CONSTRAINT gf_usergroup_name_key UNIQUE (name);

ALTER TABLE ONLY public.gf_usergroup
  ADD CONSTRAINT gf_usergroup_pkey PRIMARY KEY (id);

CREATE INDEX idx_adminrule_priority ON public.gf_adminrule USING btree (priority);

CREATE INDEX idx_adminrule_workspace ON public.gf_adminrule USING btree (workspace);

CREATE INDEX idx_gsuser_name ON public.gf_gsuser USING btree (name);

CREATE INDEX idx_rule_layer ON public.gf_rule USING btree (layer);

CREATE INDEX idx_rule_priority ON public.gf_rule USING btree (priority);

CREATE INDEX idx_rule_request ON public.gf_rule USING btree (request);

CREATE INDEX idx_rule_service ON public.gf_rule USING btree (service);

CREATE INDEX idx_rule_workspace ON public.gf_rule USING btree (workspace);

ALTER TABLE ONLY public.gf_adminrule
  ADD CONSTRAINT fk_adminrule_instance FOREIGN KEY (instance_id) REFERENCES public.gf_gsinstance(id);

ALTER TABLE ONLY public.gf_layer_attributes
  ADD CONSTRAINT fk_attribute_layer FOREIGN KEY (details_id) REFERENCES public.gf_layer_details(id);

ALTER TABLE ONLY public.gf_layer_details
  ADD CONSTRAINT fk_details_rule FOREIGN KEY (rule_id) REFERENCES public.gf_rule(id);

ALTER TABLE ONLY public.gf_rule_limits
  ADD CONSTRAINT fk_limits_rule FOREIGN KEY (rule_id) REFERENCES public.gf_rule(id);

ALTER TABLE ONLY public.gf_rule
  ADD CONSTRAINT fk_rule_instance FOREIGN KEY (instance_id) REFERENCES public.gf_gsinstance(id);

ALTER TABLE ONLY public.gf_layer_styles
  ADD CONSTRAINT fk_styles_layer FOREIGN KEY (details_id) REFERENCES public.gf_layer_details(id);

ALTER TABLE ONLY public.gf_user_usergroups
  ADD CONSTRAINT fk_uug_group FOREIGN KEY (group_id) REFERENCES public.gf_usergroup(id);

ALTER TABLE ONLY public.gf_user_usergroups
  ADD CONSTRAINT fk_uug_user FOREIGN KEY (user_id) REFERENCES public.gf_gsuser(id);
