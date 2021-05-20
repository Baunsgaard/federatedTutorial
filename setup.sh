#/bin/bash

source parameters.sh
source "$VENV_PATH/bin/activate"

./syncSetup.sh

python code/dataGen/generate_mnist.py

# Generate the federated json files, specifying the remote federated workers locations.
for index in ${!address[@]}; do
    numWorkers=$((index + 1))
    if [[ ! -f "data/fed_mnist_features_${numWorkers}.json" ]]; then
        python code/dataGen/federatedMetaDataGenerator.py \
            -p ${ports[@]} -n $numWorkers -d "mnist_features_" \
            -f 784 -e 60000 &
        python code/dataGen/federatedMetaDataGenerator.py \
            -p ${ports[@]} -n $numWorkers -d "mnist_labels_" \
            -f 10 -e 60000 &
    fi
done
wait

# Make Slices Mnist
# To give slices of different parts to the workers

datasets="mnist_features mnist_labels"
for name in $datasets; do
    for index in ${!address[@]}; do
        numWorkers=$((index + 1))
        if [[ ! -f "data/${name}_${numWorkers}_1.data.mtd" ]]; then
            echo "Generating data/${name}_${numWorkers}_1.data"
            systemds code/dataGen/slice.dml \
                -config conf/def.xml \
                -args $name $numWorkers &
        fi
    done

    wait
done

## Distribute the slices to individual workers.
for index in ${!address[@]}; do
    fileId=$((index + 1))
    for worker in $address; do
        numWorkers=$((worker + 1))
        ## Get results:
        if (($fileId <= $numWorkers)); then
            if [ "${address[$index]}" != "localhost" ]; then
                sleep 0.1
                rsync -ah -e ssh --include="*_${numWorkers}_${fileId}.dat*" --exclude='*' "data/" ${address[$index]}:$remoteDir/data/ &
                sleep 0.1
                rsync -ah -e ssh --include="*_${numWorkers}_${fileId}.data***" --exclude='*' "data/" ${address[$index]}:$remoteDir/data/ &
            fi
        fi
    done
    rsync -ah -e ssh --include="*_features.dat*" --exclude='*' "data/" ${address[0]}:${remoteDir}data/ &
    sleep 0.1
    rsync -ah -e ssh --include="*_features.dat***" --exclude='*' "data/" ${address[0]}:${remoteDir}data/ &
    sleep 0.1
    rsync -ah -e ssh --include="*_labels.dat*" --exclude='*' "data/" ${address[0]}:${remoteDir}data/ &
done

wait
