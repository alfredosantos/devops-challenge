domain   = 'dockerlab.net'

nodes = [
  { :hostname => 'devops-challenge1', :box => 'ubuntu/bionic64' },
  # { :hostname => 'devops-challenge2',  :ip => '192.168.100.11', :adapter => 1, :box => 'ubuntu/bionic64' },  
]

Vagrant.configure("2") do |config|
  nodes.each do |node|
    config.vm.define node[:hostname] do |nodeconfig|
      nodeconfig.vm.box = node[:box]
      nodeconfig.vm.hostname = node[:hostname] + ".box"
      # nodeconfig.vm.network :private_network, ip: node[:ip], :auto_config => false
      nodeconfig.vm.network :public_network, :bridge => 'wlp3s0', :auto_network => true

      memory = node[:ram] ? node[:ram] : 1024;
      nodeconfig.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--cpuexecutioncap", "40",
          "--memory", memory.to_s,
	        "--nicpromisc2", "allow-all"
        ]
config.vm.provision "shell", inline: <<-SHELL
      sudo timedatectl set-timezone America/Sao_Paulo
      sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
      && sudo chmod +x /usr/local/bin/docker-compose
      sudo add-apt-repository ppa:gophers/archive
      sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
      sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
      sudo apt-add-repository -y ppa:ansible/ansible
      sudo apt-get -y update
      sudo apt-get install -y software-properties-common git docker-ce ansible make automake golang python-pip
      sudo pip install docker
      sudo pip install docker-compose
      git config --global push.default simple
      git config --global user.name "DevOps Challenge"
      git config --global user.email herlix@gmail.com
      [ -d "devops-challenge" ]&& cd devops-challenge \
      || git pull 'https://github.com/hbombonato/devops-challenge.git' \
      || git clone 'https://github.com/hbombonato/devops-challenge.git'
      cd /home/vagrant/devops-challenge && make build_go
      cd /home/vagrant/devops-challenge && make docker_build
      cd /home/vagrant/devops-challenge && ansible-playbook -i automation/inventory/hosts automation/devops.yml --ssh-extra-args=" -o ControlMaster=auto -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ControlPersist=60s"
      SHELL
      end
    end
  end
end 