[![codecov](https://codecov.io/gh/hailaz/gotest/branch/main/graph/badge.svg?token=QKM6APSHNC)](https://codecov.io/gh/hailaz/gotest)

gotest

```js
// module github.com/hailaz/gotest/v2
├─.github
│  └─workflows
├─add // module github.com/hailaz/gotest/v2/add
├─cmd
│  └─sub // module github.com/hailaz/gotest/cmd/sub
├─internal
│  └─sub
└─sub // module github.com/hailaz/gotest/sub
```

go test -race -coverprofile=coverage.out -covermode=atomic
sed -n '2,$p' coverage.out >> ../coverage.out

go test --count=1 -coverprofile=coverage.out ./...
go test ./... -race -coverprofile=coverage.out -covermode=atomic -coverpkg="./..."
go tool cover -func coverage.out

https://github.com/go-kratos/kratos


sed -i "s/\/add\/v2/\/v2\/add/g" coverage.out
sed -i "s/atomic/6666/g" coverage.out