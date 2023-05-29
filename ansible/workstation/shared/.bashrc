#!/bin/bash

# Show docker image size (without pulling it) 
# src - https://unix.stackexchange.com/a/711192
dockersize() { docker manifest inspect -v "$1" | jq -c 'if type == "array" then .[] else . end' |  jq -r '[ ( .Descriptor.platform | [ .os, .architecture, .variant, ."os.version" ] | del(..|nulls) | join("/") ), ( [ .SchemaV2Manifest.layers[].size ] | add ) ] | join(" ")' | numfmt --to iec --format '%.2f' --field 2 | sort | column -t ; }
