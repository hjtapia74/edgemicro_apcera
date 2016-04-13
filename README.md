<H1> Apigee Edge Micro on the Apcera Platform </H1>

Theres two directories in this repository:

<B> Apigee: </B> Has the package definition and the Apigee EdgeMicro software version 1.1.2 <br>
<B> edgemicro_app: </B> Has the Apcera application Manifest to execute Apigee EdgeMicro out of the package

Instructions

Connect to the Apcera Cluster from inside the Apigee directory and execute:

<code> apc package create edgemicro.conf </code>

Once the package has been created, switch to the edgemicro_app directory and modify the bash_start.sh file, adjust the configuration step on line 31 with your own user and password for Apigee Edge Gateway, make sure to adjust your Apigee Organization as well.

You will also need to update the continuum.conf file with the correct name of the NFS provider of your Apcera Cluster

Once this changes have been saved, create the Application in the Apcera Platform

<code> apc app create </code>




