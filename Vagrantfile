Vagrant.configure("2")  do |config|
    # Every Vagrant virtual environment requires a box to build off of.
    config.vm.box = "precise64"
    config.vm.synced_folder '.', '/vagrant', :id => 'vagrant-root', :disabled => true
    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system.

    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    # Assign this VM to a host only network IP, allowing you to access it
    # via the IP.
    config.vm.network :private_network, ip: "192.168.50.91"
    config.vm.hostname = "d8.dev.se"

    config.vm.provider "virtualbox" do |v|
        v.name = config.vm.hostname
        v.customize ["modifyvm", :id, "--memory", "2048"]
        v.customize ["modifyvm", :id, "--cpus", "1"]
    end

    # Provisioning settings.
     config.vm.provision :puppet do |puppet|
       puppet.facter = {
        'drupal_root' => '/srv/www/d8/web'
       }
       puppet.manifests_path = "./"
       puppet.manifest_file = "manifests/manifest.pp"
       puppet.module_path = "./manifests/modules"
     end
    # config.vm.provision :shell do |shell|
    #   shell.inline = "drush dl drush-7.x-5.9 -y"
    # end

    #config.vm.provision :shell do |shell|
    #   shell.path = "script.sh"
    #end

    # The path to the platform
    config.vm.synced_folder "./", "/srv/www/d8", :nfs => true
end
