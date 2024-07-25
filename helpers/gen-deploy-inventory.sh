#!/bin/bash
### WORK IN PROGESS

usage() {
    echo "Usage: $(basename $0) --file_name <output file name>"
    exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --file_name)
            OUTPUT_FILENAME="$2"
            [ -z "$FILES" ] && { echo "Error: --files <sbom-json-files-comma-separated> is required."; usage; }
            shift 2
            ;;
        --help)
            usage
            ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

# generate deploy file
#
export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
export IMAGE_PURL=$IMAGE_NAME:$IMAGE_TAG
export IMAGE_URI="${IMAGE_PURL}@${IMAGE_DIGEST}"

config_outfile_name="${COMPONENT_NAME}-deploy-inventory-${BUILD_NUMBER}.json"

#echo "generating build inventory config ${OUTPUTDIR}/${outfile_name} "
CONCERT_DEF_CONFIG_FILE=deploy-${COMPONENT_NAME}-${BUILD_NUMBER}-config.yaml
envsubst < ${SCRIPT_DIR}/${TEMPLATE_PATH}/deploy-sbom-values.yaml.template > ${OUTPUTDIR}/${CONCERT_DEF_CONFIG_FILE}

TOOLKIT_COMMAND="deploy-sbom --deploy-config /toolkit-data/${CONCERT_DEF_CONFIG_FILE}"
docker run -it --rm -u $(id -u):$(id -g) -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${TOOLKIT_COMMAND}"

