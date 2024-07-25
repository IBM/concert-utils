#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

# generate build file
#

export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
export IMAGE_PURL=$IMAGE_NAME:$IMAGE_TAG
export IMAGE_URI="${IMAGE_PURL}@${IMAGE_DIGEST}"


config_outfile_name="${COMPONENT_NAME}-${BUILD_NUMBER}-built-assets.json"

#echo "generating build inventory config ${OUTPUTDIR}/${outfile_name} "
CONCERT_DEF_CONFIG_FILE=buil-${COMPONENT_NAME}-${BUILD_NUMBER}-config.yaml
envsubst < ${SCRIPT_DIR}/${TEMPLATE_PATH}/build-sbom-values.yaml.template > ${OUTPUTDIR}/${CONCERT_DEF_CONFIG_FILE}

TOOLKIT_COMMAND="build-sbom --build-config /toolkit-data/${CONCERT_DEF_CONFIG_FILE}"
docker run -it --rm -u $(id -u):$(id -g) -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${TOOLKIT_COMMAND}"

