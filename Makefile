SHELL := /bin/bash

.PHONY: tidy
tidy:
	$(eval files=$(shell find . -name go.mod))
	@set -e; \
	for file in ${files}; do \
		goModPath=$$(dirname $$file); \
		cd $$goModPath; \
		go mod tidy; \
		cd -; \
	done

.PHONY: lint
lint:
	golangci-lint run

gftidy:
	$(eval files=$(shell find . -name go.mod))
	@set -e; \
	if [[ $$GITHUB_REF_NAME =~ "v" ]]; then \
		latestTag="@$$GITHUB_REF_NAME"; \
	else \
		latestTag="@latest"; \
	fi; \
	echo "$$latestTag"; \
	for file in ${files}; do \
		goModPath=$$(dirname $$file); \
		if [[ $$goModPath =~ "./contrib" ]]; then \
			echo ""; \
			echo "processing dir: $$goModPath"; \
			cd $$goModPath; \
			go get github.com/hailaz/gotest/v2$$latestTag; \
			go mod tidy; \
			cd -; \
		fi; \
	done