package hello

import "github.com/hailaz/gotest/v2"

// Add description
//
// createTime: 2023-03-28 16:53:01
//
// author: hailaz
func Add() {
	gotest.Add(1, 2)
}

// MyName description
//
// createTime: 2023-03-29 16:38:54
//
// author: hailaz
func MyName() string {
	return "hello"
}

// Version description
//
// createTime: 2023-03-28 16:58:12
//
// author: hailaz
func Version() string {
	return gotest.Version()
}
