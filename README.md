# Federated SystemDS tutorial

This repository is dedicated to a distributed example of systemds federated.

## Step 1: Setup Parameters

Before you begin look trough the parameters.sh file, and change the variables to fit your needs.

The default parameters are set to execute a two worker setup on localhost.
If you have access to other machines simply change the address list to the remote locations, either using IP addresses, or aliases.

Also note the memory settings, and set these appropriately

Before going further it is expected that you have setup the default install of systemDS described in: <http://apache.github.io/systemds/site/install>

## Step 2: install

This install script setup a local python environment installing systemds and
for all the addresses listed in the address list download and build systemds for both java execution but also for python systemds.

```sh
./install.sh
```

at the time of writing it results in:

```txt
Me:~/github/federatedTutorial$ ./install.sh
Creating Python Virtual Enviroment on XPS-15-7590
Successfully installed certifi-2020.12.5 chardet-4.0.0 idna-2.10 numpy-1.20.3 pandas-1.2.4 py4j-0.10.9.2 python-dateutil-2.8.1 pytz-2021.1 requests-2.25.1 six-1.16.0 systemds-2.1.0 urllib3-1.26.4
Installed Python Systemds
```

## Step 3: setup and download Data

Next we download and split the dataset into partitions that the different federated workers can use.

```sh
./setup.sh
```

The expected output is:

```txt
Me:~/github/federatedTutorial$ ./setup.sh
Generating data/mnist_features_2_1.data
SystemDS Statistics:
Total execution time:           0.672 sec.

Generating data/mnist_labels_2_1.data
SystemDS Statistics:
Total execution time:           0.109 sec.
```

and the data folder should contain the following:

```txt
Me:~/github/federatedTutorial$ ls data
fed_mnist_features_1.json      mnist_features_2_1.data      mnist_features.data        mnist_labels_2_2.data      mnist_test_features.data
fed_mnist_features_1.json.mtd  mnist_features_2_1.data.mtd  mnist_features.data.mtd    mnist_labels_2_2.data.mtd  mnist_test_features.data.mtd
fed_mnist_labels_1.json        mnist_features_2_2.data      mnist_labels_2_1.data      mnist_labels.data          mnist_test_labels.data
fed_mnist_labels_1.json.mtd    mnist_features_2_2.data.mtd  mnist_labels_2_1.data.mtd  mnist_labels.data.mtd      mnist_test_labels.data.mtd
```

## Step 4: Start workers

Now everything is setup, simply start the workers using the startAllWorkers script.

```sh
./startAllWorkers.sh
```

output:

```txt
Me:~/github/federatedTutorial$ ./startAllWorkers.sh 
Starting Workers.
Starting worker XPS-15-7590 8002 def
Starting worker XPS-15-7590 8001 def
```

The workers will start and some temporary files will be created containing the PID for the worker, to enable specific termination of the worker after experimentation is done. Note that you can run the algorithm multiple times with the same workers.

```txt
Me:~/github/federatedTutorial$ ls tmp/worker/
XPS-15-7590-8001  XPS-15-7590-8002
Me:~/github/federatedTutorial$ cat tmp/worker/XPS-15-7590-8001
13850
```

Also worth noting is that all the output from the federated worker is concatenated to: results/fed/workerlog/

## Step 5: run algorithms

