#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

CODE_SCAN_COMMAND="upload-concert"
docker run -it --rm -u $(id -u):$(id -g) -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${CODE_SCAN_COMMAND}"
