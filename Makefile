.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

######################################################################
# PING
######################################################################

.PHONY: ping
ping: # Ping CLAB Nodes - running in GCP
	ansible-playbook playbooks/ping.yml

######################################################################
# BUILD
######################################################################

.PHONY: build
build: ## Build CLAB Configs
	ansible-playbook playbooks/build.yml

######################################################################
# DEPLOY eAPI
######################################################################

.PHONY: deploy
deploy: ## Deploy CLAB Configs via eAPI
	ansible-playbook playbooks/deploy.yml
