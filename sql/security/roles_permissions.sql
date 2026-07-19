-- =====================================================
-- Enterprise Retail Data Warehouse
-- File: roles_permissions.sql
-- =====================================================

SET search_path TO retailhub;

---------------------------------------------------------
-- Roles
---------------------------------------------------------

CREATE ROLE analyst;

CREATE ROLE manager;

CREATE ROLE admin;

---------------------------------------------------------
-- Analyst Permissions
---------------------------------------------------------

GRANT CONNECT ON DATABASE retailhub_dw TO analyst;

GRANT USAGE ON SCHEMA retailhub TO analyst;

GRANT SELECT ON ALL TABLES IN SCHEMA retailhub TO analyst;

---------------------------------------------------------
-- Manager Permissions
---------------------------------------------------------

GRANT CONNECT ON DATABASE retailhub_dw TO manager;

GRANT USAGE ON SCHEMA retailhub TO manager;

GRANT SELECT,INSERT,UPDATE ON ALL TABLES IN SCHEMA retailhub TO manager;

---------------------------------------------------------
-- Admin Permissions
---------------------------------------------------------

GRANT ALL PRIVILEGES

ON ALL TABLES IN SCHEMA retailhub

TO admin;