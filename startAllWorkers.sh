#/bin/bash

source parameters.sh

echo "Starting Workers."
for index in ${!address[*]}; do
    if [ "${address[$index]}" == "localhost" ]; then
        ./startWorker.sh ${ports[$index]} $conf &
    else
        ssh ${address[$index]} " cd ${remoteDir}; ./startWorker.sh ${ports[$index]} $conf" &
    fi
done
wait
sleep 4

