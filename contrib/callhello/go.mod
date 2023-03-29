module github.com/hailaz/gotest/contrib/callhello/v2

go 1.18

replace (
	github.com/hailaz/gotest/contrib/hello/v2 => ../hello/
	github.com/hailaz/gotest/v2 => ../../
)

require (
	github.com/hailaz/gotest/contrib/hello/v2 v2.0.0-00010101000000-000000000000
	github.com/hailaz/gotest/v2 v2.0.12
)
