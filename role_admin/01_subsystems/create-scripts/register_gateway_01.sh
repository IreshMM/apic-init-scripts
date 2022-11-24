#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../../global-params.sh
source ${SCRIPT_ROOT}/../../role-params.sh

export YGLU_ENABLE_ENV=1  

export DEFAULT_TLS_CLIENT_PROFILE_URL=$(apic tls-client-profiles:list-all -s $SERVER -o $ADMIN_ORG --format json | jq -r '.results[] | select(.name=="tls-client-profile-default") | .url')
export DEFAULT_TLS_SERVER_PROFILE_URL=$(apic tls-server-profiles:list-all -s $SERVER -o $ADMIN_ORG --format json | jq -r '.results[] | select(.name=="tls-server-profile-default") | .url')
export GATEWAY_SERVICE_INTEGRATION_URL=$(apic integrations:list -s $SERVER --subcollection gateway-service --format json | jq -r '.results[] | select(.name=="datapower-api-gateway") | .url')
export ANALYTICS_URL=$(yq -r '.url' /tmp/analytics-current.json)

GATEWAY_OBJ=${SCRIPT_ROOT}/../objects/gateway-service.yaml
yglu $GATEWAY_OBJ > /tmp/gateway-service.yaml
GATEWAY_OBJ=/tmp/gateway-service.yaml

export GATEWAY_SERVICE_URL=$(apic gateway-services:create -s $SERVER -o $ADMIN_ORG --availability-zone availability-zone-default --format json $GATEWAY_OBJ | jq -r '.url')

CLOUD_SETTING_OBJ=${SCRIPT_ROOT}/../objects/cloud-setting.yaml
yglu $CLOUD_SETTING_OBJ > /tmp/cloud-setting.yaml
apic cloud-settings:update -s $SERVER /tmp/cloud-setting.yaml
