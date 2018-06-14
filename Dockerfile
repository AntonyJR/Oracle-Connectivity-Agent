FROM store/oracle/serverjre:8 as BUILD

ARG agent_zip=oic_connectivity_agent.zip

ENV work_dir=/u01/agent

WORKDIR $work_dir

# Include agent zip and scripts
COPY Agent/$agent_zip .

# Unzip agent
RUN jar -xf $agent_zip

FROM store/oracle/serverjre:8

ARG version=18.2.3

ENV run_command=run_agent.sh
ENV work_dir=/u01/agent

LABEL maintainer=Antony.Reynolds@oracle.com
LABEL version=$version

WORKDIR $work_dir

# Include agent zip and scripts
COPY --from=BUILD $work_dir/agenthome $work_dir/InstallerProfile.cfg ./
COPY ContainerScripts/$run_command .

# Command to run agent
CMD $work_dir/$run_command

