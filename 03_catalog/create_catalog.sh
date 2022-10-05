#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export YGLU_ENABLE_ENV=1  

SERVER=platform-api.pr-apic-mgr.nsb.local 
ORG=$(yq -r '.name' ../02_provider_org/organization.yaml)

NAME=$(yq -r '.name' catalog.yaml)

export CONFIGURED_GATEWAY_SERVICE_URL=$(apic gateway-services:get -s $SERVER -o $ORG --availability-zone availability-zone-default --scope org api-gateway-service --format json --output - | jq -r '.url')
export PORTAL_SERVICE_URL=$(apic portal-services:get -s $SERVER -o $ORG --availability-zone availability-zone-default --scope org portal-service --format json --output - | jq -r '.url')
PORTAL_ENDPOINT_URL=$(apic portal-services:get -s $SERVER -o $ORG --availability-zone availability-zone-default --scope org portal-service --format json --output - | jq -r '.endpoint')

apic catalogs:create -s $SERVER -o $ORG catalog.yaml

yglu configured-gateway-service.yaml > /tmp/configured-gateway-service.yaml 

apic configured-gateway-services:create --scope catalog -s $SERVER -o $ORG -c $NAME /tmp/configured-gateway-service.yaml

export CATALOG_ENDPOINT="${PORTAL_ENDPOINT_URL}/${ORG}/${NAME}"
yglu catalog-setting.yaml > /tmp/catalog-setting.yaml

apic catalog-settings:update -s $SERVER -o $ORG -c $NAME /tmp/catalog-setting.yaml
