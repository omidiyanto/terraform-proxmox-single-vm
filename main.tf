terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

resource "proxmox_vm_qemu" "vm" {
  vmid = 200
  name = "demo-vm"
  target_node = "proxmox"
  
  clone = "ubuntu-template"
  full_clone = true

  os_type = "cloud-init"
  

  ciuser = var.ci_user
  cipassword = var.ci_password
  sshkeys = file(var.ci_ssh_public_key)

  cores = 1
  memory = 1024
  agent = 1

  bootdisk = "scsi0"
  scsihw = "virtio-scsi-pci"
  ipconfig0 = "ip=dhcp"

  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local"
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
    tag = "103"
  }

  lifecycle {
    ignore_changes = [ 
      network
     ]
  }
}