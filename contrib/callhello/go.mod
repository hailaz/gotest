module github.com/hailaz/gotest/contrib/callhello/v2

go 1.18

replace (github.com/hailaz/gotest/v2 => ../../

 github.com/hailaz/gotest/contrib/hello/v2 => ../hello
 )

require github.com/hailaz/gotest/v2 v2.0.10
