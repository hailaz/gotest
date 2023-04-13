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
		latestVersion=$$GITHUB_REF_NAME; \
		updateMainModule="go get -v github.com/hailaz/gotest/v2@$$GITHUB_REF_NAME"; \
	else \
		latestVersion=latest; \
		updateMainModule="go get -u -v github.com/hailaz/gotest/v2"; \
	fi; \
	echo "$$goGetCMD"; \
	for file in ${files}; do \
		goModPath=$$(dirname $$file); \
		if [[ $$goModPath =~ "./contrib" ]]; then \
			echo ""; \
			echo "processing dir: $$goModPath"; \
			cd $$goModPath; \
			go mod tidy; \
			go list -f "{{if and (not .Indirect) (not .Main)}}{{.Path}}@$$latestVersion{{end}}" -m all | grep contrib | xargs -L1 go get -v ; \
			$$updateMainModule; \
			go mod tidy; \
			cd -; \
		fi; \
	done

# make version to=v2.0.40-rc
version:
	$(eval files=$(shell find . -name go.mod))
	@set -e; \
	newVersion=$(to); \
	echo "New version is $$newVersion"; \
	echo "package gotest" > version.go; \
	echo "" >> version.go; \
	echo "const (" >> version.go; \
	echo -e "\t// VERSION is the current GoFrame version." >> version.go; \
	echo -e "\tVERSION = \"$$newVersion\"" >> version.go; \
	echo ")" >> version.go; \
	if [[ $$newVersion =~ "v" ]]; then \
		latestVersion=$$newVersion; \
		updateMainModule="go get -v github.com/hailaz/gotest/v2@$$newVersion"; \
	else \
		latestVersion=latest; \
		updateMainModule="go get -u -v github.com/hailaz/gotest/v2"; \
	fi; \
	echo "$$goGetCMD"; \
	for file in ${files}; do \
		goModPath=$$(dirname $$file); \
		if [[ $$goModPath =~ "./contrib" ]]; then \
			echo ""; \
			echo "processing dir: $$goModPath"; \
			cd $$goModPath; \
			go mod tidy; \
			go list -f "{{if and (not .Indirect) (not .Main)}}{{.Path}}@$$latestVersion{{end}}" -m all | grep contrib | xargs -L1 go get -v ; \
			$$updateMainModule; \
			go mod tidy; \
			cd -; \
		fi; \
	done
