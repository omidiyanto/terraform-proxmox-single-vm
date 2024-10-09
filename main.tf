terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
  }
}

resource "proxmox_vm_qemu" "vm" {
  vmid = 250
  name = "demo-vm"
  target_node = "proxmox"

  clone = "ubuntu-jammy"
  full_clone = true

}