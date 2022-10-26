#!/bin/bash
_SCRIPT_ROOT="$( dirname "${BASH_SOURCE[0]}" )"

OWNER_OBJ=${_SCRIPT_ROOT}/../role_admin/02_provider_org/objects/owner-user.yaml
ORGANIZATION_OBJ=${_SCRIPT_ROOT}/../role_admin/02_provider_org/objects/organization.yaml

NAME=$(yq -r '.username' ${OWNER_OBJ})
ORG_NAME=$(yq -r '.name' ${ORGANIZATION_OBJ})

P_ORG_NAME=$(yq -r '.name' ${ORGANIZATION_OBJ})
P_ORG_USER=$(yq -r '.username' ${OWNER_OBJ})
P_ORG_USER_PASS=$(yq -r '.password' ${OWNER_OBJ})
