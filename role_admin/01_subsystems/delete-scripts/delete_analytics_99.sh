#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../../global-params.sh
source ${SCRIPT_ROOT}/../../role-params.sh

ANALYTICS_OBJ=${SCRIPT_ROOT}/../objects/analytics-service.yaml
NAME=$(yq -r '.name' $ANALYTICS_OBJ)

apic analytics-services:delete -s $SERVER -o $ADMIN_ORG --availability-zone availability-zone-default $NAME
