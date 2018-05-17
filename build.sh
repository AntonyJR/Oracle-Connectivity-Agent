#!/bin/bash
# Build a Docker image to run the Oracle Integration Cloud Connectivity Agent
# Requirements:
#   Obtain oic_connectivity_agent.zip and place in same directory as dockerfile
# Created by :
#   Antony.Reynolds@oracle.com

# Set Environment
. agent_env.sh

# Create Docker Image
# Build Args: version, agent_zip, run_command
DOCKER_BUILD="docker build --squash --force-rm=true --no-cache=true \
                           --build-arg version=${IMAGE_TAG} \
                           -t ${IMAGE_NAME}:${IMAGE_TAG} ."
echo ${DOCKER_BUILD}
${DOCKER_BUILD}