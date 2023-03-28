package submod

import "github.com/hailaz/gotest/v2"

// Add description
//
// createTime: 2023-03-28 16:53:01
//
// author: hailaz
func Add() {
	gotest.Add(1, 2)
}

// Version description
//
// createTime: 2023-03-28 16:58:12
//
// author: hailaz
func Version() string {
	return gotest.Version()
}
