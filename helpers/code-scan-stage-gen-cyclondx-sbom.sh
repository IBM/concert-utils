#!/bin/bash

usage() {
    echo "Usage: $(basename $0) --file_name <file name for> --cdxgen-args (cdxgen parameters)"
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
        --cdxgen-args)
            CDXGEN_ARGS="$2"
            shift 2
            ;;
        --help)
            usage
            ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${SCRIPT_DIR}/constants.variables

CODE_SCAN_COMMAND="code-scan --src /concert-sample --output-file ${OUTPUT_FILENAME} ${CDXGEN_ARGS}"
docker run -it --rm -u $(id -u):$(id -g) -v ${SRC_PATH}:/concert-sample -v ${OUTPUTDIR}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${CODE_SCAN_COMMAND}"
