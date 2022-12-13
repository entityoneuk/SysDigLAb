# SysDig - Test Lab 
==================

Introduction
------------

This Test Lab includes the components to conduct a Proof of Concept of image signature and verification in Kubernetes clusters.

User Resources
--------------

* OCI Registry
* Cosign
* Connaisseur
* Sysdig events UI Integration
* Minikube with three NS "default" , "block" , "warn"

Extended Flow
--------------

* Use Cosign (to sign images) and Connaisseur (to verify OCI image signatures) in K8s.
* Implement the SysDig events UI to then alert on blocked or non-compliant Images
* Implement rules to BLOCK unsigned images in NAMESPACE "block", ALLOW unsigned images in NS "WARN" (and any others) but alert as an event to the Sysdig UI.

Workflow & Diagram
-------------------
TBA - Component Architecture