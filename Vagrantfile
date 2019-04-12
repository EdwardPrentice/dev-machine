# Invoke some automatic plugin installation magic
# https://gist.github.com/EdwardPrentice/40d630d9776a270f19dfe93b427f1158
if ARGV[0] != 'plugin'
  required_plugins = ['vagrant-vbguest', 'vagrant-reload']         
  plugins_to_install = required_plugins.select { |plugin| not Vagrant.has_plugin? plugin }
  if not plugins_to_install.empty?
    puts "Installing plugins: #{plugins_to_install.join(' ')}"
    if system "vagrant plugin install #{plugins_to_install.join(' ')}"
      exec "vagrant #{ARGV.join(' ')}"
    else
      abort "Installation of one or more plugins has failed. Aborting."
    end
  end
end

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64" # officially published image

  config.vm.provider "virtualbox" do |vb|
  	vb.gui = true
    vb.memory = 4096
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vboxvga"]
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--vram", "128"]
    vb.customize ["modifyvm", :id, "--hwvirtex", "on"]
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']

    # We want to boot into full screen mode so the desktop renders nicely
    # TODO how to make this work? Does this need to be a terminal command to vbox?
    # vb.customize 'post-boot', ["controlvm", :id, "setvideomodehint", "2560", "1440", "32"]
    # vb.customize 'post-boot', ["controlvm", :id, "setscreenlayout", "1", "primary", "20", "20", "1440", "900", "32"]
  end

  # If we have one, share our .bashrc into the host
  if File.exist?("#{Dir.home}/.bashrc")
  	config.vm.provision "file", source: "#{Dir.home}/.bashrc", destination: ".bashrc"
  end

  # If we have some, share our dotfiles into the host
  if File.exist?("#{Dir.home}/dotfiles")
  	config.vm.synced_folder "#{Dir.home}/dotfiles", "/home/vagrant/dotfiles", mount_options: ["ro"]
  end

  # Can be run on it's own with `vagrant up --provision-with pre`
  config.vm.provision "pre", type: :ansible_local do |ansible|
    ansible.playbook = "pre-reboot-playbook.yml"
    ansible.galaxy_role_file = "requirements.yml"
  end

  # Restart the vm allow additional config once the the desktop environment has started
  # TODO is there a way to do all the config pre-reboot?
  config.vm.provision :reload

  # Now we want to boot into full screen mode so the desktop renders nicely
  # TODO how to make this work? Does this need to be a terminal command to vbox?
  # config.vm.provider "virtualbox" do |vb|
  #   vb.customize 'post-boot', ['controlvm', :id, "setvideomodehint", "2560", "1440", "32"]
  # end

  # Can be run on it's own with `vagrant up --provision-with post`
  config.vm.provision "post", type: :ansible_local do |ansible|
    ansible.playbook = "post-reboot-playbook.yml"
  end

  # Until this Vagrantfile can make the virtual box window larger, you should now make the desktop
  # window a reasonable size and run `vagrant reload` again for it to reload the desktop and conky
  # all at a decent size and resolution.

end