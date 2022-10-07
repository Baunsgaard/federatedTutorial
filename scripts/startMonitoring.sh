#/bin/bash

source parameters.sh

mkdir -p tmp/monitoring

nohup \
    systemds FEDMONITORING 8080 \
    > tmp/monitoring/log.out 2>&1 &

echo $! > tmp/monitoring/monitoringProcessID
echo "Starting monitoring"

here=$(pwd)

echo "$SYSTEMDS_ROOT"

cd "$SYSTEMDS_ROOT/scripts/monitoring"
nohup tail -f $here/tmp/monitoring/UILog.in |nohup \
   npm start \
   > $here/tmp/monitoring/UILog.out 2>&1 &
cd $here
echo $! > "tmp/monitoring/UIProcessID"

sleep 10

curl --header "Content-Type: application/json" --data '{"name":"W1","address":"localhost:8001"}' http://localhost:8080/workers
curl --header "Content-Type: application/json" --data '{"name":"W2","address":"localhost:8002"}' http://localhost:8080/workers
curl --header "Content-Type: application/json" --data '{"name":"W3","address":"localhost:8003"}' http://localhost:8080/workers
curl --header "Content-Type: application/json" --data '{"name":"W4","address":"localhost:8004"}' http://localhost:8080/workers


echo "Starting UI"

