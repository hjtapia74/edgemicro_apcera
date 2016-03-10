Apigee EdgeMicro on the Apcera Platform

Theres two directories in this repository:

Apigee: Has the package definition and the Apigee EdgeMicro software version 1.1
edgemicro_app: Has the Apcera application Manifest to execute Apigee EdgeMicro out of the package

Instructions

Connect to the Apcera Cluster from inside the Apigee directory and execute:

> apc package create edgemicro.conf

once the package has been created, switch to the edgemicro_app and execute:

> apc app create

At this moment, in order for EdgeMicro to run, the edgemicro-auth proxy in Apigee Edge has to be deleted in order for the configuration to work.


