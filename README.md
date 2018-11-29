# Building Docker Image for Connectivity Agent  
This image is built on top of the [Oracle Java 8 SE (Server JRE)] container. 

## Instructions for Getting Oracle Java 8 Image
You need to register for the image at [Oracle Java 8 SE (Server JRE)] and proceed to Checkout.
This requires you to have a docker account.
After agreeing to the terms and conditions then you will be granted access to the image.
Once registered follow the [setup instructions][JDK Container Setup Instructions] to pull the image.

## Agent Binary
The agent binary must be downloaded from either Oracle Integration Cloud (OIC) or Autonomous Integration Cloud (AIC).
This image does not support Integration Cloud Service (ICS) agent.

## Building the Image
The script [build.sh][] can be used to build the image.
The script uses the following environments variables that are defaulted if not set:

|Variable|Use|Default|
|--------|---|-------|
|IMAGE_NAME|Name of the image to be built|oracle/connectivityagent|
|IMAGE_TAG|Tag of the image to be build|18.2.3|

## Running the Image
The script [run.sh][] can be used to run the image.
The name of the command to execute can be overridden by passing it as a command line parameter.
If the profile properties file (default [agent.env][]) has no entry for the oic_PASSWORD then the container will be started in the foreground to allow entry of the username/password.
If the container is started in the foreground after entering the username/password it is recommended to detach from the container (default keystroke is ^P^Q). 
The script uses the following environments variables that are defaulted if not set:

|Variable|Use|Default|
|--------|---|-------|
|IMAGE_NAME|Name of the image to be built|oracle/connectivityagent|
|IMAGE_TAG|Tag of the image to be build|18.2.3|
|CONTAINER_NAME|Name of container to be created|Agent|
|AGENT_PROFILE|Name of profile properties file|agent.env|

## Agent Profile Properties File
The profile properties file (default [agent.env][]) is used to pass parameters into the container.
It is formatted as a Docker Env File and is passed as a --env-file parameter.
If the password is left blank then the user will be prompted to enter the password when starting the container.

## Running Multiple Agent Containers
It is possible to run multiple agent containers by having multiple agent profile property files, for example dev.env, test.env and production.env, and using the `AGENT_PROFILE` environment variable.
It is also necessary to give each container a unique name by using the `CONTAINER_NAME` environment variable.

[Oracle Java 8 SE (Server JRE)]: https://store.docker.com/images/oracle-serverjre-8
[JDK Container Setup Instructions]: https://store.docker.com/images/oracle-serverjre-8/plans/ba2a7fa2-3b4e-4ba3-871c-f5ffe925a0e7?tab=instructions
[build.sh]: build.sh
[run.sh]: run.sh
[agent.env]: agent.env