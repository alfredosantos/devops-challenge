domain   = 'dockerlab.net'

nodes = [
  { :hostname => 'devops-challenge1',  :ip => '192.168.100.10', :adapter => 1, :box => 'ubuntu/bionic64' },
  # { :hostname => 'devops-challenge2',  :ip => '192.168.100.11', :adapter => 1, :box => 'ubuntu/bionic64' },  
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      # nodeconfig.vm.network :private_network, ip: node[:ip], :auto_config => false
      nodeconfig.vm.network :public_network

      memory = node[:ram] ? node[:ram] : 1024;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "40",
          "--memory", memory.to_s,
	        "--nicpromisc2", "allow-all"
        ]
config.vm.provision "shell", inline: <<-SHELL
      sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
      sudo apt-add-repository -y ppa:ansible/ansible
      sudo apt-get -y update
      sudo apt-get install -y software-properties-common git docker-ce ansible make automake
      git config --global push.default simple
      git config --global user.name "DevOps Challenge"
      git config --global user.email herlix@gmail.com
      [ -d "devops-challenge" ]&& cd devops-challenge \
      || git pull 'https://github.com/hbombonato/devops-challenge.git' \
      || git clone 'https://github.com/hbombonato/devops-challenge.git' \
      || cd devops-challenge
      make build_go
      make docker_build
      ansible-playbook -i automation/inventory/hosts automation/devops.yml --ssh-extra-args=" -o ControlMaster=auto -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ControlPersist=60s"
      SHELL
      end
    end
  end
end