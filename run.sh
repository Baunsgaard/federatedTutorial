#/bin/bash

source parameters.sh

# Execute a sum of the dataset
# systemds code/exp/sum.dml -args $x
# Get statistics output
# systemds code/exp/sum.dml -stats -args $x
# Get execution explaination
# systemds code/exp/sum.dml -explain -args $x


# Execute a Linear model algorithm
# systemds code/exp/lm.dml \
#     -config conf/$conf.xml \
#     -stats 100 \
#     -debug \
#     -args $x $y_hot TRUE "results/fed_mnist_${numWorkers}.res"

# Execute a Multi Log Regression model, do prediction and print confusion matrix
# systemds code/exp/mLogReg.dml \
#     -config conf/$conf.xml \
#     -stats 30 \
#     -args $x $y $xt $yt TRUE

# Execute locally to compare
# systemds code/exp/mLogReg.dml \
#     -config conf/$conf.xml \
#     -stats 100 \
#     -args $x_loc $y_loc $xt_loc $yt_loc TRUE

systemds code/exp/CNN.dml \
    -stats \
    -args $x $y_hot $xt $yt_hot

    