#!/usr/bin/env bash
# Set environment variables for agent
# Created By:
#   Antony.Reynolds@oracle.com

# Image Properties
IMAGE_NAME=${IMAGE_NAME:-oracle/connectivityagent}
IMAGE_TAG=${IMAGE_TAG:-18.3.3}

# Container Properties
CONTAINER_NAME=${CONTAINER_NAME:-Agent}

# Agent Profile
AGENT_PROFILE=${AGENT_PROFILE:-agent.env}

# If agent.env doesn't have password then set interactive session
if [ -f ${AGENT_PROFILE} ];
then
    if grep -q 'oic_PASSWORD=..*$' ${AGENT_PROFILE};
    then
        HEADLESS_FLAG=-d
    else
        HEADLESS_FLAG=-it
    fi
fi