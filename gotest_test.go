package gotest

import (
	"testing"
	"time"
)

func TestAdd(t *testing.T) {
	if got, want := Add(1, 2), 3; got != want {
		t.Errorf("add method produced wrong result. expected: %d, got: %d", want, got)
	}
	time.Sleep(time.Second * 60)
}
