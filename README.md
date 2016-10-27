[![Build Status](https://travis-ci.org/garethahealy/elastalert-on-ocp.svg?branch=master)](https://travis-ci.org/garethahealy/elastalert-on-ocp)

# elastalert-on-ocp
Demo to show ElastAlert running on OpenShift Container Platform (https://www.openshift.com)

If you don't know what ElastAlert is; the below links are a good primer:
- http://engineeringblog.yelp.com/2015/10/elastalert-alerting-at-scale-with-elasticsearch.html
- http://engineeringblog.yelp.com/2016/03/elastalert-part-two.html

Source for ElastAlert can be found:
- https://github.com/Yelp/elastalert

## Running the example
The example can be run on the CDK, if you are unsure how to do this; the below link is a good primer:
- https://blog.openshift.com/how-to-install-red-hat-container-development-kit-cdk-in-minutes/

Once you have the CDK running, you will need to deploy the Logging
- https://docs.openshift.com/enterprise/3.2/install_config/aggregate_logging.html

sudo -i
oc login --username=admin --password=admin --certificate-authority=/var/lib/openshift/openshift.local.config/master/ca.crt --server=https://10.1.2.2:8443
oc get pods --all-namespaces=true

    [root@rhel-cdk enterprise]# oc get pods --all-namespaces=true
    NAMESPACE   NAME                       READY     STATUS             RESTARTS   AGE
    default     docker-registry-2-rbksn    1/1       Running            0          1h
    default     router-1-401h3             2/2       Running            0          1h

Check webconsole works via:
    
    https://10.1.2.2:8443/console/

subscription-manager repos --disable="*"
subscription-manager repos \
    --enable="rhel-7-server-rpms" \
    --enable="rhel-7-server-extras-rpms" \
    --enable="rhel-7-server-ose-3.2-rpms" \
    --enable="rhel-7-server-optional-rpms"

https://docs.openshift.com/enterprise/3.2/install_config/aggregate_logging.html

    [root@rhel-cdk enterprise]# oc get pods
    NAME                          READY     STATUS    RESTARTS   AGE
    logging-es-wtpoj10f-1-m4fps   1/1       Running   0          31m
    logging-fluentd-2-aqamw       1/1       Running   0          14m
    logging-kibana-1-i61t1        2/2       Running   0          31m


https://logging-kibana-openshift-infra.rhel-cdk.10.1.2.2.xip.io


oc new-build https://github.com/garethahealy/elastalert-on-ocp.git --context-dir=elastalert-core/src/main/docker --name=elastalert-core
oc new-app https://github.com/garethahealy/elastalert-on-ocp.git --context-dir=elastalert-rule-hello-world/src/main/docker --name=ea-rule-hello


[root@rhel-cdk enterprise]# oc project sample-project
Now using project "sample-project" on server "https://10.1.2.2:8443".

[root@rhel-cdk enterprise]# oc create -f https://raw.githubusercontent.com/openshift/origin/master/examples/hello-openshift/hello-pod.json



oc get pod -n sample-project hello-openshift -o yaml | grep podIP | cut -d':' -f2 | xargs


/etc/kibana/keys
curl -v -E ./cert --key key --cacert ca "https://logging-es:9200/_cat/health?v" 

## Building
- mvn clean install
- docker build --tag garethahealy/elastalert-core base/src/main/docker/
- docker build --tag garethahealy/elastoplast-rule1 rule1/src/main/docker/

