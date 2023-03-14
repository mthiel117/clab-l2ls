# AVD L2LS Data Model for ContinerLab running on Remote Host

## Virtual Test Environment

ContainerLab will be utilized to build a test environment where configurations can be deployed to test functionality of the resulting AVD configuration files. The basic L2LS topo used for building and pushing test configs will be similar to the following.

![L2LS Topo](images/clab-l2ls-topo.png)

A Virtual Machine running docker and containerlab will be needed.

![Clab Deploy](images/clab-deploy.png)

## Build & Deploy Configs

Open Repository in devcontainer.  Change directory to `/workspace/Projects/clab-l2ls`. Using a Makefile you can launch a separate build and deploy process for each site.  The below exampale shows building and deploying to the ContainerLab environment.

``` bash
# Build CLAB Configs
make build-clab
```

``` bash
# Deploy CLAB Configs
make deploy-clab
```
