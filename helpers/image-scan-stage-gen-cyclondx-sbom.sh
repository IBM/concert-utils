#!/bin/bash

scriptdir=`dirname $0`
cd ${scriptdir}
scriptdir=`pwd`


sourcecodedir=$(builtin cd $scriptdir/..; pwd)

SCAN_COMMAND="image-scan --images ${IMAGE_NAME}:${IMAGE_TAG}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/concert-sample-src -v ${OUTPURDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${SCAN_COMMAND}"