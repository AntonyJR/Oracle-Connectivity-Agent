FROM store/oracle/serverjre:8

ARG version=1.0

ENV run_command=run_agent.sh
ENV work_dir=/u01/agent/install

LABEL maintainer=Antony.Reynolds@oracle.com
LABEL version=$version

WORKDIR $work_dir

# Include agent zip and scripts
COPY ContainerScripts/$run_command ..

# Command to run agent
CMD ../$run_command