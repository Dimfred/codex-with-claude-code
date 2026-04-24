SHELL := /bin/bash
all: help

############################################################################
# APP
run: ## run litellm cc proxy
	uv run litellm --config config.yaml

login: ## run example request, which will force you to login (make run first, see what happens in run)
	source .env && curl http://localhost:4000/v1/responses \
		-H "Content-Type: application/json" \
		-H "Authorization: Bearer $$LITELLM_MASTER_KEY" \
		-d '{"model": "chatgpt/gpt-5.3-codex", "input": [{"role": "user", "content": "hello"}]}'

#########################################################################
# HELP
help: ## print this help
	@awk '/^##+$$/ { \
		getline; \
		if ($$0 ~ /^# /) { \
			gsub(/^# /, ""); \
			printf "\n\033[1;34m%s\033[0m\n", $$0; \
		} \
	} \
	/^[a-zA-Z0-9_-]+:.*?## / { \
		split($$0, a, ":.*?## "); \
		printf "  \033[32m%-28s\033[0m %s\n", a[1], a[2]; \
	}' $(MAKEFILE_LIST)
