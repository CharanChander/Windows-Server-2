
# Windows Server II - Vagrant template
#  2024-2025
# ------------------------------------
#                                      
# This is the Vagrantfile for the assignment of Windows Server II - 2024-2025. 
# The setup consists of 2 Windows Server machines (no GUI) and 1 Windows 10 client.
#
# Use `vagrant up` to bring up the environment, 
#   or `vagrant reload` to redeploy the environment after changing this file.
#
# You are allowed to modify this file as needed.
# However, you are not allowed to use any other vagrant boxes than the ones used in this file:
# - Windows Server 2022 core (no GUI): gusztavvargadr/windows-server-2022-standard-core
# - Windows 10 Enterprise 22H2: gusztavvargadr/windows-10-22h2-enterprise
# Each VM has 2 network interfaces:
# - first adapter in (default) NAT mode, for internet access + vagrant
# - second adapter connected to a (private) Host-Only network (no IP configuration done)
# Use PowerShell scripts to configure the second NIC interfaces, 
#   and to install and configure the required software.

Vagrant.configure("2") do |config|
  # Server 1
  config.vm.define "server1" do |server1|
    # This is the base image for the VM - do not change this!
    server1.vm.box = "gusztavvargadr/windows-server-2022-standard-core"
    # Connect the second adapter to an internal network, do not configure IP (the provided IP is just a place holder)
    server1.vm.network "private_network", ip: "192.168.24.10", auto_config: false
    # Set the host name of the VM
    server1.vm.hostname = "server1"
    # VirtualBox specific configuration
    server1.vm.provider "virtualbox" do |vb|
      # VirtualBox Display Name
      vb.name = "server1"
      # VirtualBox Group
      vb.customize ["modifyvm", :id, "--groups", "/WS2"]
      # 1GB vRAM
      vb.memory = "2048"
      # 1vCPU
      vb.cpus = "4"
    end
  end

  # Server 2
  config.vm.define "server2" do |server2|
    server2.vm.box = "gusztavvargadr/windows-server-2022-standard-core"
    server2.vm.network "private_network", ip: "192.168.24.11", auto_config: false
    server2.vm.hostname = "server2"
    server2.vm.provider "virtualbox" do |vb|
      vb.name = "server2"
      vb.customize ["modifyvm", :id, "--groups", "/WS2"]
      vb.memory = "2048"
      vb.cpus = "4"
      vb.customize ["storageattach", :id, "--storagectl", "IDE Controller",
                  "--port", "1", "--device", "0", "--type", "dvddrive",
                  "--medium", "/home/charanchander/Documents/ISO's/MSQL Server/en_sql_server_2019_standard_x64_dvd_814b57aa.iso"]
    end
  end

  # Client
  config.vm.define "client" do |client|
    client.vm.box = "gusztavvargadr/windows-10-22h2-enterprise"
    client.vm.network "private_network", ip: "192.168.24.12", auto_config: false
    client.vm.hostname = "client"
    client.vm.provider "virtualbox" do |vb|
      vb.name = "client"
      vb.customize ["modifyvm", :id, "--groups", "/WS2"]
      vb.memory = "4096"
      vb.cpus = "4"
    end
  end
end
  