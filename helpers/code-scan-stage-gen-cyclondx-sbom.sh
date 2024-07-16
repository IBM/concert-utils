#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

CODE_SCAN_COMMAND="code-scan --src /concert-sample --output-file ${OUTPUT_FILENAME}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/concert-sample -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${CODE_SCAN_COMMAND}"
