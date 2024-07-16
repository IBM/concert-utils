#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

  # generate build file
  #

export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
export IMAGE_PURL=$IMAGE_NAME:$IMAGE_TAG
export IMAGE_URI="${IMAGE_PURL}@${IMAGE_DIGEST}"
export CONCERT_APP_URN=${CONCERT_URN_PREFIX}:${APP_NAME}

outfile_name="${COMPONENT_NAME}-${BUILD_NUMBER}-built-assets.json"
  ###
  # upload build file
  ###
  echo "generating build inventory json ${OUTPUTDIR}/${outfile_name} "

  envsubst < ${TEMPLATE_PATH}/template-build.json > ${OUTPUTDIR}/${outfile_name} 
