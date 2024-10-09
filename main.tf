terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "2.9.14"
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
  cloudinit_cdrom_storage = "local"
  
}