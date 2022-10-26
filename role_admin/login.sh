#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../global-params.sh
source ${SCRIPT_ROOT}/role-params.sh

apic login -s $SERVER -u $ADMIN_ORG -u $ADMIN_USER -p $ADMIN_PASS -r admin/default-idp-1
