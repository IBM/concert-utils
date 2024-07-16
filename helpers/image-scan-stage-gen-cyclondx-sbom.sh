#!/bin/bash

source constants.variables

SCAN_COMMAND="image-scan --images ${IMAGE_NAME}:${IMAGE_TAG}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/concert-sample-src -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${SCAN_COMMAND}"