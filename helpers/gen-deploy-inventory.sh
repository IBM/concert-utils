#!/bin/bash
### WORK IN PROGESS


usage() {
    echo "Usage: $(basename $0) --outputfile <filename for the generated json>"
    echo "Example: $(basename $0) --outputfile deploy-inventory.json"
    exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --output_file)
            output_file="$2"
            [ -z "$output_file" ] && { echo "Error: --outputfile <filename for the generated json> is required."; usage; }
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

# generate deploy file
#
export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
export IMAGE_PURL=$IMAGE_NAME:$IMAGE_TAG
export IMAGE_URI="${IMAGE_PURL}@${IMAGE_DIGEST}"


#echo "generating build inventory config ${OUTPUTDIR}/${outfile_name} "
export OUTPUT_FILENAME=$output_file
CONCERT_DEF_CONFIG_FILE=deploy-${COMPONENT_NAME}-${BUILD_NUMBER}-config.yaml
envsubst < ${SCRIPT_DIR}/${TEMPLATE_PATH}/deploy-sbom-values.yaml.template > ${OUTPUTDIR}/${CONCERT_DEF_CONFIG_FILE}

TOOLKIT_COMMAND="deploy-sbom --deploy-config /toolkit-data/${CONCERT_DEF_CONFIG_FILE}"
docker run -it --rm -u $(id -u):$(id -g) -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${TOOLKIT_COMMAND}"

