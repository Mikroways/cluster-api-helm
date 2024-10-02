# cluster-api-cloudstack

Install [Cluster API (CAPI)](https://cluster-api.sigs.k8s.io/) manifests to
generate a fully working [Kubernetes Cloudstack cluster (CAPC provider)](https://github.com/kubernetes-sigs/cluster-api-provider-cloudstack).

This chart replaces `clusterctl config cluster` by a customizable and enhanced 
version of manifests.

## Requirements

A working management CAPI cluster with CAPC support. This chart was developed with
 CAPI verison **v1beta1** in mind.

If capi has **ClusterResourceSets enabled**, we provided manifests to install:
* Cloud config secret to be used by CSI and CCM
* External cloudstack cloud controler manager
* Calico manifests

> You can opt to include CCM and calico using values.

## Values

To understand which values can be set, please read [`values.yaml`](./values.yaml).

