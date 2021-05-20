#/bin/bash

source parameters.sh

## Close workers
# for all remote workers stop.
for index in ${!address[*]}; do
    if [ "${address[$index]}" != "localhost" ]; then
        ssh ${address[$index]} " cd ${remoteDir}; ./stopWorker.sh" &
    fi
done
# stop all localhost workers.
./stopWorker.sh

wait
