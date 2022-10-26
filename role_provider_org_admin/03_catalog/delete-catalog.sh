#!/bin/bash


SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../global-params.sh
source ${SCRIPT_ROOT}/../role-params.sh

export YGLU_ENABLE_ENV=1  

CATALOG_OBJ=${SCRIPT_ROOT}/objects/catalog.yaml
CATALOG_NAME=$(yq -r '.name' ${CATALOG_OBJ})

apic catalogs:delete -s $SERVER -o $P_ORG_NAME $CATALOG_NAME
