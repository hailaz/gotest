#!/usr/bin/env bash

coverage=$1

for file in `find . -name go.mod`; do
    echo
    echo start:$file
    dirpath=$(dirname $file)
    echo $dirpath
    cd $dirpath

    # go test ./... -v -race -coverprofile=coverage.out -covermode=atomic
    # go test ./... -v -race

    # if grep -q "/gotest/.*/v2" go.mod; then
    #     sed -i "s/gotest\(\/.*\)\/v2/gotest\/v2\1/g" coverage.out
    # else
    #     echo 跳过 $dirpath
    # fi

    # check coverage
    if [ "${coverage}" = "coverage" ]; then
      go test ./... -v -race -coverprofile=coverage.out -covermode=atomic || exit 1

        if grep -q "/gotest/.*/v2" go.mod; then
            sed -i "s/gotest\(\/.*\)\/v2/gotest\/v2\1/g" coverage.out
        fi
    else
      go test ./... -v -race || exit 1
    fi
    
    echo end
    cd -
done