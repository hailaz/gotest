package main

import (
	"fmt"

	"github.com/gogf/gf/v2"
	"github.com/hailaz/gotest/contrib/callhello/v2"
	"github.com/hailaz/gotest/v2"
)

// main description
//
// createTime: 2023-04-28 15:16:47
//
// author: hailaz
func main() {
	fmt.Println("Hello, World!")
	fmt.Printf("Version: %s\n", gotest.Version())
	fmt.Printf("Version: %s\n", callhello.MyName())
	fmt.Printf("Version: gf %s\n", gf.VERSION)
}
// go install github.com/hailaz/gotest/cmd/gfly@v2.0.43