# Vagrantfile for a generic white-label VM

echo "Vagramtfile Whitelabel"

Vagrant.configure("2") do |config|
  # Customize the base box (OS)
  config.vm.box = "ubuntu/bionic64" # Replace with any base box, e.g., "centos/7"

  # Set the VM's hostname (optional)
  config.vm.hostname = "whitelabel-vm"

  # Network configuration
  #config.vm.network "private_network", type: "dhcp" # Or use static IP, e.g., "ip: '192.168.33.10'" 
  config.vm.network "forwarded_port", guest: 80, host: 8080 # Port forwarding example

  # Provider-specific configuration
  config.vm.provider "virtualbox" do |vb|
    vb.name = "whitelabel-vm" # Name of the VM in VirtualBox
    vb.memory = "2048" # Memory size (2 GB) 1024 -> 1GBs, 2048 -> 2 GBs, 4096 -> 4 GBs ,8192 -> 8 GBs, 16384 -> 16 GBs
    vb.cpus = 2        # Number of CPU cores
    vb.customize ["modifyvm", :id, "--vram", "64"] # Video memory (64 MB) 64 or 128
  end

  # Synced folder (host to guest)
  config.vm.synced_folder "./data", "/vagrant_data", type: "rsync" # Type can be nfs, smb, etc.

  # Provisioning with shell script (optional)
  config.vm.provision "shell", inline: <<-SHELL
    echo "Provisioning the VM..."
    apt-get update
    apt-get install -y apache2
  SHELL

end
