#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../global-params.sh
source ${SCRIPT_ROOT}/../role-params.sh

export YGLU_ENABLE_ENV=1  

CATALOG_OBJ=${SCRIPT_ROOT}/objects/catalog.yaml
GATEWAY_OBJ=${SCRIPT_ROOT}/../../role_admin/01_subsystems/objects/gateway-service.yaml
PORTAL_OBJ=${SCRIPT_ROOT}/../../role_admin/01_subsystems/objects/portal-service.yaml

CATALOG_NAME=$(yq -r '.name' ${CATALOG_OBJ})
GATEWAY_NAME=$(yq -r '.name' ${GATEWAY_OBJ})
PORTAL_NAME=$(yq -r '.name' ${PORTAL_OBJ})


export CONFIGURED_GATEWAY_SERVICE_URL=$(apic gateway-services:get -s $SERVER -o $P_ORG_NAME --availability-zone availability-zone-default --scope org $GATEWAY_NAME --format json --output - | jq -r '.url')
export PORTAL_SERVICE_URL=$(apic portal-services:get -s $SERVER -o $P_ORG_NAME --availability-zone availability-zone-default --scope org $PORTAL_NAME --format json --output - | jq -r '.url')
PORTAL_ENDPOINT_URL=$(apic portal-services:get -s $SERVER -o $P_ORG_NAME --availability-zone availability-zone-default --scope org $PORTAL_NAME --format json --output - | jq -r '.endpoint')

apic catalogs:create -s $SERVER -o $P_ORG_NAME $CATALOG_OBJ

CONFIGURED_GATEWAY_OBJ=${SCRIPT_ROOT}/objects/configured-gateway-service.yaml
yglu $CONFIGURED_GATEWAY_OBJ > /tmp/configured-gateway-service.yaml 
CONFIGURED_GATEWAY_OBJ=/tmp/configured-gateway-service.yaml 

apic configured-gateway-services:create --scope catalog -s $SERVER -o $P_ORG_NAME -c $CATALOG_NAME $CONFIGURED_GATEWAY_OBJ

CATALOG_SETTING_OBJ=${SCRIPT_ROOT}/objects/catalog-setting.yaml
export CATALOG_ENDPOINT="${PORTAL_ENDPOINT_URL}/${P_ORG_NAME}/${NAME}"
yglu $CATALOG_SETTING_OBJ > /tmp/catalog-setting.yaml
CATALOG_SETTING_OBJ=/tmp/catalog-setting.yaml

apic catalog-settings:update -s $SERVER -o $P_ORG_NAME -c $CATALOG_NAME $CATALOG_SETTING_OBJ

