#!/bin/bash
export SYSTEMDS_STANDALONE_OPTS="-Xmx30g -Xms30g -Xmn3000m"
export SYSTEMDS_ROOT="$HOME/github/systemds"
export PATH="$SYSTEMDS_ROOT/bin:$PATH"

## Logging variables:
export LOG4JPROP='conf/log4j-off.properties'
# export LOG4JPROP='conf/log4j-debug.properties'
# export LOG4JPROP='conf/log4j-info.properties'
export SYSDS_QUIET=1

address=("tango" "delta")
ports=("8001" "8002")
numWorkers=${#address[@]}

remoteDir="github/federatedTutorial-v2/"

# configuration:
conf="def"
# conf="ssl"

# Data:
x="data/fed_mnist_features_${numWorkers}.json"
y="data/fed_mnist_labels_${numWorkers}.json"
y_hot="data/fed_mnist_labels_hot_${numWorkers}.json"

xt="data/fed_mnist_test_features_${numWorkers}.json"
yt="data/fed_mnist_test_labels_${numWorkers}.json"
yt_hot="data/fed_mnist_test_labels_hot_${numWorkers}.json"

# Local:
x_loc="data/mnist_features.data"
y_loc="data/mnist_labels.data"
xt_loc="data/mnist_test_features.data"
yt_loc="data/mnist_test_labels.data"
