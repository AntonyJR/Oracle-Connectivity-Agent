# Building Docker Image for Connectivity Agent  
This image allows you to run the Oracle Integration Connectivity Agent as a Docker image.
For more information about the Oracle Integration Connectivity Agent please see [Manage the Agent Group and the On-Premises Connectivity Agent][] in the Oracle Integration documentation.
The image automatically connects to your OIC instance and downloads the agent zip file..
This image is built on top of the [Oracle Java 8 SE (Server JRE)] container. 

## Instructions for Getting Oracle Java 8 Image
You need to register for the image at [Oracle Java 8 SE (Server JRE)] and proceed to Checkout.
This requires you to have a docker account.
After agreeing to the terms and conditions then you will be granted access to the image.
Once registered follow the [setup instructions][JDK Container Setup Instructions] to pull the image.

## Building the Image
The script [build.sh][] can be used to build the image.
The script uses the following environments variables that are defaulted if not set:

|Variable|Use|Default|
|--------|---|-------|
|IMAGE_NAME|Name of the image to be built|oracle/connectivityagent|
|IMAGE_TAG|Tag of the image to be build|1.0|

## Profile Properties File [agent.env][]
The [agent.env][] is used to pass the agent its configuration data.
The environment variables in the profile properties file are used to populate the InstallerProfile.cfg file in the docker container.
The following fields are mandatory:

|Variable|Use|
|--------|---|
|oic_URL|URL of the OIC instance in format https://<hostname>:443|
|agent_GROUP_IDENTIFIER|Note this is the identifier not the name, it will be based on the name but in all caps and with underscaores replacing spaces.|

The following fields may be required if a proxy server is being used and the proxy is not configured in the docker network:

|Variable|Use|
|--------|---|
|proxy_HOST|Proxy server hostname|
|proxy_PORT|Proxy server port number|
|proxy_USER|User name to authenticate against proxy server if required|
|proxy_PASSWORD|Password to authenticate against proxy server if required|
|proxy_NON_PROXY_HOSTS|List of hosts to not use the proxy, this should be hosts on the local network.|

## Running the Image
The script [run.sh][] can be used to run the image.
The name of the command to execute can be overridden by passing it as a command line parameter.
If the profile properties file (default [agent.env][]) has no entry for the oic_PASSWORD then the container will be started in the foreground to allow entry of the username/password.
If the container is started in the foreground after entering the username/password it is recommended to detach from the container (default keystroke is ^P^Q). 
The [run.sh][] uses a volume to store the agent binaries and configuration.
When the container exits the container is removed but the volume persists. 
The volume is named with the container name.
The script uses the following environments variables that are defaulted if not set:

|Variable|Use|Default|
|--------|---|-------|
|IMAGE_NAME|Name of the image to be built|oracle/connectivityagent|
|IMAGE_TAG|Tag of the image to be build|19.3.2|
|CONTAINER_NAME|Name of container to be created|Agent|
|AGENT_PROFILE|Name of profile properties file|agent.env|

## Agent Profile Properties File
The profile properties file (default [agent.env][]) is used to pass parameters into the container.
It is formatted as a Docker Env File and is passed as a --env-file parameter.
If the password is left blank then the user will be prompted to enter the password when starting the container.

## Running Multiple Agent Containers
It is possible to run multiple agent containers by having multiple agent profile property files, for example dev.env, test.env and production.env, and using the `AGENT_PROFILE` environment variable.
It is also necessary to give each container a unique name by using the `CONTAINER_NAME` environment variable.
If using [run.sh][] then each container will be associated with a volume of the same name.

## Resuming the Agent After Container Termination
Because the agent binaries and configuration are stored in a volume it is possible to restart the agent by issuing the same run command.  The run script checks to see if the agent binaries are already present before attempting to download them.

# TO DO
Use password store to hold credentials

[Manage the Agent Group and the On-Premises Connectivity Agent]: https://docs.oracle.com/en/cloud/paas/integration-cloud/integrations-user/managing-agent-groups-and-connectivity-agent.html
[Download and Install the Agent]: https://docs.oracle.com/en/cloud/paas/integration-cloud/integrations-user/agent-download-and-installation.html#GUID-932D53E0-69F1-42E2-8F9C-B2CB3B69A5B4
[Oracle Java 8 SE (Server JRE)]: https://store.docker.com/images/oracle-serverjre-8
[JDK Container Setup Instructions]: https://store.docker.com/images/oracle-serverjre-8/plans/ba2a7fa2-3b4e-4ba3-871c-f5ffe925a0e7?tab=instructions
[build.sh]: build.sh
[run.sh]: run.sh
[agent.env]: agent.env
