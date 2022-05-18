#!/bin/bash
basepath=$(cd $(dirname $0) && pwd )
echo $basepath
for file in `find . -name go.mod`; do
    echo start:$file
    dirpath=$(dirname $file)
    echo $dirpath
    cd $basepath
    cd $dirpath

    go test ./... -race -coverprofile=coverage.out -covermode=atomic
    # if [ "." = $dirpath ]; then
    #     echo 跳过
    #     continue 1
    # fi
    if grep -q "/gotest/.*/v2" go.mod; then
        sed -i "s/gotest\(\/.*\)\/v2/gotest\/v2\1/g" coverage.out
    else
        echo 跳过 $dirpath
    fi
    
    echo end
    echo
done