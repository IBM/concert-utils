#!/bin/bash

usage() {
    echo "Usage: $(basename $0) --outputfile <filename for the generated json>"
    echo "Example: $(basename $0) --outputfile build-inventory.json"
    exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --outputfile)
            outputfile="$2"
            [ -z "$outputfile" ] && { echo "Error: --outputfile <filename for the generated json> is required."; usage; }
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            echo "Unknown parameter passed: $1"
            usage
            ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables


export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
export IMAGE_PURL=$IMAGE_NAME:$IMAGE_TAG
export IMAGE_URI="${IMAGE_PURL}@${IMAGE_DIGEST}"

config_outfile_name="${COMPONENT_NAME}-${BUILD_NUMBER}-built-assets.json"
export OUTPUT_FILENAME=$outputfile
CONCERT_DEF_CONFIG_FILE=build-${COMPONENT_NAME}-${BUILD_NUMBER}-config.yaml
envsubst < ${SCRIPT_DIR}/${TEMPLATE_PATH}/build-sbom-values.yaml.template > ${OUTPUTDIR}/${CONCERT_DEF_CONFIG_FILE}

TOOLKIT_COMMAND="build-sbom --build-config /toolkit-data/${CONCERT_DEF_CONFIG_FILE}"
docker run -it --rm -u $(id -u):$(id -g) -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${TOOLKIT_COMMAND}"

