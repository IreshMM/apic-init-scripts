#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

# Provider org admin role resources
${SCRIPT_ROOT}/role_provider_org_admin/login.sh
${SCRIPT_ROOT}/role_provider_org_admin/03_catalog/delete-catalog.sh

# Admin role resources
${SCRIPT_ROOT}/role_admin/login.sh
${SCRIPT_ROOT}/role_admin/02_provider_org/delete-provider-org.sh
${SCRIPT_ROOT}/role_admin/01_subsystems/delete-scripts/delete_portal_97.sh
${SCRIPT_ROOT}/role_admin/01_subsystems/delete-scripts/delete_gateway_98.sh
${SCRIPT_ROOT}/role_admin/01_subsystems/delete-scripts/delete_analytics_99.sh
${SCRIPT_ROOT}/role_admin/00_email/delete-mail-server.sh
