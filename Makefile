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
	rm -f go.work; \
	newVersion=$(to); \
	echo "The version will be set to $$newVersion"; \
	if [[ $$newVersion =~ ^v ]]; then \
		latestVersion=$$newVersion; \
		echo "package gotest" > version.go; \
		echo "" >> version.go; \
		echo "const (" >> version.go; \
		echo -e "\t// VERSION is the current GoFrame version." >> version.go; \
		echo -e "\tVERSION = \"$$latestVersion\"" >> version.go; \
		echo ")" >> version.go; \
	else \
		echo "version $$newVersion not start with v"; \
		exit 1; \
	fi; \
	echo "$$goGetCMD"; \
	for file in ${files}; do \
		goModPath=$$(dirname $$file); \
		if [[ $$goModPath =~ "./contrib" ]]; then \
			echo ""; \
			echo "processing dir: $$goModPath"; \
			cd $$goModPath; \
			go mod tidy; \
			go list -f "{{if and (not .Indirect) (not .Main)}}{{.Path}}@$$latestVersion{{end}}" -m all | grep "^github.com/hailaz/gotest" | xargs -L1 go get -v ; \
			go mod tidy; \
			cd -; \
		fi; \
	done; \
	./use.sh
# make cliversion to=v2.0.41
cliversion:
	$(eval files=$(shell find . -name go.mod))
	@set -e; \
	newVersion=$(to); \
	echo "The version will be set to $$newVersion"; \
	echo "$$goGetCMD"; \
	for file in ${files}; do \
		goModPath=$$(dirname $$file); \
		if [[ $$goModPath =~ "./cmd" ]]; then \
			echo ""; \
			echo "processing dir: $$goModPath"; \
			cd $$goModPath; \
			go mod tidy; \
			go list -f "{{if and (not .Indirect) (not .Main)}}{{.Path}}@$$newVersion{{end}}" -m all | grep hailaz/gotest; \
			go list -f "{{if and (not .Indirect) (not .Main)}}{{.Path}}@$$newVersion{{end}}" -m all | grep contrib | xargs -L1 go get -v ; \
			go mod tidy; \
			cd -; \
		fi; \
	done
