#!/bin/bash


scriptdir=`dirname $0`

scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

TEMPLATE_PATH=./templates

  # generate build file
  #
source ${VARIABLES_FILE}

export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")

export IMAGE_PURL=$IMAGE_NAME:$IMAGE_TAG
export IMAGE_URI="${IMAGE_PURL}@${IMAGE_DIGEST}"

outfile_name="${COMPONENT_NAME}-${BUILD_NUMBER}-built-assets.json"
  ###
  # upload build file
  ###
  echo "generating build inventory json ${DATA_OUT_PATH}/${outfile_name} "

  envsubst < ${TEMPLATE_PATH}/template-build.json > ${DATA_OUT_PATH}/${outfile_name} 
