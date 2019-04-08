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
  config.vm.box = "ubuntu/bionic64"

  config.vm.provider "virtualbox" do |vb|
  	vb.gui = true
    vb.memory = 4096
    vb.cpus = 2
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']

    ## TODO start the window at a reasonable size and resolution - can't get these to work
    #vb.customize 'post-boot', ["controlvm", :id, "setvideomodehint", "1440", "900", "32"]
    #vb.customize 'post-boot', ["controlvm", :id, "setscreenlayout", "1", "primary", "20", "20", "1440", "900", "32"]
  end

  # If we have one, share our .bashrc into the host
  if File.exist?("#{Dir.home}/.bashrc")
  	config.vm.provision "file", source: "#{Dir.home}/.bashrc", destination: ".bashrc"
  end

  # If we have some, share our dotfiles into the host
  if File.exist?("#{Dir.home}/dotfiles")
  	config.vm.synced_folder "#{Dir.home}/dotfiles", "/home/vagrant/dotfiles", mount_options: ["ro"]
  end

  # Use ansible to configure some useful tools into our development machine
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.galaxy_role_file = "requirements.yml"
  end

  # Restart the vm to start the gui
  config.vm.provision :reload
end