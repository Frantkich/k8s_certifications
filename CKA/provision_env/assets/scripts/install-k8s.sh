#!/bin/bash

KUBERNETES_VERSION=v1.31
CRIO_VERSION=v1.31

# Enable IP forwarding for CNI
modprobe br_netfilter
modprobe overlay
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.bridge.bridge-nf-call-iptables=1
sysctl -w net.bridge.bridge-nf-call-ip6tables=1

# Disable swap (Disable by default by Azure)
# swapoff -a

# Install dependencies
apt-get update && apt-get install -y apt-transport-https software-properties-common curl

## K8s and CRI-O
curl -fsSL https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/$KUBERNETES_VERSION/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/stable:/$CRIO_VERSION/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/stable:/$CRIO_VERSION/deb/ /" | tee /etc/apt/sources.list.d/cri-o.list
apt-get update && apt-get install -y cri-o kubelet kubeadm kubectl

### Start CRI-O
systemctl daemon-reload
systemctl enable --now crio
