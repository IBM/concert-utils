#!/bin/bash

source helper_static.variables

CODE_SCAN_COMMAND="upload-concert"
docker run -it --rm -u $(id -u):$(id -g) -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${CODE_SCAN_COMMAND}"
