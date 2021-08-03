# cluster-api-openstack

Install [Cluster API (CAPI)](https://cluster-api.sigs.k8s.io/) manifests to
generate a fully working [Kubernetes openstack cluster (CAPO provider)](https://github.com/kubernetes-sigs/cluster-api-provider-openstack).

This chart replaces `clusterctl config cluster` by a customizable and enhanced 
version of manifests.

## Requirements

A working management CAPI cluster with CAPO support. This chart was developed with
 CAPI verison **v1alpha3** in mind.

If capi has **ClusterResourceSets enabled**, we provided manifests to install:
* Cloud config secret to be used by CSI and CCM
* External openstack cloud controler manager
* Calico manifests

> You can opt to include CCM and calico using values.

## Quick start

1. First copy `values.yaml` to start adjusting your custom values
1. Run helm install:

```
helm install lab2-todestroy . -f values-dev.yaml
```

The output notes will guide you to interact with you new cluster

## Values

To understand which values can be set, please read [`values.yaml`](./values.yaml).

## TODO

* This chart installs external cloud provider flavor, because is the recommended.
  No other flavor is provided at this time. We don't think it will be necesary
  to add other flavors, but it would be nice to have them.
