#!/bin/bash

kubectl -n example get --kubeconfig /tmp/kubeconfig svc ruby-demo-service -o jsonpath='{.status.loadBalancer.ingress[0]}'