# tls-utils

A handy collection of tls plumbing scripts

You know that question on server fault on how to [display a remote SSL
certificate details using CLI tools][serverfault-openssl]? I keep forgetting the
right set of openssl flags too, every so often.

Today's the day I decided enough is enough and made this small collection of all
things SSL & TLS that just do the right thing.

## Installing on nix

Just add them to your profile:

```
$ nix profile install github:farcaller/tls-utils
```

## Usage

### show-remote-cert

Returns the certificate presented by the remote.

```
$ show-remote-cert example.com
depth=2 C = US, O = DigiCert Inc, OU = www.digicert.com, CN = DigiCert Global Root CA
verify return:1
depth=1 C = US, O = DigiCert Inc, CN = DigiCert TLS RSA SHA256 2020 CA1
verify return:1
depth=0 C = US, ST = California, L = Los Angeles, O = Internet\C2\A0Corporation\C2\A0for\C2\A0Assigned\C2\A0Names\C2\A0and\C2\A0Numbers, CN = www.example.org
verify return:1
DONE
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            0f:aa:63:10:93:07:bc:3d:41:48:92:64:0c:cd:4d:9a
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C = US, O = DigiCert Inc, CN = DigiCert TLS RSA SHA256 2020 CA1
...
```

You can optionally specify the port:

```
$ show-remote-cert localhost 6443
depth=1 CN = k3s-server-ca@1664454296
verify error:num=19:self-signed certificate in certificate chain
verify return:1
depth=1 CN = k3s-server-ca@1664454296
verify return:1
depth=0 O = k3s, CN = k3s
verify return:1
DONE
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 7888028153356117863 (0x6d77e7d01b126767)
        Signature Algorithm: ecdsa-with-SHA256
        Issuer: CN = k3s-server-ca@1664454296
...
```

## License

Distributed under Apache-2.0

[serverfault-openssl]:
    https://serverfault.com/questions/661978/displaying-a-remote-ssl-certificate-details-using-cli-tools
