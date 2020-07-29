#!/bin/bash
# Build a Docker image to run the Oracle Integration Cloud Connectivity Agent
# Requirements:
#   Obtain $IMAGE_TAG oic_connectivity_agent.zip and place in Agent directory under dockerfile
#   Rename the image $IMAGE_TAG.oic_connectivity_agent.zip so you can build multiple versions
# Created by :
#   Antony.Reynolds@oracle.com

# Set Environment
. agent_env.sh

# Create Docker Image
# Build Args: version, agent_zip, run_command
# DOCKER_BUILD="docker build --squash --force-rm=true --no-cache=true \
DOCKER_BUILD="docker build --build-arg version=${IMAGE_TAG} \
                           -t ${IMAGE_NAME}:${IMAGE_TAG} ."
echo ${DOCKER_BUILD}
${DOCKER_BUILD}