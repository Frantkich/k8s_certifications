resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "client-vm"
  resource_group_name             = var.rg_name
  location                        = var.rg_location
  size                            = "Standard_DS1_v2"
  admin_username                  = "adminuser"
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.nic.id]
  
  admin_ssh_key {
    username   = "adminuser"
    public_key = azurerm_ssh_public_key.ssh_key_client.public_key
  }

  os_disk {
    name                 = "client-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
#!/bin/bash
# Add private key to connect to K8s master
echo "${tls_private_key.ssh_key_k8s.private_key_openssh}" > /home/adminuser/.ssh/id_rsa
cp /home/adminuser/.ssh/id_rsa /root/.ssh/id_rsa
chmod 600 /root/.ssh/id_rsa
chown adminuser:adminuser /home/adminuser/.ssh/id_rsa
chmod 600 /home/adminuser/.ssh/id_rsa
mkdir -p /home/adminuser/.kube

# Install dependencies
apt-get update && apt-get install -y apt-transport-https bash-completion
## Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
## Configure bash
echo 'alias k=kubectl' >> /home/adminuser/.bashrc
echo 'complete -F __start_kubectl k' >> /home/adminuser/.bashrc
echo "source <(kubectl completion bash)" >> /home/adminuser/.bashrc
## Helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | tee /etc/apt/sources.list.d/helm-stable-debian.list
apt-get update &&  apt-get install -y helm 

echo "10.0.128.100 k8scp" | tee -a /etc/hosts
ssh -o StrictHostKeyChecking=no adminuser@10.0.128.100 'echo "127.0.0.1 k8scp" | sudo tee -a /etc/hosts'
ssh -o StrictHostKeyChecking=no adminuser@10.0.128.200 'echo "10.0.128.100 k8scp" | sudo tee -a /etc/hosts'

ssh adminuser@10.0.128.100 'sudo kubeadm init --control-plane-endpoint=k8scp:6443 --upload-certs' 

ssh adminuser@10.0.128.100 'sudo cp /etc/kubernetes/admin.conf /home/adminuser/config && sudo chown adminuser:adminuser /home/adminuser/config && sudo chmod 600 /home/adminuser/config'
scp -o StrictHostKeyChecking=no adminuser@10.0.128.100:/home/adminuser/config /home/adminuser/.kube/config
chown -R adminuser:adminuser /home/adminuser/.kube
| tail -2  | tr -d "\\\n" | tee /tmp/kubeadm_join.sh
ssh adminuser@10.0.128.200 sudo "$(cat /tmp/kubeadm_join.sh)"

# Install Cilium via Helm
helm repo add cilium https://helm.cilium.io/
helm repo update
helm install cilium cilium/cilium --namespace kube-system
EOF
  )
  
  depends_on = [
    module.vms_cp_node,
    module.vms_worker_node
  ]
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "vm_shutdown" {
  virtual_machine_id = azurerm_linux_virtual_machine.vm.id
  location           = var.rg_location
  enabled            = true

  daily_recurrence_time = "2000"
  timezone              = "Central Europe Standard Time"

  notification_settings {
    enabled = false
  }
}
