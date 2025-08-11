# cluster-api-proxmox

Follow [Cluster API Provider for
Porxmo](https://github.com/ionos-cloud/cluster-api-provider-proxmox)
instructions. Instead of using:

```bash
clusterctl generate cluster proxmox-mw \
    --infrastructure proxmox \
    --control-plane-machine-count 1 \
    --worker-machine-count 2 > cluster.yaml
```

The following chart can be used

```bash
helm repo add 
helm upgrade --install --create-namespace -n 'k8s-management'
cluster-api-proxmox/cluster-api-proxmox -f values.yaml
```

## Requirements

As mentioned above, you can easily test this chart following capmox
documentation. As a simple quick example, the following steps shall be done:

### First create a kind cluster

```bash
kind create cluster --name clusterctl
```

When cluster pods are all running, continue with next step.

### Install clusterapi controllers

Before running the following command please, verify all required environment
variables are set as explained in capmox documentation.

> Most important variables for this step are: `PROXMOX_URL`, `PROXMOX_TOKEN` and
> `PROXMOX_SECRET`

```bash
clusterctl init --infrastructure proxmox --addon helm --ipam in-cluster
```

When all pods are isntalled and running, you can now create your first cluster
using this chart

## Example working example

Asuming some PVE standards, and without using Proxmox pools and VLANs, the
following `samples.yaml` can generate a working cluster:

```yaml
users:
  - name: root
    sshAuthorizedKeys: 
      - ..... some ssh publick key
clusterNetwork:
  pods:
    cidrBlocks:
      - 10.100.0.0/16
proxmox:
  allowedNodes:
    - pve
  controlPlaneEndpoint:
    host: 192.168.60.100   # Important! this must be changed
    port: 6443
  dnsServers:
    - 1.1.1.1
  ipv4Config:
    addresses:
      - 192.168.60.102-192.168.60.110
    gateway: 192.168.60.1
    prefix: 24
kubeadmControlPlane:
  templateName: control-plane
  version: 1.32.5

machineTemplates:
  - name: control-plane
    diskSizeGb: 60
    format: raw
    memory: 4096
    numCores: 2
    numSockets: 2
    templateID: 101
    network:
       default:
         bridge: vmbr0
         model: virtio
  - name: worker
    diskSizeGb: 60
    format: raw
    memory: 4096
    numCores: 2
    numSockets: 2
    templateID: 101
    network:
       default:
         bridge: vmbr0
         model: virtio

machineDeployments:
   - name: md name
     templateName: worker
     kubeadmConfigTemplateName: worker
     replicas: 2
kubeadmConfigTemplates:
  - name: worker
    joinConfiguration:
      nodeRegistration:
        kubeletExtraArgs:
          provider-id: "proxmox://'{{ ds.meta_data.instance_id }}'"
```


## Values

To understand which values can be set, please read [`values.yaml`](./values.yaml).

