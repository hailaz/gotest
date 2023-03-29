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
	if [[ $$GITHUB_REF_NAME =~ "v" ]] ; then \
		latestTag="@$$GITHUB_REF_NAME"; \
	else \
		latestTag="@latest"; \
	fi ; \
	for file in ${files}; do \
		goModPath=$$(dirname $$file); \
		echo "Processing dir: $$goModPath"; \
		if [[ $$goModPath =~ ".git" || $$goModPath == "." ]]; then \
			echo "Skip path"; \
		elif [[ $$goModPath =~ "./cmd/gf" || $$goModPath =~ "./example" ]]; then \
			echo "Skip path"; \
		else \
			cd $$goModPath; \
			go get github.com/hailaz/gotest/v2$$latestTag; \
			go mod tidy; \
			cd -; \
		fi \
	done