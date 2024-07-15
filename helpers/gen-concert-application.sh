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

outfile_name="${APP_NAME}-app-definition.json"
  ###
  # upload build file
  ###
echo "generation application json ${DATA_OUT_PATH}/${outfile_name} "
envsubst < ${TEMPLATE_PATH}/template-app-definition.json > ${DATA_OUT_PATH}/${outfile_name} 