#!/bin/bash

SCRIPT_ROOT="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
export YGLU_ENABLE_ENV=1  

SERVER=platform-api.pr-apic-mgr.nsb.local 
ORG=$(yq -r '.name' ../02_provider_org/organization.yaml)

NAME=$(yq -r '.name' catalog.yaml)

apic catalogs:delete -s $SERVER -o $ORG $NAME
