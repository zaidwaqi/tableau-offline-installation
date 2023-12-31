Vagrant.configure("2") do |config|
  config.vm.box = "generic/centos8s"
  config.vm.synced_folder ".", "/vagrant", disabled: false

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of cup and memory on the VM:
    vb.cpus = "4"
    vb.memory = "16384"
  end

  config.vm.provision "shell", path: "scripts/install.sh"
end
