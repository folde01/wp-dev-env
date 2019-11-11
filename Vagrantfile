Vagrant.configure("2") do |config|
  config.vm.box = "comiq/dockerbox"

  # network settings
    config.vm.network "private_network", ip: "192.168.33.10"

  # folder settings
    config.vm.synced_folder "./docker-volumes/wordpress_db", "/home/vagrant/wordpress_db", :owner => "999", :group => "999"
    #config.vm.synced_folder "./docker-volumes/wordpress_files", "/home/vagrant/wordpress_files"
    config.vm.synced_folder "./docker-volumes/wordpress_files", "/home/vagrant/wordpress_files", :group => "33"
    config.vm.synced_folder "./docker-compose", "/home/vagrant/docker-compose"
end
