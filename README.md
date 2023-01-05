# SysDig - Test Lab 
==================

Introduction
---------------

This Test Lab includes the components to conduct a Proof of Concept of image signature and verification in Kubernetes clusters (on a Mac using OSX with Docker Desktop and MiniKube Installed) leveraging the SysDig Events API.

Flow
--------

* Create a .dockerfile
* Code in a webserver (NginX) running on Alpine
* Build the Image
* Tag the Image for access to (OCI)
* Push the Image to the Repo
* 
* 
* 
OCI Registry - We will use Docker Hub
* Cosign - 
* Connaisseur / Kyverno (Govern)
* SysDig Agent Implementation for K8S MiniKube
* SysDig events UI Setup and Integration

Extended Flow
--------------

* Use Cosign (to sign images) and Connaisseur (to verify OCI image signatures) in K8s.
* Implement the SysDig events UI to then alert on blocked or non-compliant Images
* Implement rules to BLOCK unsigned images in NAMESPACE "block", ALLOW unsigned images in NS "WARN" (and any others) but alert as an event to the Sysdig UI.


Kyverno - Admission Controller
-------------------

- Allows policies to be written in yaml
- 



Workflow & Diagram
-------------------
TBA - Component Architecture

OSX Implementation
-------------------

- Install Docker Desktop
- Install Minikube and kubectl 

* Create SysDig Kubernetes Agent (Using Helm)

kubectl create ns sysdig-agent
helm repo add sysdig https://charts.sysdig.com
helm repo update
helm install sysdig-agent --namespace sysdig-agent \
    --set global.sysdig.accessKey=$KEY \
    --set global.sysdig.region=us4 \
    --set nodeAnalyzer.secure.vulnerabilityManagement.newEngineOnly=true \
    --set global.kspm.deploy=true \
    --set nodeAnalyzer.nodeAnalyzer.benchmarkRunner.deploy=false \
    --set global.clusterConfig.name=minikube\
    sysdig/sysdig-deploy

* Install Admission Controller


SysDig Node analysers

 helm install sysdig sysdig/sysdig-deploy \
    --create-namespace -n sysdig \
    --set global.sysdig.secureAPIToken=$KEY\
    --set global.clusterConfig.name=minikube \
    --set admissionController.sysdig.url=https://$SYSDIG_SECURE_ENDPOINT \
    --set admissionController.features.k8sAuditDetections=true \
    --set admissionController.enabled=true \
    --set agent.enabled=false \
    --set nodeAnalyzer.enabled=false


helm install sysdig-agent --namespace sysdig-agent \
  --set global.sysdig.accessKey= \
  --set global.sysdig.region=REGION \
  --set nodeAnalyzer.secure.vulnerabilityManagement.newEngineOnly=true \
  --set global.kspm.deploy=true \
  --set nodeAnalyzer.nodeAnalyzer.benchmarkRunner.deploy=false \
  --set global.clusterConfig.name=CLUSTER_NAME \
  sysdig/sysdig-deploy



USE THIS CURL COMMAND - REGION = app.us4.sysdig.com

curl -H 'Content-Type: application/json' -H "Authorization: Bearer $KEY -X POST "https://app.us4.sysdig.com/api/v1/eventsDispatch/ingest" -d @event.json


kubectl create ns sysdig-agent
helm repo add sysdig https://charts.sysdig.com
helm repo update
helm install sysdig-agent --namespace sysdig-agent \
    --set global.sysdig.accessKey=$KEY \
    --set global.sysdig.region=us4 \
    --set nodeAnalyzer.secure.vulnerabilityManagement.newEngineOnly=true \
    --set global.kspm.deploy=true \
    --set nodeAnalyzer.nodeAnalyzer.benchmarkRunner.deploy=false \
    --set global.clusterConfig.name=minikube \
    sysdig/sysdig-deploy

helm install \
    --namespace sysdig-agent \
    --set agent.sysdig.settings.tags='linux:ubuntu\,dept:dev\,local:nyc' \
    --set global.clusterConfig.name='minikube' \
    sysdig/sysdig-deploy


* Install Docker Agent * Additional Requirement to LAB

docker run -d --name sysdig-agent --restart always --privileged --net host --pid host \
    -e ACCESS_KEY=$KEY \
    -e COLLECTOR=ingest.us4.sysdig.com \
    -e SECURE=true \
    -v /var/run/docker.sock:/host/var/run/docker.sock \
    -v /dev:/host/dev \
    -v /proc:/host/proc:ro \
    -v /boot:/host/boot:ro \
    -v /lib/modules:/host/lib/modules:ro \
    -v /usr:/host/usr:ro \
    -v /etc:/host/etc:ro \
    --shm-size=512m \
    quay.io/sysdig/agent

