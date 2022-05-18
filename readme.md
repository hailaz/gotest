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


go test --count=1 -coverprofile=coverage.out ./...
go test -race -coverprofile=coverage.out -covermode=atomic ./...
go tool cover -func coverage.out


