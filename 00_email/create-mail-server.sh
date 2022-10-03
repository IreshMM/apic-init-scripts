#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export YGLU_ENABLE_ENV=1  

SERVER=platform-api.pr-apic-mgr.nsb.local 
ADMIN_ORG=admin


export DEFAULT_TLS_CLIENT_PROFILE=$(apic tls-client-profiles:list-all -s $SERVER -o $ADMIN_ORG --format json | jq -r '.results[] | select(.name=="tls-client-profile-default") | .url')

yglu mail-server.yaml > /tmp/mail-server.yaml

export MAIL_SERVER_URL=$(apic mail-servers:create -s $SERVER -o $ADMIN_ORG /tmp/mail-server.yaml --format json | jq -r '.url')

yglu cloud-setting.yaml > /tmp/cloud-setting.yaml

apic cloud-settings:update -s $SERVER /tmp/cloud-setting.yaml
