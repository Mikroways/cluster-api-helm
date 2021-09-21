#!/usr/bin/env bash

set -e

DIR=$(dirname $0)
DIR="$DIR"/files/crs
declare -A MANIFESTS=(
  [calico-cni]="https://docs.projectcalico.org/manifests/calico.yaml"
  )

for k in "${!MANIFESTS[@]}"; do
  mkdir -p "$DIR"/$k
  for m in ${MANIFESTS[$k]}; do
    curl -Ls "$m" -o "$DIR/$k/$(basename $m)"
  done
done
