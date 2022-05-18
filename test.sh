#!/bin/bash
for file in `find . -name go.mod`; do
    echo
    echo start:$file
    dirpath=$(dirname $file)
    echo $dirpath
    cd $dirpath

    go test ./... -v -race -coverprofile=coverage.out -covermode=atomic

    if grep -q "/gotest/.*/v2" go.mod; then
        sed -i "s/gotest\(\/.*\)\/v2/gotest\/v2\1/g" coverage.out
    else
        echo 跳过 $dirpath
    fi
    
    echo end
    cd -
done