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

export OUTPUT_FILENAME=$output_file 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

CODE_SCAN_COMMAND="code-scan --src /concert-sample --output-file ${OUTPUT_FILENAME} ${CDXGEN_ARGS}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/concert-sample -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${CODE_SCAN_COMMAND}"
