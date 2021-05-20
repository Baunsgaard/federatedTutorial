#/bin/bash

source parameters.sh

# Federated execution looping through the different number of workers.
# for index in ${!address[*]}; do
#     numWorkers=$((index + 1))
#     logstart="results/fed${numWorkers}"
#     mkdir -p $logstart

#     echo "fed ${numWorkers}W $conf - lm mnist"
#     fullLogname="$logstart/lm_mnist_${HOSTNAME}_$conf.log"

#     # Remove old log
#     rm -f $fullLogname

#     # Start execution (with system time)
#     { time -p \
#         systemds \
#         code/exp/lm.dml \
#         -stats 100 \
#         -debug \
#         -config conf/$conf.xml \
#         -args \
#         "data/fed_mnist_features_${numWorkers}.json" \
#         "data/fed_mnist_labels_${numWorkers}.json" \
#         FALSE \
#         "tmp/fed_mnist_${numWorkers}.res" \
#         ; } >>$fullLogname 2>&1


# done


# Get logs from federated sites
for index in ${!address[*]}; do
    rsync -avhq -e ssh ${address[$index]}:$remoteDir/results/fed/workerlog results/fed/workerlog &
done

# echo "loc $conf - lm mnist"
# # Local execution for reference:
# mkdir -p "results/local"
# fullLogname="results/local/lm_mnist_${HOSTNAME}_$conf.log"
# {
#     time -p \
#         systemds \
#         code/exp/lm.dml \
#         -stats 100 \
#         -debug \
#         -config conf/$conf.xml \
#         -args \
#         "data/mnist_features.data" \
#         "data/mnist_labels.data" \
#         FALSE \
#         "tmp/mnist_local.res" \
#         ;
# } >>$fullLogname 2>&1
