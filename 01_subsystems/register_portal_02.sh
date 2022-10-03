#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export YGLU_ENABLE_ENV=1  

SERVER=platform-api.pr-apic-mgr.nsb.local 
ADMIN_ORG=admin

apic portal-services:create -s $SERVER -o $ADMIN_ORG --availability-zone availability-zone-default portal-service.yaml
