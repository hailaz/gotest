package add

import "testing"

func TestAdd(t *testing.T) {
	if got, want := Add(1, 2), 3; got != want {
		t.Errorf("add method produced wrong result. expected: %d, got: %d", want, got)
	}
}

func TestSub(t *testing.T) {
	if got, want := Subtract(2, 1), 1; got != want {
		t.Errorf("add method produced wrong result. expected: %d, got: %d", want, got)
	}
}
