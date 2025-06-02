# 🧠 Kubernetes Architecture Cheat Sheet

Kubernetes is built on a **Control Plane** (the brains) and **Worker Nodes** (the muscle). Here’s a breakdown of the key components and how they work together.

---

## Table of Contents
- [Control Plane (The Command Center)](#control-plane-the-command-center)
  - [kube-apiserver](#1-kube-apiserver)
  - [etcd](#2-etcd)
  - [kube-scheduler](#3-kube-scheduler)
  - [kube-controller-manager](#4-kube-controller-manager)
  - [cloud-controller-manager (Optional)](#5-cloud-controller-manager-optional)
- [Worker Node Components (The Muscle)](#worker-node-components-the-muscle)
  - [kubelet](#1-kubelet)
  - [container runtime](#2-container-runtime)
  - [kube-proxy](#3-kube-proxy)
- [Cluster Communication Flow](#cluster-communication-flow)
- [TL;DR for Interview](#tldr-for-interview)

---

## 🚨 Control Plane (The Command Center)

Manages the overall state of the cluster.

### 1. kube-apiserver
- 📍 Location: Control Plane
- 🧠 Role: Front door of the cluster (API gateway)
- 🧬 Function:
  - Validates and processes REST requests (e.g. kubectl)
  - Authenticates/authorizes access
  - Persists cluster state to etcd
  - Stateless — can run multiple replicas

---

### 2. etcd
- 📍 Location: Control Plane
- 🧠 Role: Cluster’s key-value **memory**
- 🧬 Function:
  - Stores all cluster state/config (nodes, pods, secrets, etc.)
  - Supports snapshots for disaster recovery
  - Highly available and distributed

---

### 3. kube-scheduler
- 📍 Location: Control Plane
- 🧠 Role: Pod-to-node **matchmaker**
- 🧬 Function:
  - Watches for unassigned pods
  - Binds them to nodes based on:
    - Resource availability
    - Taints/tolerations
    - Affinities
    - Constraints

---

### 4. kube-controller-manager
- 📍 Location: Control Plane
- 🧠 Role: Runs background **controllers**
- 🧬 Function:
  - Includes:
    - Node controller
    - ReplicaSet controller
    - Job controller
    - Endpoint controller
  - Continuously reconciles actual state with desired state

---

### 5. cloud-controller-manager *(Optional)*
- 📍 Location: Control Plane (cloud only)
- 🧠 Role: Cloud provider **bridge**
- 🧬 Function:
  - Manages:
    - Load balancers
    - Node lifecycle
    - Storage volumes
  - Not used for bare metal

---

## Worker Node Components (The Muscle)

Each node runs these components to host and manage your actual workloads.

### 1. kubelet
- 📍 Location: Each worker node
- 🧠 Role: Node’s **agent**
- 🧬 Function:
  - Talks to API server
  - Pulls PodSpecs
  - Launches containers via runtime
  - Reports node and pod health/status

---

### 2. container runtime
- 📍 Location: Each node
- 🧠 Role: **Container engine**
- 🧬 Function:
  - Pulls images
  - Starts/stops containers
  - Examples:
    - `containerd`
    - `CRI-O`
    - (Previously Docker)

---

### 3. kube-proxy
- 📍 Location: Each node
- 🧠 Role: **Traffic router**
- 🧬 Function:
  - Manages iptables or IPVS rules
  - Enables service-to-pod communication
  - Supports ClusterIP, NodePort, LoadBalancer

---

## 🧭 Cluster Communication Flow

1. `kubectl apply` → hits `kube-apiserver`
2. `kube-apiserver` writes state to `etcd`
3. Controllers see change → create resources
4. `kube-scheduler` assigns pods to nodes
5. `kubelet` pulls image, starts container
6. `kube-proxy` routes service traffic to correct pod

---

## TL;DR for Interview

> The **Control Plane** manages the cluster using `kube-apiserver`, `etcd`, `scheduler`, and `controllers`.  
> The **Worker Nodes** run containers using `kubelet`, `containerd`, and `kube-proxy`.  
> The `API Server` is the hub of all communication. The system continuously reconciles the **desired state** with the **current state**.


