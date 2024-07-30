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

if which docker >/dev/null; then
    dockerexe=docker 
elif which podman >/dev/null; then
    dockerexe=podman
else
    echo "docker or podman are not installed need a container runtime environment"
    exit -1
fi

TOOLKIT_COMMAND="build-sbom --build-config /toolkit-data/${configfile}"
${dockerexe} run -it --rm -u $(id -u):$(id -g) -v ${outputdir}:/toolkit-data ${CONCERT_TOOLKIT_IMAGE} bash -c "${TOOLKIT_COMMAND}"

