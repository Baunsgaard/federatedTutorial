#/bin/bash

source parameters.sh

## This script is to be run locally.

echo "Starting Workers."
for index in ${!address[*]}; do
    if [ "${address[$index]}" == "localhost" ]; then
        ./scripts/startWorker.sh ${ports[$index]} $conf &
    else
        ssh ${address[$index]} " cd ${remoteDir}; ./scripts/startWorker.sh ${ports[$index]} $conf" &
    fi
done
wait
sleep 4

