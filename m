Return-Path: <linux-iio+bounces-9699-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2DB97E121
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 13:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3208E280F9A
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 11:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E622193090;
	Sun, 22 Sep 2024 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="js2GvtWk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217CF61FCF;
	Sun, 22 Sep 2024 11:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727004443; cv=none; b=JjYaDE1ZVz6+fM/tg1q/VjCk8niaHrE4TwlUUhQlXjCpCjpJGhf3B36y4l7iyx9EEt8Abetq1zUjHs4GNhgmSHFY9YFRQOgb5j+29ZZZGPS3nOy+mP2FXfnmiqQKJRv74zwQvtC8Hxmz3HhSF8dcq2TPhCEv9CFwgjsKTc1pvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727004443; c=relaxed/simple;
	bh=lbdq4Hy5JBUmnlKohQdgYWxVAtSUrcF7vHjH4YcyevE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Oh99sYNGUxvpgxCGmndWKEK53QzjTWKfnB9RPbvLs6nYc9Jx8dgA/iOj+UeRxn/mhT29f1Z7ikz7LYCpVzNVJlGTtnqxZritUx4l6+T2FewEeKiqrozl4kr9UYSbVDIm1aDzraP10SloKhISNWx/5e6pKuqoguAerHRsy/7Pu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=js2GvtWk; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1727004375;
	bh=lbdq4Hy5JBUmnlKohQdgYWxVAtSUrcF7vHjH4YcyevE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=js2GvtWk2XXEcaRXoxh078xcPpySevuQu+UoW2U55cfTWoCIbQgj61UaH2fR4DQxU
	 p67CGtjPJVKOvSw/5Rf3zzkSeA927QlVbTXfHBTKGEtIyxzM/Xret7GwV4t9zZzZrt
	 HvmilxXCTfXY5cISqubdbE9LfCl21zDwPXjNHp4w=
