#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export YGLU_ENABLE_ENV=1  

SERVER=platform-api.pr-apic-mgr.nsb.local 
ADMIN_ORG=admin

export OWNER_URL=$(apic users:create -s $SERVER -o $ADMIN_ORG --user-registry api-manager-lur owner-user.yaml --format json | jq -r '.url')

yglu organization.yaml > /tmp/organization.yaml

apic orgs:create -s $SERVER /tmp/organization.yaml
