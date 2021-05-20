#/bin/bash

export SYSTEMDS_STANDALONE_OPTS="-Xmx10g -Xms10g -Xmn1000m"
export LOG4JPROP='conf/log4j-off.properties'
export SYSTEMDS_ROOT="$HOME/github/systemds"
export PATH="$SYSTEMDS_ROOT/bin:$PATH"
export SYSDS_QUIET=1

VENV_PATH="python_venv"

address=("localhost" "localhost")
ports=("8001" "8002" "8003" "8004" "8005" "8006" "8007" "8008")

remoteDir="$HOME/github/federatedTutorial/"

# Default configuration without encrypted comunication
conf="def"
# SSL encrypted communication
# conf="ssl"