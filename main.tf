# main.tf
module "virtual_machine" {
  source = "github.com/lunarops/terraform-proxmox-vm-qemu"
  # source                   = "../terraform-modules/terraform-proxmox-vm-qemu"
  proxmox_api_url          = var.proxmox_api_url
  proxmox_api_token_id     = var.proxmox_api_token_id
  proxmox_api_token_secret = var.proxmox_api_token_secret
  virtual_machines         = local.machines
}

# locals {
#   clone           = "tmpl-ubuntu-server-jammy"
#   tags_masters    = "kubernetes, k8s, k3s, master, control-plane"
#   tags_workers    = "kubernetes, k8s, k3s, worker"
#   public_ssh_keys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqCih42F1ypvB4fxgX8zAfR7CxLjynrXzxLFQnZVhkErDuxn12UMAvpplFqGjHhnP28EnXTa0w7r+qIVI1jNAjHG3KnbLRAnQSnoSRn5T/0c81wdMBDOfWxF2sQGihEu33HvqNOdMAd5u47dWj8SD/Jx5tV44qIfIb6BSTGT3bFst5kBWoPgPZSbES+RDrBL5YN8AUV6tGbbHP7Yv4xc1u/HndrC6TLFyxq3ntDTBXcet78QUdZQ0FIeQp5PWLCJRT698FTiZ5bxIGgME1W7bF371aJuNuevhKMyQl0lULem5w5bDBh2fX2uZffkfaCKpT7jzhfO47vLiJ7I8hBjkvDTz9vsEjGCU/Yu6BlQaIE75eD2ZeYE544J+dIlPQtx0DFPT70gpmJF6OkAPNrOXoWeXw2PzQ9C05T09vmNVxOeznLxt7TkqNW5Z3Wgqvezk/YUZjXlc23ke8y/vt4GOvwDZVAAl4b4ddUYRmHRtHxdhqRFA7j53dPZSPU4xrdlrvW4MjiK4x3u9SCWssDfDsm+JMjuAnYX6FRd2CyQJ4D/cvKxPWXwevJIGh4tZtDl0gchjEJyLhf9fHVuVlGaFRcApvs2QZ2g906JOnXWPD8RoKlToqjN/pZiYZmK9hZvPkD6faBkI+d08/gC1xJ3B08nl2nZZqCJmv28ufNNcedQ== dalekurt@lunarops.io"
# }

# Masters
# resource "proxmox_vm_qemu" "master" {

#   count = 1

#   # VM General Settings
#   target_node = "pve0"
#   vmid        = "301${count.index}"
#   name        = "master-${count.index + 1}.int.lunarops.net"
#   desc        = "Kubernetes master node"

#   # VM Advanced General Settings
#   onboot = true

#   # VM OS Settings
#   clone      = local.clone
#   full_clone = "true"

#   # VM System Settings
#   agent = 1

#   # VM CPU Settings
#   cores   = 2
#   sockets = 1
#   cpu     = "host"

#   # VM Memory Settings
#   memory = 4096

#   # VM Network Settings
#   network {
#     tag    = 30      #var.vlan_num
#     bridge = "vmbr0" #var.bridge
#     model  = "virtio"
#   }

#   lifecycle {
#     ignore_changes = [
#       network,
#     ]
#   }

#   # VM Cloud-Init Settings
#   os_type = "cloud-init"

#   scsihw   = "virtio-scsi-pci"
#   bootdisk = "scsi0"

#   # (Optional) IP Address and Gateway
#   ipconfig0    = "ip=172.16.30.1${count.index + 1}/24,gw=172.16.30.1"
#   nameserver   = "172.16.30.1"
#   searchdomain = "int.lunarops.net"
#   # (Optional) Default User
#   ciuser = "ubuntu"

