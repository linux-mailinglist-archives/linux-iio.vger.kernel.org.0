Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C4EAD364
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 09:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfIIHHx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 03:07:53 -0400
Received: from smtpx.feld.cvut.cz ([147.32.192.33]:49961 "EHLO
        smtpx.feld.cvut.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731728AbfIIHHx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2019 03:07:53 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Sep 2019 03:07:50 EDT
Received: from localhost (styx [192.168.200.7])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id 4035B3AC14;
        Mon,  9 Sep 2019 09:02:04 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.feld.cvut.cz ([192.168.200.2])
        by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10060)
        with ESMTP id 3bngMKHHp4-p; Mon,  9 Sep 2019 09:02:02 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
        by smtpx.feld.cvut.cz (Postfix) with ESMTP id 784063AADF;
        Mon,  9 Sep 2019 09:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
        s=felmail; t=1568012519;
        bh=AxBKQMMJmoIl8zFfCGAbOfSsNJZv2X5TRJOZ2QkFWr8=;
        h=From:Subject:Date:In-Reply-To:Cc:To:References:From;
        b=Vo8j7bZWpC5Cc8mU4AF94IKNphe3wu9ILkfhziz39x7c6AR4HeORk6MzY4JC9JHEN
         KnfTuDujeB3oJtlAWieHwKbjejwMOIMwHj0c/lBbzRN5hNADsKb7UsumedygVA2BJX
         KDwZ++Ei5CJOi2S3RGRk9hn1eZva/USwzrfm6RfEMerLJlcyMIy6YOP5zzGKsrNI/T
         uB0GHuFFxEf2NM4jz7n6n4b+ez4B2Cr6+SFlh59kiC3hqPz3kSn+iqaXvYVRTXHmW9
         Qq4ILfuGxHTYS0CXuaLvxrWfMlgznz7gJPkEwTfUzzpU6FtHH728fQjG8Xn20nbAfv
         w69KLXr/OlrOg==
From:   =?utf-8?Q?Zbyn=C4=9Bk_Kocur?= <zbynek.kocur@fel.cvut.cz>
Message-Id: <7FD0B694-64B5-433D-B451-A0FD4DF32AED@fel.cvut.cz>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_A1CBC4C3-6BB8-4C15-AA59-291285AA0473";
        protocol="application/pkcs7-signature";
        micalg=sha-256
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] iio: srf04: fix wrong limitation in distance measuring
Date:   Mon, 9 Sep 2019 08:53:57 +0200
In-Reply-To: <20190907094632.kalkqtkxlfphdx4w@arbad>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org
To:     Andreas Klinger <ak@it-klinger.de>
References: <20190623122909.hhzskp6k5vm4wify@arbad>
 <20190626192134.4b7aed3c@archlinux>
 <03D5EE82-D6C7-4A03-9404-45B48F1EF5B6@fel.cvut.cz>
 <20190626204936.2756cefd@archlinux>
 <3372AFA8-5AD0-4044-9718-D3E2B76EDFAE@fel.cvut.cz>
 <20190907094632.kalkqtkxlfphdx4w@arbad>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Apple-Mail=_A1CBC4C3-6BB8-4C15-AA59-291285AA0473
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Andreas,

I'm so sorry for the delay. I was working on another project now, and I =
wasn't entirely devoted to this. I looked at it at the weekend and the =
modified code is working. I have only tested OpenWRT in build - =
r10204-38b22b1, kernel 4.14.125. I do not expect complications on other =
platforms.

