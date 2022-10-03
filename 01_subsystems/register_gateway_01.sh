#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export YGLU_ENABLE_ENV=1  

SERVER=platform-api.pr-apic-mgr.nsb.local 
ADMIN_ORG=admin


export DEFAULT_TLS_CLIENT_PROFILE_URL=$(apic tls-client-profiles:list-all -s $SERVER -o $ADMIN_ORG --format json | jq -r '.results[] | select(.name=="tls-client-profile-default") | .url')
export DEFAULT_TLS_SERVER_PROFILE_URL=$(apic tls-server-profiles:list-all -s $SERVER -o $ADMIN_ORG --format json | jq -r '.results[] | select(.name=="tls-server-profile-default") | .url')
export GATEWAY_SERVICE_INTEGRATION_URL=$(apic integrations:list -s $SERVER --subcollection gateway-service --format json | jq -r '.results[] | select(.name=="datapower-api-gateway") | .url')
export ANALYTICS_URL=$(yq -r '.url' analytics-current.yaml)

yglu gateway-service.yaml > /tmp/gateway-service.yaml

apic gateway-services:create -s $SERVER -o $ADMIN_ORG --availability-zone availability-zone-default /tmp/gateway-service.yaml
