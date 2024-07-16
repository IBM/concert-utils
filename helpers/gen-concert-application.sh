#!/bin/bash

source helper_static.variables

# generate build file
#

export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
export CONCERT_APP_URN=${CONCERT_URN_PREFIX}:${APP_NAME}

outfile_name="${APP_NAME}-app-definition.json"
  ###
  # upload build file
  ###
echo "generation application json ${OUTPUTDIR}/${outfile_name} "
envsubst < ${TEMPLATE_PATH}/template-app-definition.json > ${OUTPUTDIR}/${outfile_name} 