# generate_cka_env

Generate a Azure Cloud Service K8s cluster with cp and wk for the CKA formation.
The VMs are shutdown at 20h UTC+1

## Requirements:

- Install OpenTofu
- Install AzureCLi
- Log to Azure CLI: `az login`
- Create a `terraform.tfvars` to change, at least, define `subscription_id`
- generate a SSH rsa key to connect to the client (store here : `.\assets\ssh_keys\id_rsa(.pub)`)

## Setup

> tofu init

> tofu plan -out main.apply.tfplan

> tofu plan -destroy -out main.destroy.tfplan


## Create

> tofu apply main.apply.tfplan

To connect to the cluster, first you have to ssh into the client with the outputed command. And then you can interact with the api-server via kubectl.

(if kubectl can't connect to the cp logout/login)

```sh
adminuser@client-vm:~$ k get no
NAME      STATUS   ROLES           AGE   VERSION
cp-vm-0   Ready    control-plane   16m   v1.31.3
wk-vm-0   Ready    <none>          16m   v1.31.3
```

## Delete once done

Even if the VMs are shutdown automatically, it's better to delete them to avoid cost (eg. storage) 

> tofu apply main.destroy.tfplan
