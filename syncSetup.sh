#/bin/bash

source parameters.sh

# Synchronize code and setup.
for index in ${!address[*]}; do
    # echo "${address[$index]}"
    if [  "${address[$index]}" != "localhost" ]; then
        # Copy all code to the remote (only copy if not there.).
        sleep 0.2
        ssh -A ${address[$index]} "mkdir -p ${remoteDir}; cd ${remoteDir}; mkdir -p code; mkdir -p results ; mkdir -p datasets;" &
        sleep 0.2
        rsync -avhq -e ssh code/* ${address[$index]}:$remoteDir/code &
        sleep 0.2
        rsync -avhq -e ssh conf/* ${address[$index]}:$remoteDir/conf &
        sleep 0.2
        rsync -avhq -e ssh *.sh ${address[$index]}:$remoteDir &
        sleep 0.2
    fi
done
wait
