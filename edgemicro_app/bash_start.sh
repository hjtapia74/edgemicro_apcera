#!/bin/bash

set -e
echo "*** Starting at $(date) ***"
edge_root=/opt/apcera/apigee-edge-micro-1.1.2


if [ -e /nfs/data/.edgemicro/config.yaml ]
  then
      echo "*** Starting Edge Micro Agent ***"
      sudo ln -s /nfs/data/.edgemicro /.edgemicro
      more /.edgemicro/config.yaml

      export EDGEMICRO_KEY=$(awk '/key/ {print $2}' /nfs/data/.edgemicro/edgemicro_configuration)
      echo "*** Key is ${EDGEMICRO_KEY} ***"
      export EDGEMICRO_SECRET=$(awk '/secret/ {print $2}' /nfs/data/.edgemicro/edgemicro_configuration)
      echo "*** Secret is ${EDGEMICRO_SECRET} ***"
      
      cd $edge_root/agent
      npm start
  else
      echo "*** Creating directory /nfs/data/.edgemicro and linking to /.edgemicro"
      sudo mkdir /nfs/data/.edgemicro
      chown runner:runner /nfs/data/.edgemicro
      sudo ln -s /nfs/data/.edgemicro /.edgemicro

      cd $edge_root/cli/bin

      echo "*** Configuring Edge Micro ***"

      ./edgemicro configure -o apcera -e test -u hector@apcera.com -p Cops0240 > /nfs/data/.edgemicro/edgemicro_configuration

      export EDGEMICRO_KEY=$(awk '/key/ {print $2}' /nfs/data/.edgemicro/edgemicro_configuration)
      echo "*** Key is ${EDGEMICRO_KEY} ***"
      export EDGEMICRO_SECRET=$(awk '/secret/ {print $2}' /nfs/data/.edgemicro/edgemicro_configuration)
      echo "*** Secret is ${EDGEMICRO_SECRET} ***"

      echo "*** Verifying Edge Micro ./edgemicro verify -o apcera -e test -k ${EDGEMICRO_KEY} -s ${EDGEMICRO_SECRET} ***"
      ./edgemicro verify -o apcera -e test -k ${EDGEMICRO_KEY} -s ${EDGEMICRO_SECRET}

      echo "*** Starting Edge Micro Agent ***"
      cd $edge_root/agent
      npm start
fi
