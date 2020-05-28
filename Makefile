DOCKER_VOLUMES := /srv/docker-volumes

.PHONY: all help
.DEFAULT_GOAL := help

help:
	@echo -e "\033[31m[Important] \033[33mThis Makefile is add user in host. Also will assigned uid 1000 if it no assigned other user.\033[0m"
	@echo  "   https://documentation.wazuh.com/3.12/docker/container-usage.html#mount-storage-for-elastic-stack-components"
	@echo -e "\033[33mAlso make a directory $(DOCKER_VOLUMES).\033[0m"
	@echo -e "\n\033[32mCommand Usage:\033[0m make \033[36m[subCommand]\033[0m\n"
	@perl -lne ' /(.*):\s+?.*##\s+?(.*)/ and printf "%-s \033[36m%-30s\033[0m%s\n", "make", $$1, ": $$2"' $(MAKEFILE_LIST)

all: run ## This sub command is some runs it just between add_group and docker_compose. You can see the help. ($ make help <Enter>)

run: group \
	user \
	directories \
	owner_and_group \
	docker_compose

group: ## add a group if there is no gid 1000 assigned
	@if [ "x${shell sudo /usr/bin/grep 1000 /etc/group}" == "x" ];then\
		sudo groupadd -g 1000 elasticsearch ;\
	fi

user: ## add a user if there is no uid 1000 assigned
	@if [ "x${shell sudo /usr/bin/grep 1000 /etc/passwd}" == "x" ];then\
		sudo useradd -u 1000 -g 1000 -s /sbin/nologin elasticsearch ;\
	fi

directories: ## Make directories
	sudo mkdir -p $(DOCKER_VOLUMES)/{wazuh,elasticsearch}

owner_and_group: ## Control owner and group setting.
	sudo chown 1000:0 -R $(DOCKER_VOLUMES)/elasticsearch
	@echo "finish."
	@echo
	ls -l $(DOCKER_VOLUMES)/{wazuh,elasticsearch}

docker_compose: ## docker-compose up -d
	docker-compose up -d

docker_clean: ## Clean docker containers. The datastore are not erased. / $(DOCKER_VOLUMES)/{wazuh,elasticsearch}
	docker-compose stop && docker system prune -f
