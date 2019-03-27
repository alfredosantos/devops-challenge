#!make
COMPONENT_NAME=devops-challenge
componentVersion=`cat component_version`
LOCALNAME=`echo $USERNAME`
branch := $(git branch | grep \* | cut -d ' ' -f2)
NAME=${CI_USER_NAME:-"${USERNAME}"}
EMAIL=${CI_USER_EMAIL:-local@gmail.com}

commit=`git rev-parse --short HEAD`
built_at=`date +%FT%T%z`
built_by=`users`
built_on=`hostname`

vagrant_start:
	vagrant up

vagrant_destroy:
	vagrant destroy
	rm -rf  .vagrant/machines/devops-challenge1

build_go:
	cd devops-challenge
	go build -o build/main src/main.go
	# go build -ldflags "-X main.commit $${commit} -X main.builtAt $$built_at -X main.builtBy $$built_by -X main.builtOn $$built_on" -o build/main src/main.go

docker_build:
	componentVersion=$${current_version}
	git config --global user.name ${NAME:-"${USERNAME}"}
	git config --global user.email ${EMAIL:-"${USERNAME}"@gmail.com}
	git config --global commit.template .gitmessage
	git remote set-url origin https://github.com/hbombonato/${COMPONENT_NAME}.git
	sudo docker build -t "${COMPONENT_NAME}:${componentVersion}" .
	sudo docker tag "${COMPONENT_NAME}:${componentVersion}" "${COMPONENT_NAME}:latest"
	# git add .
	# git tag -a "v${componentVersion}" -m "v${componentVersion}"
	sed -E "1,/GOAPP_VERSION:.*/ s/GOAPP_VERSION:.*/GOAPP_VERSION:\ ${componentVersion}/g" automation/group_vars/dev.yml > automation/group_vars/dev.yml.tmp
	mv -vf automation/group_vars/dev.yml.tmp automation/group_vars/dev.yml
	echo "Setting version from ${componentVersion}"
	python increase-version.py component_version
	echo "Next version ${componentVersion}"
	# git commit -F .gitmessage
	# git push origin ${branch} --tags
