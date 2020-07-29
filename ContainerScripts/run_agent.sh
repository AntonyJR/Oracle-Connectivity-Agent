#!/usr/bin/env bash

# Run agent
# Created by :
#   Antony.Reynolds@oracle.com

AGENT_JAR=connectivityagent.jar
AGENT_ZIP=oic_conn_agent_installer.zip
AGENT_DOWNLOAD=/ic/api/integration/v1/agents/binaries/connectivity

# Check if already initialized
if [ ! -d agenthome ] ; then
    # Validate URL & Group set
    if [ -z "${oic_URL}" -o -z "${agent_GROUP_IDENTIFIER}" ] ; then
        echo Must specify oic_URL and agent_GROUP_IDENTIFIER
        echo oic_URL=${oic_URL}
        echo agent_GROUP_IDENTIFIER=${agent_GROUP_IDENTIFIER}
        exit -1
    fi

    # Get download credentials
    UN=${oic_USER}
    if [ -z "${UN}" ] ; then
        echo Enter Username
        read UN
    fi
    if [ -z "${oic_PASSWORD}" ] ; then
        USERPW=${UN}
    else
        USERPW=${UN}:${oic_PASSWORD}
    fi

    # Set curl proxy
    if [ -z "${proxy_HOST}" ] ; then
        PROXY="--noproxy '${proxy_NON_PROXY_HOSTS}' -x '${proxy_HOST}:${proxy_PORT}"
    fi

    # Get Binary
    curl -f -u ${USERPW} -o ${AGENT_ZIP} ${oic_URL}${AGENT_DOWNLOAD}
    RESP=$?
    UN=
    USERPW=
    if test "${RESP}" != "0"; then
       echo "Download of agent failed"
       exit ${RESP}
    fi
    jar -xf ${AGENT_ZIP}

    # Check if profile holds user/password properties and add if missing
    for PROP in oic_USER oic_PASSWORD;
    do
        if ! grep -q "^${PROP}=" InstallerProfile.cfg
        then
            echo "${PROP}=" >> InstallerProfile.cfg
        fi
    done

    # Set profile from environment variables if not already set
    if ! grep -q 'oic_URL=..*$' InstallerProfile.cfg;
    then
        sed -i "s~\(oic_URL=\).*$~\1${oic_URL}~; \
                s~\(agent_GROUP_IDENTIFIER=\).*$~\1${agent_GROUP_IDENTIFIER}~; \
                s~\(proxy_HOST=\).*$~\1${proxy_HOST}~; \
                s~\(proxy_PORT=\).*$~\1${proxy_PORT}~; \
                s~\(proxy_USER=\).*$~\1${proxy_USER}~; \
                s~\(proxy_PASSWORD=\).*$~\1${proxy_PASSWORD}~; \
                s~\(proxy_NON_PROXY_HOSTS=\).*$~\1${proxy_NON_PROXY_HOSTS}~; \
                s~\(oic_USER=\).*$~\1${oic_USER}~; \
                s~\(oic_PASSWORD=\).*$~\1${oic_PASSWORD}~" InstallerProfile.cfg
    fi

    # Remove username and password environment variables
    export oic_PASSWORD=
    export oic_USER=
fi

# Run connectivity agent
java ${java_FLAGS} -jar ${AGENT_JAR} ${agent_FLAGS}