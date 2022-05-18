[![codecov](https://codecov.io/gh/hailaz/gotest/branch/main/graph/badge.svg?token=QKM6APSHNC)](https://codecov.io/gh/hailaz/gotest)

gotest

```js
// module github.com/hailaz/gotest/v2
├─.github
│  └─workflows
├─add // module github.com/hailaz/gotest/add/v2
├─cmd
│  └─sub // module github.com/hailaz/gotest/cmd/sub
├─internal
│  └─sub
└─sub // module github.com/hailaz/gotest/sub
```


```shell
# 根目录跑本项目的测试
go test ./... -race -coverprofile=coverage.out -covermode=atomic

# 本项目下的子项目
cd add
go test ./... -race -coverprofile=coverage.out -covermode=atomic
## 如果子项目也是v2的话，需要转换一下报告文件内的路径
## /add/v2 => /v2/add 
sed -i "s/gotest\(\/.*\)\/v2/gotest\/v2\1/g" coverage.out

```

```shell
# 转换前
mode: atomic
github.com/hailaz/gotest/add/v2/sub.go:3.24,5.2 1 1
github.com/hailaz/gotest/add/v2/sub.go:7.29,9.2 1 1
github.com/hailaz/gotest/add/v2/sub.go:16.28,18.2 1 0

# 转换后
mode: atomic
github.com/hailaz/gotest/v2/add/sub.go:3.24,5.2 1 1
github.com/hailaz/gotest/v2/add/sub.go:7.29,9.2 1 1
github.com/hailaz/gotest/v2/add/sub.go:16.28,18.2 1 0

```



### history


sed -n '2,$p' coverage.out >> ../coverage.out

go test --count=1 -coverprofile=coverage.out ./...
go test ./... -race -coverprofile=coverage.out -covermode=atomic -coverpkg="./..."
go tool cover -func coverage.out

https://github.com/go-kratos/kratos


sed -i "s/\(\/add\)\/v2/\/v2\/add/g" coverage.out
sed -i "s/gotest\(\/.*\)\/v2/gotest\/v2\1/g" coverage.out

sed -i "s/atomic/6666/g" coverage.out