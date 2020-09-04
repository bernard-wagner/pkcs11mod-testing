package main

import (
	"os"

	"github.com/bernard-wagner/pkcs11mod-testing/pkcs11mod"
	"github.com/miekg/pkcs11"
)

func init() {
	backend := pkcs11.New(os.Getenv("PKCS11MOD_BACKEND"))

	pkcs11mod.SetBackend(backend)
}

func main() {}
