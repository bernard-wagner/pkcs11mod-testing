
### Checkout code ###

```
git clone --recursive
```

### Build Testing Docker

```
docker build -t docker.pkg.github.com/bernard-wagner/pkcs11mod-testing .
```

### Run tests

```
docker run -it --rm docker.pkg.github.com/bernard-wagner/pkcs11mod-testing
```

### Example results

```
************************************************
* Testing what DNSSEC algorithms are available *
************************************************

(Cannot test GOST since it is not available in PKCS#11 v2.20)

Testing digesting
*****************
  Will test the digesting mechanisms.
  If the algorithm is not available, then digesting has to be done
  in the host application. (MD5 is not recommended to use)

  CKM_MD5: OK
  CKM_SHA_1: OK
  CKM_SHA256: OK
  CKM_SHA512: OK

Testing RSA key generation
**************************
  Will test if RSA key generation is supported.
  DNSSEC support keys up to 4096 bits.

  CKM_RSA_PKCS_KEY_PAIR_GEN: OK
  512 bits: OK
  768 bits: OK
  1024 bits: OK
  1536 bits: OK
  2048 bits: OK
  3072 bits: OK
  4096 bits: OK

Testing RSA signing
*******************
  Will test if RSA signing is supported.
  Doing RAW RSA signing is not recommended (CKM_RSA_X_509)
  If the digesting algorithms are not available, 
  then digesting has to be done in the host application.
  Then use the RSA only mechanisms.

  CKM_RSA_PKCS: OK
  CKM_RSA_X_509: OK
  CKM_MD5_RSA_PKCS: OK
  CKM_SHA1_RSA_PKCS: OK
  CKM_SHA256_RSA_PKCS: OK
  CKM_SHA512_RSA_PKCS: OK

Testing DSA key generation
**************************
  (Not testing functionality)
  Will test if DSA key generation is supported.
  DNSSEC support keys up to 1024 bits.

  CKM_DSA_PARAMETER_GEN: OK
  CKM_DSA_KEY_PAIR_GEN: OK

Testing DSA signing
*******************
  (Not testing functionality)
  Will test if DSA signing is supported.
  If the digesting algorithm is not available, 
  then digesting has to be done in the host application.
  Then use the DSA only mechanism.

  CKM_DSA: OK
  CKM_DSA_SHA1: OK

***************************************************
* Testing if NSA Suite B algorithms are available *
***************************************************

Testing symmetric encryption
****************************
  (Not testing functionality)
  Should support between 128 and 256 bits.

  CKM_AES_KEY_GEN: OK
  CKM_AES_CBC: OK
  CKM_AES_CTR: OK

Testing signatures
*********************
  (Not testing functionality)
  Should support between 256 and 384 bits.

  CKM_EC_KEY_PAIR_GEN: OK
  CKM_ECDSA: OK

Testing key agreement
*********************
  (Not testing functionality)
  Should support between 256 and 384 bits.

  CKM_ECDH1_DERIVE: OK
  CKM_ECDH1_COFACTOR_DERIVE: Not available

Testing digesting
*****************
  (Not testing functionality)
  Will test if the digesting mechanisms are supported.
  If the digesting algorithms are not available, 
  then digesting has to be done in the host application.

  CKM_SHA256: OK
  CKM_SHA384: OK

******************************************************
* Test for public information in the RSA private key *
******************************************************

You normally have a public and private key object.
But the private key could contain all the necessary
information in order to export the public key from the
private key object. However, PKCS#11 cannot guarantee
that the HSM can do this. If the private key object
has all the necessary information, then you only need
to keep the private key. Thus saving space in the HSM.

Generate a key pair: OK
Public key information from public key object: OK
Public key information from private key object: OK
Testing if the data is equal: OK

From public key:
Public exponent: 010001
Modulus: D1432B3A7BCBAB4E47DFC94DB41AA2E63DA2F84E65F4C94D53FD4B445931F8410B6913C7A15DF07E097BC8C8950C19C94700D5D77A8AF91C376929C1E23B6DE584C31D37F9880EBC8B78387B574D54372E44A841CFEFE44D5C706EE11196E56E656C0A7EDE7EE80BA53BDC668C3474EB936DEC8B9CCD443FEF2496E7DEAF8461

From private key:
Public exponent: 010001
Modulus: D1432B3A7BCBAB4E47DFC94DB41AA2E63DA2F84E65F4C94D53FD4B445931F8410B6913C7A15DF07E097BC8C8950C19C94700D5D77A8AF91C376929C1E23B6DE584C31D37F9880EBC8B78387B574D54372E44A841CFEFE44D5C706EE11196E56E656C0A7EDE7EE80BA53BDC668C3474EB936DEC8B9CCD443FEF2496E7DEAF8461

************************************
* Test for importing RSA key pairs *
************************************

This test will try to import 1024 bit and 1025 bit
key pairs. Some HSM:s might not accept the odd size 1025.
Also verify that the HSM set the key lengths correctly.

Importing 1024 bit public RSA key: OK
Importing 1024 bit private RSA key: OK
Key size from CKA_MODULUS_BITS in public key: 1024 bits
Key size from CKA_MODULUS in public key: 1024 bits
Equal bit length: Yes
Create signature: OK
Verify signature: OK
Importing 1025 bit public RSA key: OK
Importing 1025 bit private RSA key: OK
Key size from CKA_MODULUS_BITS in public key: 1025 bits
Key size from CKA_MODULUS in public key: 1025 bits
Equal bit length: Yes
Create signature: OK
Verify signature: OK

********************************************************
* Test for stability during key generation and signing *
********************************************************

This test will perform the following:

* Key rollovers = 2
  The number of times that the key pair will be replaced.
* Batchjobs = 2
  The number of batchjobs for each key pair.
* signatures = 100
  Each batchjob will create signatures and verify them.
* sleep time = 15
  The process will sleep between the batchjobs.

Generating a key pair...
Creating signatures and verifying them...
Sleeping for 15 seconds...
Creating signatures and verifying them...
Sleeping for 15 seconds...
Deleting the key pair...
Generating a key pair...
Creating signatures and verifying them...
Sleeping for 15 seconds...
Creating signatures and verifying them...
Sleeping for 15 seconds...
Deleting the key pair...
Generating a key pair...
Creating signatures and verifying them...
Sleeping for 15 seconds...
Creating signatures and verifying them...
Sleeping for 15 seconds...
Deleting the key pair...

The test was performed successfully.
```