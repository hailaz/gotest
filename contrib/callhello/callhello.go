package callhello

import (
	"github.com/hailaz/gotest/contrib/hello/v2"
	"github.com/hailaz/gotest/v2"
)

// MyName description
//
// createTime: 2023-03-29 16:38:54
//
// author: hailaz
func MyName() string {
	return "callhello" + Version()
}

// Call description
//
// createTime: 2023-03-29 16:41:26
//
// author: hailaz
func Call() string {
	return hello.MyName()
}

// Version description
//
// createTime: 2023-03-28 16:58:12
//
// author: hailaz
func Version() string {
	return gotest.Version()
}
