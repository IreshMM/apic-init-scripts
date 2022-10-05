#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export YGLU_ENABLE_ENV=1  

SERVER=platform-api.pr-apic-mgr.nsb.local 
ADMIN_ORG=admin

NAME=$(yq -r '.username' owner-user.yaml)
ORG_NAME=$(yq -r '.name' organization.yaml)


apic orgs:delete -s $SERVER $ORG_NAME
apic users:delete -s $SERVER -o $ADMIN_ORG --user-registry api-manager-lur $NAME
