# CKA Exams

## Ressources 

- Liste d'exercices dans le pdf `CKA_formation_exos` avec la correction dans le dossier `solution_exos`

- Pour creer un cluster sur le cloud et s'entrainer lancer le terraform dans `provision_env`

- Exam blanc disponible [ici](https://killer.sh/course/preview/e84d0e31-4fff-4c42-8afd-be1bdbc0d994) (killer.sh)
    - You can also get a extended access from your LF account [check this](https://killer.sh/faq) 

- Pour rappel seul ces OS sont viable pour l'exam
    - win10/11
    - ubuntu 20/22/24.04

- la liste des [docs autorisés](https://docs.linuxfoundation.org/tc-docs/certification/certification-resources-allowed#certified-kubernetes-administrator-cka-and-certified-kubernetes-application-developer-ckad) pendant l'exam

- [Tips and tricks](https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad) à lire absolument !!!



## Be Fast

do="--dry-run client -oyaml"

now="--force --grace-period 0"

alias kn='kubectl config set-context --current --namespace'

alias kapp='kubectl apply -f'

use `k create deploy` to create deploy or `k run` for pods 

`Ctrl-Z` pour mettre la commande en cours en arrière plan. `fg` pour la reprendre.

kubectl cheatsheet sur kubernetes.io

##  Contenu exam : 

20 taches en 2 heures.

Liste sujets triés par importance sur la note:

- 30% Cluster Architecture, Installation & Configuration
    - [x] Evaluate cluster and node logging
    - [x] Understand how to monitor applications
    - [x] Manage container stdout & stderr logs
    - [x] Troubleshoot application failure
    - [x] Troubleshoot cluster component failure
    - [x] Troubleshoot networking

- 25% Cluster Architecture, Installation & Configuration
    - [x] Manage role based access control (RBAC)
    - [x] Use Kubeadm to install a basic cluster
    - [x] Manage a highly-available Kubernetes cluster
    - [x] Provision underlying infrastructure to deploy a Kubernetes cluster
    - [x] Perform a version upgrade on a Kubernetes cluster using Kubeadm
    - [x] Implement etcd backup and restore

- 20% Services & Networking
    - [x] Understand host networking configuration on the cluster nodes
    - [x] Understand connectivity between Pods
    - [x] Understand ClusterIP, NodePort, LoadBalancer service types and endpoints
    - [x] Know how to use Ingress controllers and Ingress resources
    - [x] Know how to configure and use CoreDNS
    - [x] Choose an appropriate container network interface plugin

- 15% Workloads & Scheduling
    - [x] Understand deployments and how to perform rolling update and rollbacks
    - [x] Use ConfigMaps and Secrets to configure applications
    - [x] Know how to scale applications
    - [x] Understand the primitives used to create robust, self-healing, application deployments
    - [x] Understand how resource limits can affect Pod scheduling
    - [x] Awareness of manifest management and common templating tools

- 10% Storage
    - [x] Understand storage classes, persistent volumes
    - [x] Understand volume mode, access modes and reclaim policies for volumes
    - [x] Understand persistent volume claims primitive
    - [x] Know how to configure applications with persistent storage