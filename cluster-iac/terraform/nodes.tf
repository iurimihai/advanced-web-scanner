resource "proxmox_vm_qemu" "bastion" {
    name = "kube-bastion"
    vmid = 909

    target_node = var.target_node
    # The destination resource pool for the new VM
    pool = var.pool
    # The template name to clone this vm from
    clone = var.qemu_template
    # Activate QEMU agent for this VM
    agent = 1
    onboot = true

    vga {
        type = "serial0"
        # memory = 4
    }

    serial {
        id = 0
        type = "socket"
    }

    os_type = "cloud-init"
    cpu_type = "host"
    scsihw = "virtio-scsi-pci"

    cores = var.bastion.cores
    sockets = var.bastion.sockets
    memory = var.bastion.memory

    # Setup the disk
    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = "sas-nas"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size = var.bastion.disk
                    storage = "sas-nas"
                    # storage_type = "lvm"
                    # iothread = true
                    # discard = true
                }
            }
        }
    }

    boot = "order=scsi0"

    network {
        id = 0
        model = "virtio"
        bridge = "vmbr0"
        # tag = 256
    }
    network {
        id = 1
        model = "virtio"
        bridge = "vmbr1"
        # tag = 256
    }
    ipconfig0 = "ip=${var.bastion.ip["ipconfig0"]}/24,gw=192.168.1.1"
    ipconfig1 = "ip=${var.bastion.ip["ipconfig1"]}/24,gw=10.0.1.1"

    ciuser = var.ciuser
    cipassword = var.cipassword
    ciupgrade = true

    sshkeys = file(var.ssh_file_path)

    lifecycle {
        # precondition {
        #     condition = length(proxmox_vm_qemu.controllers.network) > 0
        #     error_message = "You need to define at least one network interface"
        # }
        precondition {
            condition = var.ciuser != "" && var.cipassword != ""
            error_message = "You need to define a cloud-init user and password"
        }
    #   replace_triggered_by = [ proxmox_vm_qemu.controllers.ciuser,
    #                             proxmox_vm_qemu.controllers.cipassword,
    #                             proxmox_vm_qemu.controllers.sshkeys ]
    }
}

resource "proxmox_vm_qemu" "controller" {
    count = length(var.controllers)
    name = "kube-controller-${count.index + 1}"
    vmid = 910 + count.index

    target_node = var.target_node
    # The destination resource pool for the new VM
    pool = var.pool
    # The template name to clone this vm from
    clone = var.qemu_template
    # Activate QEMU agent for this VM
    agent = 1
    onboot = true

    vga {
        type = "serial0"
        # memory = 4
    }

    os_type = "cloud-init"
    cpu_type = "host"
    scsihw = "virtio-scsi-pci"

    cores = var.controllers[count.index].cores
    sockets = var.controllers[count.index].sockets
    memory = var.controllers[count.index].memory

    # Setup the disk
    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = "sas-nas"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size = var.controllers[count.index].disk
                    storage = "sas-nas"
                    # storage_type = "lvm"
                    # iothread = true
                    # discard = true
                }
            }
        }
    }

    boot = "order=scsi0"

    network {
        id = 0
        model = "virtio"
        bridge = "vmbr1"
        # tag = 256
    }

    ipconfig0 = "ip=${var.controllers[count.index].ip}/24,gw=10.0.1.1"

    ciuser = var.ciuser
    cipassword = var.cipassword
    ciupgrade = true

    sshkeys = file(var.ssh_file_path)

    lifecycle {
        # precondition {
        #     condition = length(proxmox_vm_qemu.controllers.network) > 0
        #     error_message = "You need to define at least one network interface"
        # }
        precondition {
            condition = length(var.controllers) >= 2
            error_message = "You need to define at least 2 controller nodes"
        }
        precondition {
            condition = length(var.controllers) <= 5
            error_message = "Maximum 5 controller nodes are supported"
        }
        precondition {
            condition = var.ciuser != "" && var.cipassword != ""
            error_message = "You need to define a cloud-init user and password"
        }
    #   replace_triggered_by = [ proxmox_vm_qemu.controllers.ciuser,
    #                             proxmox_vm_qemu.controllers.cipassword,
    #                             proxmox_vm_qemu.controllers.sshkeys ]
    }
}

resource "proxmox_vm_qemu" "worker" {
    count = length(var.workers)
    name = "kube-worker-${count.index + 1}"
    vmid = 915 + count.index

    target_node = var.target_node
    # The destination resource pool for the new VM
    pool = var.pool
    # The template name to clone this vm from
    clone = var.qemu_template
    # Activate QEMU agent for this VM
    agent = 1
    onboot = true

    vga {
        type = "serial0"
        # memory = 4
    }

    os_type = "cloud-init"
    cpu_type = "host"
    scsihw = "virtio-scsi-pci"

    cores = var.workers[count.index].cores
    sockets = var.workers[count.index].sockets
    memory = var.workers[count.index].memory

    # Setup the disk
    disks {
        ide {
            ide2 {
                cloudinit {
                    storage = "sas-nas"
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size = var.workers[count.index].disk
                    storage = "sas-nas"
                    # storage_type = "lvm"
                    # iothread = true
                    # discard = true
                }
            }
        }
    }

    boot = "order=scsi0"

    network {
        id = 0
        model = "virtio"
        bridge = "vmbr1"
        # tag = 256
    }

    ipconfig0 = "ip=${var.workers[count.index].ip}/24,gw=10.0.1.1"

    ciuser = var.ciuser
    cipassword = var.cipassword
    ciupgrade = true

    sshkeys = file(var.ssh_file_path)

    lifecycle {
        # precondition {
        #     condition = length(proxmox_vm_qemu.controllers.network) > 0
        #     error_message = "You need to define at least one network interface"
        # }

        precondition {
            condition = var.ciuser != "" && var.cipassword != ""
            error_message = "You need to define a cloud-init user and password"
        }
        precondition {
            condition = length(var.workers) >= 2
            error_message = "You need to define at least 2 worker node"
        }
    #   replace_triggered_by = [ proxmox_vm_qemu.controllers.ciuser,
    #                             proxmox_vm_qemu.controllers.cipassword,
    #                             proxmox_vm_qemu.controllers.sshkeys ]
    }
}

output "bastion_name_ips" {
  value = { "${proxmox_vm_qemu.bastion.name}" = [
      proxmox_vm_qemu.bastion.ipconfig0,
      proxmox_vm_qemu.bastion.ipconfig1
    ]
  }
}

output "ctrl_name_ip" {
    value = [
        for i in range(length(proxmox_vm_qemu.controller)) :
        "${proxmox_vm_qemu.controller[i].name} - ${proxmox_vm_qemu.controller[i].ipconfig0}"
    ]
}

output "wrk_name_ip" {
    value = [
        for i in range(length(proxmox_vm_qemu.worker)) :
        "${proxmox_vm_qemu.worker[i].name} - ${proxmox_vm_qemu.worker[i].ipconfig0}"
    ]
}