#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../global-params.sh
source ${SCRIPT_ROOT}/role-params.sh

apic login -s $SERVER -u $P_ORG_NAME -u $P_ORG_USER -p $P_ORG_USER_PASS -r provider/default-idp-2
