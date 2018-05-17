#!/usr/bin/env bash
# Run agent
# Created by :
#   Antony.Reynolds@oracle.com

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

# Run connectivity agent
$JAVA_HOME/bin/java ${java_FLAGS} -jar connectivityagent.jar ${agent_FLAGS}