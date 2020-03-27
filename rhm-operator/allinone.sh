#!/bin/bash

function main () {

  kubectl apply -f sub.yaml

  retries=0
  crd_found=$(kubectl get crd razeedeployments.marketplace.redhat.com --ignore-not-found)
  until [[ $retries == 50 || $crd_found ]]; do
      sleep 1
      crd_found=$(kubectl get crd razeedeployments.marketplace.redhat.com --ignore-not-found)   
      retries=$((retries + 1))
      echo "retried times: $retries"
  done

  # kubectl wait --for=condition=established --timeout=60s crd/razeedeployments.marketplace.redhat.com

  kubectl apply -f example.yaml

}

main
