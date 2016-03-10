#!/bin/bash

set -e
echo "*** Starting at $(date) ***"
edge_root=/opt/apcera/apigee-edge-micro-1.1.0

export PATH=$edge_root/cli/bin:$PATH
echo Path is:
echo ${PATH} | tr ":" "\n"

ln -s /nfs/data/edgemicro-config-amer-partner5-test.yaml /var/tmp/edgemicro-config-amer-partner5-test.yaml
ls -l /var/tmp

cd $edge_root/cli/bin

echo "*** Configuring Edge Micro ***"

./edgemicro configure -o amer-partner5 -e test -u hector@apcera.com -p Cops0240 > edgemicro_configuration

export EDGEMICRO_KEY=$(awk '/key/ {print $2}' edgemicro_configuration)
echo "*** Key is ${EDGEMICRO_KEY} ***"
export EDGEMICRO_SECRET=$(awk '/secret/ {print $2}' edgemicro_configuration)
echo "*** Secret is ${EDGEMICRO_SECRET} ***"

echo "*** Verifying Edge Micro ./edgemicro verify -o amer-partner5 -e test -k ${EDGEMICRO_KEY} -s ${EDGEMICRO_SECRET} ***"
./edgemicro verify -o amer-partner5 -e test -k ${EDGEMICRO_KEY} -s ${EDGEMICRO_SECRET}

#echo "*** PAUSE A BIT ***"
#sleep 10

echo "*** Starting Edge Micro Agent ***"
cd $edge_root/agent

#echo Shell is $SHELL
#echo working in  $(pwd)
#echo using this nohup $(which nohup)
#echo dir permissions $(ls -ld .)

#nohup_file=/tmp/nohup.out
#nohup npm start &> $nohup_file &
npm start

#echo pause a bit
#sleep 10
#cat $nohup_file | awk '{printf("\t%s\n", $0)}'

#echo check port 9000
#netstat -na | egrep "8000|9000"

#echo "Starting Edge Microgateway"
#cd $edge_root/cli/bin

#./edgemicro agent proc -c start -k ${KEY} -s ${SECRET}

#echo "Finished at $(date)"
#netstat -na | egrep "8000|9000"

#tail -100f $nohup_file