I tried it on several sensors. I was primarily interested in JSN-SR04T =
(https://www.makerguides.com/jsn-sr04t-arduino-tutorial/). I have also =
verified other designs =
(https://randomnerdtutorials.com/complete-guide-for-ultrasonic-sensor-hc-s=
r04/).

It generally works. Relatively accurate for the area up to 2.5 m. =
However, if the distance is longer, it starts to fizz, depending on the =
sensor design. It is a property of used HW and its construction.

I do not know how to do this in the development of drivers, whether it =
makes sense to put a filter directly into the driver or at least pull =
the maximum distance parameter as a variable?

Anyway, the change made works.

Zbynek
---
email: zbynek.kocur@fel.cvut.cz
phone: +420 224 354 054
web: http://www.fel.cvut.cz
Department of Telecommunications Engineering
Faculty of Electrical Engineering

> On 7 Sep 2019, at 11:46, Andreas Klinger <ak@it-klinger.de> wrote:
>=20
> Hi Zbynek,
>=20
> do you have any feedback for us?
>=20
> Thank you,
>=20
> Andreas
>=20
>=20
> Zbyn=C4=9Bk Kocur <zbynek.kocur@fel.cvut.cz> schrieb am Mi, 26. Jun =
21:50:
>> Thank you, i will write a feedback after testing.
>>=20
>>=20
>> Zbynek
>> ---
>> email: zbynek.kocur@fel.cvut.cz
>> phone: +420 224 354 054
>> web: http://www.fel.cvut.cz
>> Department of Telecommunications Engineering
>> Faculty of Electrical Engineering
>>=20
>>> On 26 Jun 2019, at 21:49, Jonathan Cameron <jic23@kernel.org> wrote:
>>>=20
>>> No rush, it's a clear fix anyway so we can queue this up
>>> in the rc phase of the next kernel cycle!
>>=20
>=20
> --=20
> Andreas Klinger
> Grabenreith 27
> 84508 Burgkirchen
> +49 8623 919966
> ak@it-klinger.de
> www.it-klinger.de
> www.grabenreith.de


--Apple-Mail=_A1CBC4C3-6BB8-4C15-AA59-291285AA0473
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCo0w
ggUJMIID8aADAgECAhACt8ndrdK9CetZxFyQDGB4MA0GCSqGSIb3DQEBCwUAMGUxCzAJBgNVBAYT
AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5jb20xJDAi
BgNVBAMTG0RpZ2lDZXJ0IEFzc3VyZWQgSUQgUm9vdCBDQTAeFw0xNDExMTgxMjAwMDBaFw0yNDEx
MTgxMjAwMDBaMHIxCzAJBgNVBAYTAk5MMRYwFAYDVQQIEw1Ob29yZC1Ib2xsYW5kMRIwEAYDVQQH
EwlBbXN0ZXJkYW0xDzANBgNVBAoTBlRFUkVOQTEmMCQGA1UEAxMdVEVSRU5BIGVTY2llbmNlIFBl
cnNvbmFsIENBIDMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCwp9Jj5Aej1xPkS1GV
3LvBdemFmkUR//nSzBodqsU3dv2BCRD30r4gt5oRsYtyqDGF2nnItxV1SkwVoDxFeRzOIHYNYvBR
HaiGvCQjEXzPRTocOSVfWpmq/zAL/QOEqpJogeM+0IBGiJcAENJshl7UcfjYbBnN5qStk74f52VW
Ff/aiF7MVJnsUr3oriQvXYOzs8N/NXyyQyimatBbumJVCNszF1X+XHCGfPNvxlNFW9ktv7azK0ba
minfLcsh6ubCdINZc+Nof2lU387NCDggoh3KsYVcZTSuhh7qp6MjxE5VqOZod1hpXXzDOkjK+DAM
C57iZXssncp24eaN08VlAgMBAAGjggGmMIIBojASBgNVHRMBAf8ECDAGAQH/AgEAMA4GA1UdDwEB
/wQEAwIBhjB5BggrBgEFBQcBAQRtMGswJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmRpZ2ljZXJ0
LmNvbTBDBggrBgEFBQcwAoY3aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29tL0RpZ2lDZXJ0QXNz
dXJlZElEUm9vdENBLmNydDCBgQYDVR0fBHoweDA6oDigNoY0aHR0cDovL2NybDMuZGlnaWNlcnQu
Y29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDA6oDigNoY0aHR0cDovL2NybDQuZGlnaWNl
cnQuY29tL0RpZ2lDZXJ0QXNzdXJlZElEUm9vdENBLmNybDA9BgNVHSAENjA0MDIGBFUdIAAwKjAo
BggrBgEFBQcCARYcaHR0cHM6Ly93d3cuZGlnaWNlcnQuY29tL0NQUzAdBgNVHQ4EFgQUjJ8RLubj
egSlHlWLRggEpu2XcKYwHwYDVR0jBBgwFoAUReuir/SSy4IxLVGLp6chnfNtyA8wDQYJKoZIhvcN
AQELBQADggEBAI5HEV91Oen8WHFCoJkeu2Av+b/kWTV2qH/YNI1Xsbou2hHKhh4IyNkFOxA/TUiu
K2qQnQ5hAS0TIrs9SJ1Ke+DjXd/cTBiw7lCYSW5hkzigFV+iSivninpItafWqYBSWxITl1KHBS9Y
BskhEqO5GLliDMPiAgjqUBQ/H1qZMlZNQIuFu0UaFUQuZUpJFr4+0zpzPxsBiWU2muAoGItwbaP5
5EYshM7+v/J+x6kIhAJt5Dng8fOmOvR9F6Vw2/E0EZ6oQ8g1fdhwM101S1OI6J1tUil1r7ES/svN
qVWVb7YkUEBcPo8ppfHnTI/uxsn2tslsWefsOGJxNYUUSMAb9EowggV8MIIEZKADAgECAhADCxA9
1AsZ5dqAhJ8cU1GaMA0GCSqGSIb3DQEBCwUAMHIxCzAJBgNVBAYTAk5MMRYwFAYDVQQIEw1Ob29y
ZC1Ib2xsYW5kMRIwEAYDVQQHEwlBbXN0ZXJkYW0xDzANBgNVBAoTBlRFUkVOQTEmMCQGA1UEAxMd
VEVSRU5BIGVTY2llbmNlIFBlcnNvbmFsIENBIDMwHhcNMTgxMjExMDAwMDAwWhcNMjAwMTEwMTIw
MDAwWjCBnDETMBEGCgmSJomT8ixkARkWA29yZzEWMBQGCgmSJomT8ixkARkWBnRlcmVuYTETMBEG
CgmSJomT8ixkARkWA3RjczELMAkGA1UEBhMCQ1oxLTArBgNVBAoTJEN6ZWNoIFRlY2huaWNhbCBV
bml2ZXJzaXR5IGluIFByYWd1ZTEcMBoGA1UEAxMTWmJ5bmVrIEtvY3VyIDI1MjM5MDCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAMnGy+1+NNy7wu1QscgOEEJqQqo9wWkgxDcWlF0Nwh+s
iwYoEoz1261+zc94oaj53K5FfdLiOSGrIIo+quEOIeXt4Jeq6bkrlBj2izjflTRCrKCp2WUeX7gU
cPJZWNaJDu1JczIsz3s2Fu450s1zsVJQJ/r1w1MN8Qa99fgOHsO43AsJBOH1U/3+4aAu35b7eGCQ
q7RemtCBP8kR1JMlH0IRHKlj834d7zvkO5zSnq+4bpwtAMHRvTQd02OaoGaPEShQcxu/QgfJIgwC
TIqzBjOo0MOI0vyNmJMbhe/lDV8neRTNy5fRQwn8BanbiPiH4UO/Ssm2fTmAV1wyWn3uQhUCAwEA
AaOCAeEwggHdMB8GA1UdIwQYMBaAFIyfES7m43oEpR5Vi0YIBKbtl3CmMB0GA1UdDgQWBBSfwmz2
ANXRhdCSCqrHYaRifPjecDAMBgNVHRMBAf8EAjAAMCMGA1UdEQQcMBqBGHpieW5lay5rb2N1ckBm
ZWwuY3Z1dC5jejAOBgNVHQ8BAf8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwME
MDQGA1UdIAQtMCswDAYKKoZIhvdMBQICATAMBgpghkgBhv1sBB8BMA0GCyqGSIb3TAUCAwMDMIGF
BgNVHR8EfjB8MDygOqA4hjZodHRwOi8vY3JsMy5kaWdpY2VydC5jb20vVEVSRU5BZVNjaWVuY2VQ
ZXJzb25hbENBMy5jcmwwPKA6oDiGNmh0dHA6Ly9jcmw0LmRpZ2ljZXJ0LmNvbS9URVJFTkFlU2Np
ZW5jZVBlcnNvbmFsQ0EzLmNybDB7BggrBgEFBQcBAQRvMG0wJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmRpZ2ljZXJ0LmNvbTBFBggrBgEFBQcwAoY5aHR0cDovL2NhY2VydHMuZGlnaWNlcnQuY29t
L1RFUkVOQWVTY2llbmNlUGVyc29uYWxDQTMuY3J0MA0GCSqGSIb3DQEBCwUAA4IBAQAYIuMyrCiW
qc0uTM/cM4o88daJgxfAK6Ivrb/Yuokd5u8ntCyIrphWmCeNDKr5Hmsq553qKkdxxouhAa46WLrW
69tkQFLFC7T0GBc4s9tozY6OpUbz6IRsE1wKyk4no4nK7sav10W5xuNgNdHWOSHtX/iG6T3pQnnj
0NBx6ZK3lxF5Bw+kdcscgRnCEV2jbrOOe8vzCLwe/IrZgSPF+C2cE8Xg64YHNPne29coJ3Or+/ZS
sSEKf/nQMWq37X0MQErgYByTccekFa/mA8mroFL1W0L1pZ22BcEzXtgK+H2IAJWg0GxPePjte1t7
0Y96/lwpglS6tUGze84StOYttVy9MYIDVTCCA1ECAQEwgYYwcjELMAkGA1UEBhMCTkwxFjAUBgNV
BAgTDU5vb3JkLUhvbGxhbmQxEjAQBgNVBAcTCUFtc3RlcmRhbTEPMA0GA1UEChMGVEVSRU5BMSYw
JAYDVQQDEx1URVJFTkEgZVNjaWVuY2UgUGVyc29uYWwgQ0EgMwIQAwsQPdQLGeXagISfHFNRmjAN
BglghkgBZQMEAgEFAKCCAZ8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUx
DxcNMTkwOTA5MDY1MzU4WjAvBgkqhkiG9w0BCQQxIgQgYLd5shPrRunpYdqiqoD3txSRHobM9Cni
rCxufZPYnjUwgZcGCSsGAQQBgjcQBDGBiTCBhjByMQswCQYDVQQGEwJOTDEWMBQGA1UECBMNTm9v
cmQtSG9sbGFuZDESMBAGA1UEBxMJQW1zdGVyZGFtMQ8wDQYDVQQKEwZURVJFTkExJjAkBgNVBAMT
HVRFUkVOQSBlU2NpZW5jZSBQZXJzb25hbCBDQSAzAhADCxA91AsZ5dqAhJ8cU1GaMIGZBgsqhkiG
9w0BCRACCzGBiaCBhjByMQswCQYDVQQGEwJOTDEWMBQGA1UECBMNTm9vcmQtSG9sbGFuZDESMBAG
A1UEBxMJQW1zdGVyZGFtMQ8wDQYDVQQKEwZURVJFTkExJjAkBgNVBAMTHVRFUkVOQSBlU2NpZW5j
ZSBQZXJzb25hbCBDQSAzAhADCxA91AsZ5dqAhJ8cU1GaMA0GCSqGSIb3DQEBAQUABIIBAH9YBT47
ygFsbCU7Hw3iaO+zNajMp1ipTmoCIUT4jW0MFAhER0UyNAtXHL353SJoWZMHEBAUJhN3SAVXy1LI
NXMdSsyn9vIIcPc4nrmLQ2m3mvqDIcG6CbL00Jz3pZaTVJs6FTEF6NlcZXnFNuPkDzkk5LOOoe4Q
Ov08xL9QbGPVGWgfcODzXDklG7kfZYEX94g3lvldY4gMlQgKH747Af/3eUt/In1vETLS5KHWS+Q1
AN9VzTmKUQD6QEtYgamfZFekg7OsQ4wXD9+pc1109+9w0xJdwYR3GYW4gc545ooBueS7lMmxrma5
QjwHO1MIdr+MVpyNGrngZ6jcLG6IMs4AAAAAAAA=
--Apple-Mail=_A1CBC4C3-6BB8-4C15-AA59-291285AA0473--
