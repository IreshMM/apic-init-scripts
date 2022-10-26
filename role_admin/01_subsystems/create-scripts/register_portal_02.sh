#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../../global-params.sh
source ${SCRIPT_ROOT}/../../role-params.sh

export YGLU_ENABLE_ENV=1  

PORTAL_OBJ=${SCRIPT_ROOT}/../objects/portal-service.yaml

apic portal-services:create -s $SERVER -o $ADMIN_ORG --availability-zone availability-zone-default $PORTAL_OBJ
