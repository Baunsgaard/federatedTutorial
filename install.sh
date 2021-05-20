#/bin/bash
source parameters.sh

if [[ ! -d "$VENV_PATH" ]]; then
    echo "Creating Python Virtual Enviroment on $HOSTNAME"
    python3 -m venv $VENV_PATH
    source "${VENV_PATH}/bin/activate"
    cd $SYSTEMDS_ROOT
    git pull >/dev/null 2>&1
    mvn clean package >/dev/null 2>&1
    cd src/main/python
    pip install wheel >/dev/null 2>&1
    python create_python_dist.py >/dev/null 2>&1
    pip install . | grep "Successfully installed" &&
        echo "Installed Python Systemds" || echo "Failed Installing Python"
fi

for index in ${!address[*]}; do
    if [ "${address[$index]}" != "localhost" ]; then
        # Install SystemDS on system.
        ssh -T ${address[$index]} '
        mkdir -p github;
        cd github;
        git clone https://github.com/apache/systemds.git  > /dev/null 2>&1;;
        cd systemds;
        mvn clean package' &

        # Install Systemds Python in virtual environment
        ssh -T ${address[$index]} "
        cd ${remoteDir};
        source '${VENV_PATH}/bin/activate';
        source 'parameters.sh';
        cd \$SYSTEMDS_ROOT;
        git pull > /dev/null 2>&1;
        mvn clean package > /dev/null 2>&1;
        cd src/main/python;
        python create_python_dist.py > /dev/null 2>&1;
        pip install . | grep 'Successfully installed' &&
            echo 'Installed Python Systemds' || echo 'Failed Installing Python';
        " &
    fi
done

wait
