#!/usr/bin/env bash

set -e

DIR=$(dirname $0)
DIR="$DIR"/templates/crs
declare -A MANIFESTS=(
  [calico-cni]="https://docs.projectcalico.org/manifests/calico.yaml"
  [ccm-openstack]="https://raw.githubusercontent.com/kubernetes/cloud-provider-openstack/master/manifests/controller-manager/cloud-controller-manager-roles.yaml
    https://raw.githubusercontent.com/kubernetes/cloud-provider-openstack/master/manifests/controller-manager/cloud-controller-manager-role-bindings.yaml
    https://raw.githubusercontent.com/kubernetes/cloud-provider-openstack/master/manifests/controller-manager/openstack-cloud-controller-manager-ds.yaml"
  )

for k in "${!MANIFESTS[@]}"; do
  mkdir -p "$DIR"/$k
  for m in ${MANIFESTS[$k]}; do
    curl -Ls "$m" -o "$DIR/$k/$(basename $m)"
  done
done
