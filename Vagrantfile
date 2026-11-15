
Vagrant.configure("2") do |config|
  config.vm.box = "lubuntu-base"

  {
    "namenode"  => "192.168.56.120",
    "datanode1" => "192.168.56.121",
    "datanode2" => "192.168.56.122"
  }.each do |name, ip|
    config.vm.define name do |node|
      node.vm.hostname = name
      node.vm.network "private_network", ip: ip

      node.vm.provider "virtualbox" do |vb|
        vb.name = name
        vb.memory = 2048
        vb.cpus = 2
        vb.customize ["modifyvm", :id, "--vram", "25"]
      end
    end
  end
end
