# cluster-api helm charts

Install [Cluster API (CAPI)](https://cluster-api.sigs.k8s.io/) manifests to
generate a fully working Kubernetes cluster for different providers.

Not all providers are implemented yet. We will be adding new providers as our
clients demand us. At this time, we provide the following charts:

* [cloudstack](./charts/capi-cloudstack)
* [openstack](./charts/capi-openstack)
* [proxmox](./charts/capi-proxmox)
* [vsphere](./charts/capi-vsphere)


## Usage

Add helm repo:

```
helm repo add mw-capi https://mikroways.github.io/cluster-api-helm/ 
helm repo update
```

Then you can search for available cluster providers with:

```
helm repo search cluster-api
```

