#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../../global-params.sh
source ${SCRIPT_ROOT}/../../role-params.sh

PORTAL_OBJ=${SCRIPT_ROOT}/../objects/portal-service.yaml
NAME=$(yq -r '.name' ${PORTAL_OBJ})

apic portal-services:delete -s $SERVER -o $ADMIN_ORG --availability-zone availability-zone-default $NAME
