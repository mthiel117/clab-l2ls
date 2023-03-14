.PHONY: help
help: ## Display help message
	@grep -E '^[0-9a-zA-Z_-]+\.*[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

######################################################################
# PING
######################################################################

.PHONY: ping-clab
ping-clab: ## Ping CLAB Nodes - running in GCP
	ansible-playbook playbooks/ping.yml -i inventories/clab/inventory.yml -e "targets=CLAB_FABRIC"

######################################################################
# BUILD
######################################################################

.PHONY: build-clab
build-clab: ## Build CLAB Configs
	ansible-playbook playbooks/build.yml -i inventories/clab/inventory.yml -e "targets=CLAB_FABRIC"

######################################################################
# DEPLOY eAPI
######################################################################

.PHONY: deploy-clab
deploy-clab: ## Deploy CLAB Configs via eAPI
	ansible-playbook playbooks/deploy.yml -i inventories/clab/inventory.yml -e "targets=CLAB_FABRIC"
