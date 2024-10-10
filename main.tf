terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

resource "proxmox_vm_qemu" "vm-demo" {
    name = "vm-demo"
    target_node = "proxmox"

    # The template name to clone this vm from
    clone = "ubuntu-template"
    full_clone = true

    ciuser = var.ci_user
    cipassword = var.ci_password
    sshkeys = file(var.ci_ssh_public_key)

    # Activate QEMU agent for this VM
    agent = 1
    cores = 1
    memory = 1024
    os_type = "cloud-init"
    bootdisk = "scsi0"
    scsihw = "virtio-scsi-pci"

    # Setup the disk
    disks {
        ide {
            ide0 {
                cloudinit {
                    storage = "local"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size    = 10
                    storage = "local"
                }
            }
        }
    }

    # Setup the network interface
    network {
        model = "virtio"
        bridge = "vmbr0"
    }

    boot = "order=scsi0"
    ipconfig0 = "ip=dhcp"
    
    lifecycle {
    ignore_changes = [ 
      network
     ]
  }
}