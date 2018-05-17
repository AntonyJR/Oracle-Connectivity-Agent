FROM store/oracle/serverjre:8 

ARG version=18.2.3
ARG agent_zip=oic_connectivity_agent.zip

ENV run_command=run_agent.sh
ENV work_dir=/u01/agent

LABEL maintainer=Antony.Reynolds@oracle.com
LABEL version=$version

WORKDIR $work_dir

# Include agent zip and scripts
COPY Agent/$agent_zip .
COPY ContainerScripts/$run_command .

# Unzip agent
RUN jar -xf $agent_zip

# Remove superfluous zip file
RUN rm $agent_zip

# Command to run agent
CMD $work_dir/$run_command

