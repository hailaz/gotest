#!/bin/bash
for file in `find . -name go.mod`; do
    echo
    echo start:$file
    dirpath=$(dirname $file)
    go work use $dirpath
done