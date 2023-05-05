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


# make version to=v2.0.40-rc
.PHONY: version
version:
	newVersion=$(to); \
	.github/workflows/version.sh ./contrib $$newVersion; 

# make cliversion to=v2.0.41
.PHONY: cliversion
cliversion:
	newVersion=$(to); \
	.github/workflows/version.sh ./cmd/gfly $$newVersion; 

