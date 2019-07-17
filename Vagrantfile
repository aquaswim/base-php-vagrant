# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-18.04"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.56.111"
  config.vm.synced_folder "./data", "/vagrant_data"
  config.vm.hostname = "kibou.devbox"
  config.vm.post_up_message = "Welcome to kibou";
  config.vm.provider "virtualbox" do |vb|
   vb.memory = 512
   vb.cpus = 1
   vb.gui = false
  end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  
  # more https://www.vagrantup.com/docs/vagrantfile/
end
