package main

import (
	"github.com/lixiangzhong/dnsutil"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestDNSLookup(t *testing.T) {
	var dig dnsutil.Dig
	dig.At("127.0.0.1:5053")
	a, err := dig.A("google.com")
	handleError(err)

	assert.NotEmpty(t, a, "DNS lookup failed")
}

func handleError(err error) {
	if err != nil {
		panic(err)
	}
}
