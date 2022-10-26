#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Admin role resources
${SCRIPT_ROOT}/role_admin/login.sh
${SCRIPT_ROOT}/role_admin/00_email/create-mail-server.sh
${SCRIPT_ROOT}/role_admin/00_email/test-connection.sh
${SCRIPT_ROOT}/role_admin/01_subsystems/create-scripts/register_analytics_00.sh
${SCRIPT_ROOT}/role_admin/01_subsystems/create-scripts/register_gateway_01.sh
${SCRIPT_ROOT}/role_admin/01_subsystems/create-scripts/register_portal_02.sh
${SCRIPT_ROOT}/role_admin/02_provider_org/create-provider-org.sh

# Provider org admin role resources
${SCRIPT_ROOT}/role_provider_org_admin/login.sh
${SCRIPT_ROOT}/role_provider_org_admin/03_catalog/create_catalog.sh
