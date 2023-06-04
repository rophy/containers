#!/bin/bash

#Entrypoint: https://github.com/bluet/docker-cronicle-docker/blob/master/docker/entrypoint.sh

ROOT_DIR=/opt/cronicle
CONF_DIR=$ROOT_DIR/conf
BIN_DIR=$ROOT_DIR/bin

# DATA_DIR needs to be the same as the exposed Docker volume in Dockerfile
DATA_DIR=$ROOT_DIR/data
# LOGS_DIR needs to be the same as the exposed Docker volume in Dockerfile
LOGS_DIR=$ROOT_DIR/logs
# PLUGINS_DIR needs to be the same as the exposed Docker volume in Dockerfile
PLUGINS_DIR=$ROOT_DIR/plugins

# The env variables below are needed for Docker and cannot be overwritten
export CRONICLE_Storage__Filesystem__base_dir=${DATA_DIR}
export CRONICLE_echo=1
export CRONICLE_foreground=1

if [ -z "${CRONICLE_master}" ]
then
    echo "env var CRONICLE_master not set, starting cronicle in worker mode..."
else
    echo "env var CRONICLE_master is set, Starting cronicle in master mode..."
    export HOSTNAME=master
fi


# Only run setup when setup needs to be done
if [ ! -f $DATA_DIR/.setup_done ]
then
  $BIN_DIR/control.sh setup

  # Create plugins directory
  mkdir -p $PLUGINS_DIR

  # Marking setup done
  touch $DATA_DIR/.setup_done
fi

# remove old lock file. resolves #9
PID_FILE=$LOGS_DIR/cronicled.pid
if [ -f "$PID_FILE" ]; then
    echo "Removing old PID file: $PID_FILE"
    rm -f $PID_FILE
fi

if [ -n "$1" ];
then
#   if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
#     set -- cronicle "$@"
#   fi
  exec "$@"
else
#   exec su cronicle -c "/opt/cronicle/bin/control.sh start"
  /opt/cronicle/bin/control.sh start
fi
