#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../global-params.sh
source ${SCRIPT_ROOT}/../role-params.sh

export YGLU_ENABLE_ENV=1  

OWNER_OBJ=${SCRIPT_ROOT}/objects/owner-user.yaml
ORGANIZATION_OBJ=${SCRIPT_ROOT}/objects/organization.yaml
NAME=$(yq -r '.username' ${OWNER_OBJ})
ORG_NAME=$(yq -r '.name' ${ORGANIZATION_OBJ})

apic orgs:delete -s $SERVER $ORG_NAME
apic users:delete -s $SERVER -o $ADMIN_ORG --user-registry api-manager-lur $NAME
