#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export YGLU_ENABLE_ENV=1  

SERVER=platform-api.pr-apic-mgr.nsb.local 
ADMIN_ORG=admin


yq -y '.mail_server_url=null' cloud-setting.yaml  > /tmp/cloud-setting.yaml
apic cloud-settings:update -s $SERVER /tmp/cloud-setting.yaml

apic mail-servers:delete -s $SERVER -o $ADMIN_ORG primary-mail-server

