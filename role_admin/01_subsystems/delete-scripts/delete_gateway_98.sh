#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
source ${SCRIPT_ROOT}/../../../global-params.sh
source ${SCRIPT_ROOT}/../../role-params.sh

export YGLU_ENABLE_ENV=1  

GATEWAY_OBJ=${SCRIPT_ROOT}/../objects/gateway-service.yaml
NAME=$(yq -r '.name' ${GATEWAY_OBJ})


CLOUD_SETTING_OBJ=${SCRIPT_ROOT}/../objects/cloud-setting.yaml
yq -y '.gateway_service_default_urls=[]' $CLOUD_SETTING_OBJ > /tmp/cloud-setting.yaml
apic cloud-settings:update -s $SERVER /tmp/cloud-setting.yaml

apic gateway-services:delete -s $SERVER -o $ADMIN_ORG --availability-zone availability-zone-default $NAME
