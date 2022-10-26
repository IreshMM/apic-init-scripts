#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../global-params.sh
source ${SCRIPT_ROOT}/../role-params.sh

export YGLU_ENABLE_ENV=1  

yq -y '.mail_server_url=null' ${SCRIPT_ROOT}/objects/cloud-setting.yaml  > /tmp/cloud-setting.yaml
apic cloud-settings:update -s $SERVER /tmp/cloud-setting.yaml

NAME=$(yq -r '.name' ${SCRIPT_ROOT}/objects/mail-server.yaml)
apic mail-servers:delete -s $SERVER -o $ADMIN_ORG $NAME

