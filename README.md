# Red Hat Decision Manager 7 standalone CeKit module

This repo contains the base module that installs the product artifacts in the target OpenShift image.


This repository does not need to be built manually, it is used as a cekit module  that will builds the base image
that contains the EAP with the application layer (business central, kieserver, etc.) on it without any kind
of configuration, we call it standalone-image, all the configuration will be made by the *-openshift repositories
which contains the image descriptors with all modules that will be installed. In this repo you will find the basics
like which artifact (kieserver, business central, etc) is being used to build the openshift images. Let’s inspect the
rhdm-7-decisioncentral cekit module:


```yaml
---
schema_version: 1
name: "rhdm-7-decisioncentral"
version: "1.0"
description: "Red Hat Decision Manager Central 7.10 installer"
labels:
- name: "org.jboss.product"
  value: "rhdm-decisioncentral"
- name: "org.jboss.product.version"
  value: "7.10.0"
- name: "org.jboss.product.rhdm-decisioncentral.version"
  value: "7.10.0"
envs:
- name: "JBOSS_PRODUCT"
  value: "rhdm-decisioncentral"
- name: "RHDM_DECISION_CENTRAL_VERSION"
  value: "7.10.0"
- name: "PRODUCT_VERSION"
  value: "7.10.0"
- name: "DECISION_CENTRAL_DISTRIBUTION_ZIP"
  value: "rhdm-decision_central_distribution.zip"
- name: "DECISION_CENTRAL_DISTRIBUTION_EAP"
  value: "jboss-eap-7.2"
ports:
- value: 8001
artifacts:
- name: "rhdm-decision_central_distribution.zip"
  # rhdm-7.10.0.redhat-20200224-decision-central-eap7-deployable.zip
  md5: "759fc7de8cdc5f366e90bdd10c66346e"
run:
  user: 185
  cmd:
  - "/opt/eap/bin/standalone.sh"
  - "-b"
  - "0.0.0.0"
  - "-c"
  - "standalone.xml"
execute:
- script: "install"
```

In the file above we set the most important configurations to which defines:
    - the product
    - the product version
    - the product zip artifact, which will be deployed on the final OpenShift image.

Note the *DECISION_CENTRAL_DISTRIBUTION.ZIP* env, its value will be the artifact name that, when the build is completed,
is placed in the `/<images_source_dir>/rhdm-7-openshift-image/businesscentral/target/image` directory,
note that it is on the rhdm-7-openshift-image repository. The **module.yaml** file above is a example of
the base module used to configure the product bits into the final OpenShift image. All OpenShift images have a
similar module descriptor, and these modules (the base modules) are one of the first module listed in
the *-openshift image’s image.yaml file.


This repo is used to build the final OpenShift images, they contain a set of yaml files, below you will find each
file and its purpose, all the modules have the same files, as described below:

 - **container.yaml**: used by OSBS builds.
 - **content_sets.yaml**: define the yum repositories needed to install dependencies for the image.
 - **branch-overrides.yaml**: overrides file which uses the latest stable version for external dependencies. The module.yaml and image.yaml always refer to master branch.
 - **tag-overrides.yaml**: Used to override the branchs to use the final tags to rebuild released images, for CVE respins.
 - **image.yaml**: the main image descriptor file, here are all the pieces and configuration needed to build an image. (Deprecated)


##### Found a issue?
Please submit a issue [here](https://issues.jboss.org/projects/KIECLOUD) or send us a email: bsig-cloud@redhat.com.
