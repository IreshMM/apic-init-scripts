#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../global-params.sh
source ${SCRIPT_ROOT}/../role-params.sh

export YGLU_ENABLE_ENV=1  

NAME=$(yq -r '.name' ${SCRIPT_ROOT}/objects/mail-server.yaml)
apic mail-servers:test-connection -s $SERVER -o $ADMIN_ORG $NAME ${SCRIPT_ROOT}/objects/test-connection.json
