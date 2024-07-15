#!/bin/bash

scriptdir=`dirname $0`

scriptdir=`pwd`
sourcecodedir=$(builtin cd $scriptdir/..; pwd)

VARIABLES_FILE=${sourcecodedir}/concert_data/demo_build_envs.variables

OUTPURDIR=${sourcecodedir}/concert_data
SRC_PATH=${sourcecodedir}/src

source ${VARIABLES_FILE}

OUTPUT_FILENAME="$REPO_NAME-$BUILD_NUMBER-cyclonedx-sbom.json"
sourcecodedir=$(builtin cd $scriptdir/../..; pwd)


CODE_SCAN_COMMAND="code-scan --src /concert-sample --output-file ${OUTPUT_FILENAME}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/concert-sample -v ${OUTPURDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${CODE_SCAN_COMMAND}"
