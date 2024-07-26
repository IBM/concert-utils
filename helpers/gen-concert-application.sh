#!/bin/bash


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


export OUTPUT_FILENAME=$outputfile

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

export TIMESTAMP_UTC=$(date -u "+%Y-%m-%dT%H:%M:%SZ")
export CONCERT_APP_URN=${CONCERT_URN_PREFIX}:${APP_NAME}

###
# upload build file
###
echo "generation application json ${OUTPUTDIR}/${OUTPUT_FILENAME} "
envsubst < ${SCRIPT_DIR}/${TEMPLATE_PATH}/template-app-definition.json > ${OUTPUTDIR}/${OUTPUT_FILENAME} 

CONCERT_DEF_CONFIG_FILE=app-${APP_NAME}-${APP_VERSION}-config.yaml
envsubst < ${SCRIPT_DIR}/${TEMPLATE_PATH}/app-sbom-values.yaml.template > ${OUTPUTDIR}/${CONCERT_DEF_CONFIG_FILE}

TOOLKIT_COMMAND="app-sbom --app-config /toolkit-data/${CONCERT_DEF_CONFIG_FILE}"
docker run -it --rm -u $(id -u):$(id -g) -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${TOOLKIT_COMMAND}"
