# Concert-Toolkit Utils Guide

[TOC]

## Concert-Utils Overview

Concert-Utils is a set of utilities to simplify the usage of the cocnert toolkit docker image and integrate it to any automation engine that can run container images.    

## Installation

You can clone or fork the concert-util github project.    The utilities provided here can be used from any automation infrastrcutre. 

## Utilities in Concert-Utils

### Create cocnert application sbom
```
./concert-utils/helpers/gen-concert-application.sh --outputdir ${OUTPUTDIR} --configfile ${CONCERT_DEF_CONFIG_FILE}
```

### Create cocnert build sbom
```
./concert-utils/helpers/gen-build-inventory.sh --outputdir ${OUTPUTDIR} --configfile ${CONCERT_DEF_CONFIG_FILE}
```

### Create cocnert deploy sbom
```
./concert-utils/helpers/gen-deploy-inventory.sh --outputdir ${OUTPUTDIR} --configfile ${CONCERT_DEF_CONFIG_FILE}
```

### Create cyclongdx sbom
```
./concert-utils/helpers/code-scan-stage-gen-cyclondx-sbom.sh --outputfile "${REPO_NAME}-cyclonedx-sbom-${BUILD_NUMBER}.json"
```

### Uploade data to concert
```
./concert-utils/helpers/concert_upload_data.sh --outputdir ${OUTPUTDIR}
```

## Using the utilities



## Scenarios and Samples



