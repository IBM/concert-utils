# Concert-Toolkit Utils Guide

[TOC]

## Concert-Utils Overview

Concert-Utils is a set of utilities to simplify the usage of the cocnert toolkit docker image and integrate it to any automation engine that can run container images.    

## Installation

You can clone or fork the concert-util github project.    The utilities provided here can be used from any automation infrastrcutre. 

## Utilities in Concert-Utils



## Using the utilities

The utilities are a set of helpers scripts that help generate and send specific data to Concert.   In order to use the utilities a set of Environment Variables are required and this are used depending on use cases.  THis environment variables can be echoed or provided in a file that can be reuse across multiple scripts.  

List of Variables use for utilities:

export CONCERT_TOOLKIT_IMAGE=cp.icr.io/cp/roja/ibm-concert-toolkit:latest

Input/Output mounts for toolkit commands

####
OUTPUTDIR=

####

cyclonddx generation utility for source code

####
SRC_PATH=

######

Common Variables

###

export APP_NAME=
export APP_VERSION=

export COMPONENT_NAME=

export ENVIRONMANET_NAME_1=development
export ENVIRONMANET_NAME_2=pre-production
export ENVIRONMANET_NAME_3=production

###

inventory specific vaiable 

###
export REPO_NAME=
export REPO_URL=
export BUILD_NUMBER=
export IMAGE_NAME=
export IMAGE_TAG=

###

deploy/release specific vaiable 

###

export ENV_TARGET=
export DEPLOYMENT_REPO_NAME=
export K8_PLATFORM=
export CLUSTER_ENV_PLATFORM=
export CLUSTER_ID=
export CLUSTER_REGION=
export CLUSTER_NAME=
export CLUSTER_NAMESPACE=
export APP_URL= 

## Scenarios and Samples