#   # (Optional) Add your SSH KEY
#   sshkeys = <<-EOF
#   ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqCih42F1ypvB4fxgX8zAfR7CxLjynrXzxLFQnZVhkErDuxn12UMAvpplFqGjHhnP28EnXTa0w7r+qIVI1jNAjHG3KnbLRAnQSnoSRn5T/0c81wdMBDOfWxF2sQGihEu33HvqNOdMAd5u47dWj8SD/Jx5tV44qIfIb6BSTGT3bFst5kBWoPgPZSbES+RDrBL5YN8AUV6tGbbHP7Yv4xc1u/HndrC6TLFyxq3ntDTBXcet78QUdZQ0FIeQp5PWLCJRT698FTiZ5bxIGgME1W7bF371aJuNuevhKMyQl0lULem5w5bDBh2fX2uZffkfaCKpT7jzhfO47vLiJ7I8hBjkvDTz9vsEjGCU/Yu6BlQaIE75eD2ZeYE544J+dIlPQtx0DFPT70gpmJF6OkAPNrOXoWeXw2PzQ9C05T09vmNVxOeznLxt7TkqNW5Z3Wgqvezk/YUZjXlc23ke8y/vt4GOvwDZVAAl4b4ddUYRmHRtHxdhqRFA7j53dPZSPU4xrdlrvW4MjiK4x3u9SCWssDfDsm+JMjuAnYX6FRd2CyQJ4D/cvKxPWXwevJIGh4tZtDl0gchjEJyLhf9fHVuVlGaFRcApvs2QZ2g906JOnXWPD8RoKlToqjN/pZiYZmK9hZvPkD6faBkI+d08/gC1xJ3B08nl2nZZqCJmv28ufNNcedQ== dalekurt@lunarops.io
#   EOF

#   tags = local.tags_masters
# }

# # Workers
# resource "proxmox_vm_qemu" "worker" {

#   count = 3

#   # VM General Settings
#   target_node = "pve0"
#   vmid        = "302${count.index + 1}"
#   name        = "worker-${count.index + 1}.int.lunarops.net"
#   desc        = "Kubernetes worker node"

#   # VM Advanced General Settings
#   onboot = true

#   # VM OS Settings
#   clone = local.clone

#   # VM System Settings
#   agent = 1

#   # VM CPU Settings
#   cores   = 2
#   sockets = 2
#   cpu     = "host"

#   # VM Memory Settings
#   memory = 8192

#   # VM Network Settings
#   network {
#     tag    = 30      #var.vlan_num
#     bridge = "vmbr0" #var.bridge
#     model  = "virtio"
#   }

#   lifecycle {
#     ignore_changes = [
#       network,
#     ]
#   }

#   # VM Cloud-Init Settings
#   os_type = "cloud-init"

#   # (Optional) IP Address and Gateway
#   ipconfig0    = "ip=172.16.30.2${count.index}/24,gw=172.16.30.1"
#   nameserver   = "172.16.30.1"
#   searchdomain = "int.lunarops.net"
#   # (Optional) Default User
#   ciuser = "ubuntu"

#   # (Optional) Add your SSH KEY
#   sshkeys = <<-EOF
#   ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCqCih42F1ypvB4fxgX8zAfR7CxLjynrXzxLFQnZVhkErDuxn12UMAvpplFqGjHhnP28EnXTa0w7r+qIVI1jNAjHG3KnbLRAnQSnoSRn5T/0c81wdMBDOfWxF2sQGihEu33HvqNOdMAd5u47dWj8SD/Jx5tV44qIfIb6BSTGT3bFst5kBWoPgPZSbES+RDrBL5YN8AUV6tGbbHP7Yv4xc1u/HndrC6TLFyxq3ntDTBXcet78QUdZQ0FIeQp5PWLCJRT698FTiZ5bxIGgME1W7bF371aJuNuevhKMyQl0lULem5w5bDBh2fX2uZffkfaCKpT7jzhfO47vLiJ7I8hBjkvDTz9vsEjGCU/Yu6BlQaIE75eD2ZeYE544J+dIlPQtx0DFPT70gpmJF6OkAPNrOXoWeXw2PzQ9C05T09vmNVxOeznLxt7TkqNW5Z3Wgqvezk/YUZjXlc23ke8y/vt4GOvwDZVAAl4b4ddUYRmHRtHxdhqRFA7j53dPZSPU4xrdlrvW4MjiK4x3u9SCWssDfDsm+JMjuAnYX6FRd2CyQJ4D/cvKxPWXwevJIGh4tZtDl0gchjEJyLhf9fHVuVlGaFRcApvs2QZ2g906JOnXWPD8RoKlToqjN/pZiYZmK9hZvPkD6faBkI+d08/gC1xJ3B08nl2nZZqCJmv28ufNNcedQ== dalekurt@lunarops.io
#   EOF

#   tags = local.tags_workers
# }
