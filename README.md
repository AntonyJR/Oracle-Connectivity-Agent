# Docker Image for Oracle integration (OIC) Connectivity Agent
[This image][DockerHub] retrieves the Oracle Connectivity Agent from an OIC instance and runs it in a docker container.
For more information about the Oracle Integration Connectivity Agent please see [Manage the Agent Group and the On-Premises Connectivity Agent][] in the Oracle Integration documentation.
The container automatically connects to your OIC instance and downloads the agent zip file.
This image is built on top of the [Oracle Java 8 SE (Server JRE)] container.
A [github project][GitHub] contains the build instructions if a customized image is required.

## Running the Image
The script [run.sh][] can be used to run the image. I makes use of the script [agent_env.sh][]
If the profile properties file (default [agent.env][]) has no entry for the oic_PASSWORD then the container will be started in the foreground to allow entry of the username/password.
If the container is started in the foreground after entering the username/password it is recommended to detach from the container (default keystroke is ^P^Q). 
The [run.sh][] uses a volume to store the agent binaries and configuration.
When the container exits the container is removed but the volume persists. 
The volume is named with the container name.
The script uses the following environment variables that are defaulted if not set:

|Variable|Use|Default|
|--------|---|-------|
|CONTAINER_NAME|Name of the container to be created.  This is also used as the name of the volume used to persist agent configuration.|Agent|
|AGENT_PROFILE|Location of agent profile file.|agent.env|

## Agent Profile Properties File [agent.env][]
The profile properties file (default [agent.env][]) is used to pass parameters into the container.
It is formatted as a Docker Env File and is passed as a --env-file parameter.
The environment variables in the profile properties file are used to populate the InstallerProfile.cfg file in the docker container.

### Mandatory Properties
The following fields are mandatory.

|Variable|Use|
|--------|---|
|oic_URL|URL of the OIC instance in format https://<hostname>:443|
|agent_GROUP_IDENTIFIER|Note this is the identifier not the name, it will be based on the name but in all caps and with underscaores replacing spaces.|

### Optional Proxy Properties
The following fields may be required if a proxy server is being used and the proxy is not configured in the docker network.

|Variable|Use|
|--------|---|
|proxy_HOST|Proxy server hostname|
|proxy_PORT|Proxy server port number|
|proxy_USER|User name to authenticate against proxy server if required|
|proxy_PASSWORD|Password to authenticate against proxy server if required|
|proxy_NON_PROXY_HOSTS|List of hosts to not use the proxy, this should be hosts on the local network.|

### Optional Credentials
The following fields may be provided to avoid the need to enter credentials at container startup time.
If the password is left blank then the user will be prompted to enter the password when starting the container.
There are no defaults for these values.

|Variable|Use|
|--------|---|
|oic_USER|Username for authentication to OIC instance.|
|oic_PASSWORD|Password for authentication to OIC instance.|

## Running Multiple Agent Containers
It is possible to run multiple agent containers by having multiple agent profile property files, for example dev.env, test.env and production.env, and using the `AGENT_PROFILE` environment variable.
It is also necessary to give each container a unique name by using the `CONTAINER_NAME` environment variable.
If using [run.sh][] then each container will be associated with a volume of the same name.

## Resuming the Agent After Container Termination
Because the agent binaries and configuration are stored in a volume it is possible to restart the agent by issuing the same run command.
The run script checks to see if the agent binaries are already present before attempting to download them.

## Building the Image
The script [build.sh][] can be used to build the image.
The script uses the following environments variables that are defaulted if not set.

|Variable|Use|Default|
|--------|---|-------|
|IMAGE_NAME|Name of the image to be built|antonyjreynolds/connectivityagent|
|IMAGE_TAG|Tag of the image to be built|latest|

### Instructions for Getting Oracle Java 8 Image
You need to register for the image at [Oracle Java 8 SE (Server JRE)] and proceed to Checkout.
This requires you to have a docker account.
After agreeing to the terms and conditions then you will be granted access to the image.
Once registered follow the setup instructions to pull the image.

### Customizing the Image
The name of the command to execute can be overridden by passing it as a command line parameter but obviously you need to create an image with the new run command.

## TO DO
* Capture password via command line if not provided to avoid asking for it twice.
* Use password store to hold credentials
* Create yaml to deploy on K8s

[Manage the Agent Group and the On-Premises Connectivity Agent]: https://docs.oracle.com/en/cloud/paas/integration-cloud/integrations-user/managing-agent-groups-and-connectivity-agent.html
[Download and Install the Agent]: https://docs.oracle.com/en/cloud/paas/integration-cloud/integrations-user/agent-download-and-installation.html#GUID-932D53E0-69F1-42E2-8F9C-B2CB3B69A5B4
[Oracle Java 8 SE (Server JRE)]: https://store.docker.com/images/oracle-serverjre-8
[build.sh]: https://raw.githubusercontent.com/AntonyJR/Oracle-Connectivity-Agent/master/build.sh
[run.sh]: https://raw.githubusercontent.com/AntonyJR/Oracle-Connectivity-Agent/master/run.sh
[agent_env.sh]: https://raw.githubusercontent.com/AntonyJR/Oracle-Connectivity-Agent/master/agent_env.sh
[agent.env]: https://raw.githubusercontent.com/AntonyJR/Oracle-Connectivity-Agent/master/agent.env
[DockerHub]: https://hub.docker.com/r/antonyjreynolds/connectivityagent
[GitHub]: https://github.com/AntonyJR/Oracle-Connectivity-Agent
