# Federated SystemDS tutorial

This repository is dedicated to a distributed example of systemds federated.

## Step 1: Setup Parameters

Before you begin look trough the parameters.sh file, and change the variables to fit your needs.

The default parameters are set to execute a two worker setup on localhost.
If you have access to other machines simply change the address list to the remote locations, either using IP addresses, or aliases.

Also note the memory settings, and set these appropriately

## Step 2: install

This install script setup a local python environment installing systemds and
for all the addresses listed in the address list download and build systemds for both java execution but also for python systemds.

```sh
./install.sh
```

## Step 3: setup and download Data

