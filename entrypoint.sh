#!/bin/bash

SLOT_ID=$(softhsm2-util --init-token --slot 0 --label softhsm --so-pin 1234 --pin 1234 | grep -oE '[^ ]+$')

PKCS11MOD_BACKEND=/usr/lib/softhsm/libsofthsm2.so pkcs11-testing --module /workspace/libmypkcs11module.so --slot $SLOT_ID --pin 1234 --test-all

SLOT_ID=$(softhsm2-util --init-token --slot 1 --label softhsm --so-pin 1234 --pin 1234 | grep -oE '[^ ]+$')

PKCS11MOD_BACKEND=/usr/lib/softhsm/libsofthsm2.so pkcs11-testing --module /workspace/libmypkcs11module.so --slot $SLOT_ID --pin 1234 --test-stability
