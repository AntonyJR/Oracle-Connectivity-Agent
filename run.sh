#!/bin/bash
# Start Oracle Integration Cloud Agent Docker Container
# Created By:
#   Antony.Reynolds@oracle.com

# Set Environment
. `dirname "$0"`/agent_env.sh

# Start Docker Container
DOCKER_RUN="docker run ${HEADLESS_FLAG} --name ${CONTAINER_NAME} --env-file ${AGENT_PROFILE} --rm --mount source=${CONTAINER_NAME},target=/u01/agent/install ${IMAGE_NAME}:${IMAGE_TAG} $*"
echo ${DOCKER_RUN}
${DOCKER_RUN}
if [ "$HEADLESS_FLAG" = "-d" ]
then
  docker logs -f ${CONTAINER_NAME}
fi