X-QQ-mid: bizesmtpip2t1727004371t894wvx
X-QQ-Originating-IP: 8oSQ5aIskk9G7W8UCzLlN96W6+ZFphldw/P2ndRhu8M=
Received: from [IPV6:240e:36c:d18:fa00:e9bb:21 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 22 Sep 2024 19:26:09 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1373273845902169089
Message-ID: <739D781F53669A17+ee9db6cf-dca4-4e53-9444-ecdf0b72dfbd@uniontech.com>
Date: Sun, 22 Sep 2024 19:26:08 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: [PATCH 2/3] iio: accel: adxl355: Correct the typo 'accelaration'
To: WangYuli <wangyuli@uniontech.com>, puranjay@kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org
References: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com, Jonathan.Cameron@huawei.com
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------yiFxPIoj1JKMgKgepLxqkNUa"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------yiFxPIoj1JKMgKgepLxqkNUa
Content-Type: multipart/mixed; boundary="------------53e6F1H6IQlYyPpQY086Gvib";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>, puranjay@kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 puranjay12@gmail.com, Jonathan.Cameron@huawei.com
Message-ID: <ee9db6cf-dca4-4e53-9444-ecdf0b72dfbd@uniontech.com>
Subject: [PATCH 2/3] iio: accel: adxl355: Correct the typo 'accelaration'
References: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>
In-Reply-To: <7BF34BF48048052E+20240922111832.441807-1-wangyuli@uniontech.com>

--------------53e6F1H6IQlYyPpQY086Gvib
Content-Type: multipart/mixed; boundary="------------T7CjhhUwsAbXe1APTkXWII6D"

--------------T7CjhhUwsAbXe1APTkXWII6D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

IEZyb20gNTYyYTZjZTNlYmJlYWUwM2VhYmRkOGZhNWMyNjUyOTljYTU5NTYwYiBNb24gU2Vw
IDE3IDAwOjAwOjAwIDIwMDENCkZyb206IFdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2gu
Y29tPg0KRGF0ZTogU3VuLCAyMiBTZXAgMjAyNCAxODo0NTo1MCArMDgwMA0KU3ViamVjdDog
W1BBVENIIDIvM10gaWlvOiBhY2NlbDogYWR4bDM1NTogQ29ycmVjdCB0aGUgdHlwbyAnYWNj
ZWxhcmF0aW9uJw0KDQpUaGVyZSBpcyBhIHNwZWxsaW5nIG1pc3Rha2Ugb2YgJ2FjY2VsYXJh
dGlvbicgd2hpY2ggc2hvdWxkIGJlDQonYWNjZWxlcmF0aW9uJy4NCg0KU2lnbmVkLW9mZi1i
eTogV2FuZ1l1bGkgPHdhbmd5dWxpQHVuaW9udGVjaC5jb20+DQotLS0NCiDCoGRyaXZlcnMv
aWlvL2FjY2VsL2FkeGwzNTVfY29yZS5jIHwgMiArLQ0KIMKgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lp
by9hY2NlbC9hZHhsMzU1X2NvcmUuYyANCmIvZHJpdmVycy9paW8vYWNjZWwvYWR4bDM1NV9j
b3JlLmMNCmluZGV4IDBjOTIyNWQxOGZiMi4uNWU2ODJiZjA3OWQ4IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9paW8vYWNjZWwvYWR4bDM1NV9jb3JlLmMNCisrKyBiL2RyaXZlcnMvaWlvL2Fj
Y2VsL2FkeGwzNTVfY29yZS5jDQpAQCAtNjQzLDcgKzY0Myw3IEBAIHN0YXRpYyBpcnFyZXR1
cm5fdCBhZHhsMzU1X3RyaWdnZXJfaGFuZGxlcihpbnQgaXJxLCANCnZvaWQgKnApDQogwqDC
oMKgwqDCoMKgwqDCoCAqIFRoZSBhY2NlbGVyYXRpb24gZGF0YSBpcyAyNCBiaXRzIGFuZCBi
aWcgZW5kaWFuLiBJdCBoYXMgdG8gDQpiZSBzYXZlZA0KIMKgwqDCoMKgwqDCoMKgwqAgKiBp
biAzMiBiaXRzLCBoZW5jZSwgaXQgaXMgc2F2ZWQgaW4gdGhlIDJuZCBieXRlIG9mIHRoZSA0
IGJ5dGUgDQpidWZmZXIuDQogwqDCoMKgwqDCoMKgwqDCoCAqIFRoZSBidWYgYXJyYXkgaXMg
MTQgYnl0ZXMgYXMgaXQgaW5jbHVkZXMgM3g0PTEyIGJ5dGVzIGZvcg0KLcKgwqDCoMKgwqDC
oMKgICogYWNjZWxhcmF0aW9uIGRhdGEgb2YgeCwgeSwgYW5kIHogYXhpcy4gSXQgYWxzbyBp
bmNsdWRlcyAyIA0KYnl0ZXMgZm9yDQorwqDCoMKgwqDCoMKgwqAgKiBhY2NlbGVyYXRpb24g
ZGF0YSBvZiB4LCB5LCBhbmQgeiBheGlzLiBJdCBhbHNvIGluY2x1ZGVzIDIgDQpieXRlcyBm
b3INCiDCoMKgwqDCoMKgwqDCoMKgICogdGVtcGVyYXR1cmUgZGF0YS4NCiDCoMKgwqDCoMKg
wqDCoMKgICovDQogwqDCoMKgwqDCoMKgwqAgcmV0ID0gcmVnbWFwX2J1bGtfcmVhZChkYXRh
LT5yZWdtYXAsIEFEWEwzNTVfWERBVEEzX1JFRywNCi0tIA0KMi40My4wDQo=
--------------T7CjhhUwsAbXe1APTkXWII6D
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------T7CjhhUwsAbXe1APTkXWII6D--

--------------53e6F1H6IQlYyPpQY086Gvib--

--------------yiFxPIoj1JKMgKgepLxqkNUa
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZu/+0QUDAAAAAAAKCRDF2h8wRvQL7g9y
AQD4QNGbggCVqiHaWihrpqLlPuf1wraB5Z/YnX2gDXD6/QD/St2t70nqvWTYO4PQ5DilwNDuJnSb
AJn0j5v5cgX+Lgw=
=naMa
-----END PGP SIGNATURE-----

--------------yiFxPIoj1JKMgKgepLxqkNUa--

