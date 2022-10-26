#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../global-params.sh
source ${SCRIPT_ROOT}/../role-params.sh

export YGLU_ENABLE_ENV=1  

OWNER_OBJ=${SCRIPT_ROOT}/objects/owner-user.yaml
export OWNER_URL=$(apic users:create -s $SERVER -o $ADMIN_ORG --user-registry api-manager-lur $OWNER_OBJ --format json | jq -r '.url')

ORGANIZATION_OBJ=${SCRIPT_ROOT}/objects/organization.yaml
yglu $ORGANIZATION_OBJ > /tmp/organization.yaml
ORGANIZATION_OBJ=/tmp/organization.yaml

apic orgs:create -s $SERVER $ORGANIZATION_OBJ
