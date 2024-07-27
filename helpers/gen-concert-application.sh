#!/bin/bash


usage() {
    echo "Usage: $(basename $0) --outputdir <outputdirectory for generated files> --configfile <application-config-file>"
    echo "Example: $(basename $0) --outputdir <outputdirectory for generated files> --configfile application-config.yaml"
    exit 1
}

if [ "$#" -eq 0 ]; then
    usage
fi

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --configfile)
            configfile="$2"
            [ -z "$configfile" ] && { echo "Error:  --configfile <application-config-file> is required."; usage; }
            shift 2
            ;;
        --outputdir)
            outputdir="$2"
            [ -z "$outputdir" ] && { echo "Error: --outputdir <outputdirectory for generated files>  is required."; usage; }
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

###
# upload build file
###

TOOLKIT_COMMAND="app-sbom --app-config /toolkit-data/${configfile}"
echo "docker run -it --rm -u $(id -u):$(id -g) -v ${outputdir}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c ${TOOLKIT_COMMAND}"
docker run -it --rm -u $(id -u):$(id -g) -v ${outputdir}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${TOOLKIT_COMMAND}"
