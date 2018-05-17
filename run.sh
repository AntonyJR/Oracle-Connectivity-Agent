#!/bin/bash
# Start Oracle Integration Cloud Agent Docker Container
# Created By:
#   Antony.Reynolds@oracle.com

# Set Environment
. agent_env.sh

# Start Docker Container
DOCKER_RUN="docker run ${HEADLESS_FLAG} --name ${CONTAINER_NAME} --env-file ${AGENT_PROFILE} ${IMAGE_NAME}:${IMAGE_TAG} $*"
echo ${DOCKER_RUN}
${DOCKER_RUN}
docker logs -f ${CONTAINER_NAME}