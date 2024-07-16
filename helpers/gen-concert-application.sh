#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

# generate build file
#

export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
export CONCERT_APP_URN=${CONCERT_URN_PREFIX}:${APP_NAME}

outfile_name="${APP_NAME}-app-definition.json"
  ###
  # upload build file
  ###
echo "generation application json ${OUTPUTDIR}/${outfile_name} "
envsubst < ${SCRIPT_DIR}/${TEMPLATE_PATH}/template-app-definition.json > ${OUTPUTDIR}/${outfile_name} 