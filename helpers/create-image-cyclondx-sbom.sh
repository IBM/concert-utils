#!/bin/bash

if which docker >/dev/null; then
    dockerexe = docker 
elifwhich podman >/dev/null; then
    dockerexe podman
else
    echo "docker or podman are not installed need a container runtime environment"
    exit -1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

SCAN_COMMAND="image-scan --images ${IMAGE_NAME}:${IMAGE_TAG}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/concert-sample-src -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${SCAN_COMMAND}"