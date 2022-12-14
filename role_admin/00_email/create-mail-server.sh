#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../global-params.sh
source ${SCRIPT_ROOT}/../role-params.sh

export YGLU_ENABLE_ENV=1  

export DEFAULT_TLS_CLIENT_PROFILE=$(apic tls-client-profiles:list-all -s $SERVER -o $ADMIN_ORG --format json | jq -r '.results[] | select(.name=="tls-client-profile-default") | .url')
export MAIL_SERVER_PASS=${MAIL_SERVER_PASS:-pass}

yglu ${SCRIPT_ROOT}/objects/mail-server.yaml > /tmp/mail-server.yaml

export MAIL_SERVER_URL=$(apic mail-servers:create -s $SERVER -o $ADMIN_ORG /tmp/mail-server.yaml --format json | jq -r '.url')

yglu ${SCRIPT_ROOT}/objects/cloud-setting.yaml > /tmp/cloud-setting.yaml

apic cloud-settings:update -s $SERVER /tmp/cloud-setting.yaml
