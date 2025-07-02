Return-Path: <linux-iio+bounces-21229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1232AF0EB0
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 11:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510C31BC853B
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 09:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D945423C4F8;
	Wed,  2 Jul 2025 09:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeJBlton"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A324C7F;
	Wed,  2 Jul 2025 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446885; cv=none; b=F633+53CShA7sJ6rbtFdL1KE3NjP7J0NtX5KWm9YjZ47qxMiKhZER3P16kLs1u3qADH56WGhdQPlp8LfkTWjPqarYXDRm8+yfHCiOKbUS1G3mEVPrHr95UlxvvCPTyaQYbp9QBqT/vZi5o1FWlZOepkhblbxVqDsUwK0KzxXFnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446885; c=relaxed/simple;
	bh=auRT17teGaBy5juyr3bL4w/sgR/QqF2fWEBT2Ob+UXY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=WEa5kP33Ss9ztZ3j9qFnJp1RN8USN+FXtYS2Vi+oOhYjfkSwVadkkC6s/3yoQGDn5a+Be7mg76V71aZIjuSbpVawqe0alF4I/v6AH6FYJgsngGaau5qSm5LdOGEKJKpwcYwlJkDzKgssP+7Ez1X+ZTXIUMsr69sqE/4xlCflO8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeJBlton; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-453647147c6so70016335e9.2;
        Wed, 02 Jul 2025 02:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751446882; x=1752051682; darn=vger.kernel.org;
        h=cc:to:autocrypt:subject:from:content-language:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=auRT17teGaBy5juyr3bL4w/sgR/QqF2fWEBT2Ob+UXY=;
        b=QeJBlton1wqwuS5EnR4nrcuSIL7Syer4yIMMwbclCzu3OCjBFYR9b2cFeJ6iA1xSxx
         erPVzQPV1EoaVCbPKk3DIbblHZ/972MNAHHyZFKFr4iO7LA84mXaUesEWifsby2Y8elV
         NsNVIB0/T2nydEAh9+JBd/9dRfe+GTG06eSbvljqE4LQu1ITowFiqmy2YVKkowgwfYbq
         pidScxV2kR1q/k6GavdGIrKW/T6bWq1IqHXEs6cMtsskMtDv5x5BzLLPw/n/jFcUNYcP
         ZcEfQZ5uzzkrs4v8QJFIrMQOoTMQFHVHwf4o2m4jtM0OeWVzQBVV4KL5e5JSTKnORysp
         b5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446882; x=1752051682;
        h=cc:to:autocrypt:subject:from:content-language:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=auRT17teGaBy5juyr3bL4w/sgR/QqF2fWEBT2Ob+UXY=;
        b=CnvNeekH4xmqeXBLs4/9C83G+9+9zlst667f2KdjRkyapq5qQXs370PVjnB2kpyIuT
         OTL9Liqyh6JnCfbTYRk6YVuoHjPIEXvXO8PZrOdlj21ANSJxboA2psU/RWlgNsDHpM4d
         B+OOQaW/xBxlaOFsNBtThKd4AdXkoOBRNEfm7FI7csyqo6dTmszKBXPVti6D3k6uTzyh
         i2vfUWl87pCz60QiDL400QMoRuOL+q4A3MyulYnR+BbuRQY6cjLODAC7JHI1hDKQ6LdC
         e883Lbx05YII9Q7YkfyWoksacIwN0f7oDYiKJJpU5IqkrBd7dlXoP+aHpemaXyOGYw2/
         Iu5g==
X-Forwarded-Encrypted: i=1; AJvYcCV7uIBm6CmMPUbHUdPA7v/Sx+75gix1K54w6B8VDvkRXmlHMJF7+QyfiIOQYf+8f+Fyi17wBmv9HMzL0kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFzD3OLRp1SOOw2UqxFcgqHKzGjfPSSqio3RId6ytUuPIAqol
	7ZKZN8lBhQT3lunSdMy8lAZyBAcoW7z4vdU4+0HyugvXcvH7HM/gzsvx
X-Gm-Gg: ASbGncs6SuyeAf1S5REZf6+rRv5QxNVNsLQ+sLQLST/z2eBQa20kd9weY8ubsG0ZZq6
	Wsff/+hNSgtv6Fuk6ZC/s9HH199VYE6mwqUaNoh8FAhJaV0qCUsccWE5hGrklzIJc3WiGyvvAq9
	tfRHwjB8gE2L1/7vBtbbuYk3ZFx/28SP5iwBjilK8ITeHw+Sqm+hONQSXx+6b8aeBIn4YcXU35v
	J+Q20qXI3xKkbwa0VsnlTTHG9vQxuRZ2xsmBPLvyAgn+o0O7eCDZgN6h/s5At5IH+b60Zm+oj3c
	Tvz5N6wCUM9rcwnaQSIIpSOwA3WDfqMaeuOq12t78yNFdYdUta9klpFWBHh/FdPnYI0+
X-Google-Smtp-Source: AGHT+IEiCTlPD71is/SYPSXivDD9FUXbn1oBeI6QZzQ/ObEf63uOmXSd+ks/4IhwF+5vklqHSxDvmg==
X-Received: by 2002:a05:600c:8b22:b0:453:8bc7:5cbb with SMTP id 5b1f17b1804b1-454a3726347mr19210125e9.25.1751446881463;
        Wed, 02 Jul 2025 02:01:21 -0700 (PDT)
Received: from [192.168.1.248] ([87.254.0.133])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4538a3fe24esm191234385e9.23.2025.07.02.02.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 02:01:20 -0700 (PDT)
Message-ID: <1c1e39cb-5fe0-46b3-898e-c65bbb3beb30@gmail.com>
Date: Wed, 2 Jul 2025 10:00:55 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: iio: accel: sca3000: dead code issue
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com,
 Andy Shevchenko <andy@kernel.org>, Gustavo Bastos <gustavobastos@usp.br>,
 Andrew Ijano <andrew.ijano@gmail.com>, Julien Stephan <jstephan@baylibre.com>
Cc: linux-iio@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jhIJhb7EBF6X68fmun5I0Chg"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jhIJhb7EBF6X68fmun5I0Chg
Content-Type: multipart/mixed; boundary="------------w7yRDwyjIUz80UzG1pilIPEX";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, nuno.sa@analog.com,
 Andy Shevchenko <andy@kernel.org>, Gustavo Bastos <gustavobastos@usp.br>,
 Andrew Ijano <andrew.ijano@gmail.com>, Julien Stephan <jstephan@baylibre.com>
Cc: linux-iio@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <1c1e39cb-5fe0-46b3-898e-c65bbb3beb30@gmail.com>
Subject: iio: accel: sca3000: dead code issue

--------------w7yRDwyjIUz80UzG1pilIPEX
Content-Type: multipart/mixed; boundary="------------Z0aa8MZnotfM05nmdF5w36LD"

--------------Z0aa8MZnotfM05nmdF5w36LD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGksDQoNClN0YXRpYyBhbmFseXNpcyBvbiBkcml2ZXJzL2lpby9hY2NlbC9zY2EzMDAwLmMg
b24gbGludXgtbmV4dCBoYXMgDQpkZXRlY3RlZCBhbiBpc3N1ZSBpbiB0aGUgZnVuY3Rpb24g
c2NhMzAwMF9yaW5nX2ludF9wcm9jZXNzLiBUaGUNCmlzc3VlIGlzIGRlc2NyaWJlZCBhcyBm
b2xsb3dzIChwcmVmaXhlZCBieSA+Pj4pDQoNCnN0YXRpYyB2b2lkIHNjYTMwMDBfcmluZ19p
bnRfcHJvY2Vzcyh1OCB2YWwsIHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQp7DQogICAg
ICAgICBzdHJ1Y3Qgc2NhMzAwMF9zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0K
ICAgICAgICAgaW50IHJldCwgaSwgbnVtX2F2YWlsYWJsZTsNCg0KICAgICAgICAgbXV0ZXhf
bG9jaygmc3QtPmxvY2spOw0KDQogICAgICAgICBpZiAodmFsICYgU0NBMzAwMF9SRUdfSU5U
X1NUQVRVU19IQUxGKSB7DQogICAgICAgICAgICAgICAgIHJldCA9IHNwaV93OHI4KHN0LT51
cywgDQpTQ0EzMDAwX1JFQURfUkVHKFNDQTMwMDBfUkVHX0JVRl9DT1VOVF9BRERSKSk7DQoN
Cg0KID4+Pg0KID4+PiAgdGhlIGNhbGwgdG8gc3BpX3c4cjggcmV0dXJucyAwIG9uIHN1Y2Nl
c3Mgb3IgLXZlIG9uIGFuIGVycm9yDQogPj4+DQoNCiAgICAgICAgICAgICAgICAgaWYgKHJl
dCkNCiAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX3JldDsNCg0KID4+Pg0K
ID4+PiByZXQgaXMgYWx3YXlzIHplcm8sIGF0IHRoaXMgcG9pbnQsIHNvIG51bV9hdmFpbGFi
bGUgaXMgemVybyB0b28NCiA+Pj4NCg0KICAgICAgICAgICAgICAgICBudW1fYXZhaWxhYmxl
ID0gcmV0Ow0KICAgICAgICAgICAgICAgICAvKg0KICAgICAgICAgICAgICAgICAgKiBudW1f
YXZhaWxhYmxlIGlzIHRoZSB0b3RhbCBudW1iZXIgb2Ygc2FtcGxlcyBhdmFpbGFibGUNCiAg
ICAgICAgICAgICAgICAgICogaS5lLiBudW1iZXIgb2YgdGltZSBwb2ludHMgKiBudW1iZXIg
b2YgY2hhbm5lbHMuDQogICAgICAgICAgICAgICAgICAqLw0KICAgICAgICAgICAgICAgICBy
ZXQgPSBzY2EzMDAwX3JlYWRfZGF0YShzdCwgU0NBMzAwMF9SRUdfUklOR19PVVRfQUREUiwg
DQpudW1fYXZhaWxhYmxlICogMik7DQogICAgICAgICAgICAgICAgIGlmIChyZXQpDQogICAg
ICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJvcl9yZXQ7DQoNCiA+Pj4NCiA+Pj4gIG51
bV9hdmFpbGFibGUgaXMgemVybywgc28gZm9yLWxvb3AgaXMgbmV2ZXIgZXhlY3V0ZWQuDQog
Pj4+DQoNCiAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IG51bV9hdmFpbGFibGUg
LyAzOyBpKyspIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAvKg0KICAgICAgICAgICAg
ICAgICAgICAgICAgICAqIERpcnR5IGhhY2sgdG8gY292ZXIgZm9yIDExIGJpdCBpbiBmaWZv
LCAxMyBiaXQNCiAgICAgICAgICAgICAgICAgICAgICAgICAgKiBkaXJlY3QgcmVhZGluZy4N
CiAgICAgICAgICAgICAgICAgICAgICAgICAgKg0KICAgICAgICAgICAgICAgICAgICAgICAg
ICAqIEluIHRoZW9yeSB0aGUgYm90dG9tIHR3byBiaXRzIGFyZSB1bmRlZmluZWQuDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICogSW4gcmVhbGl0eSB0aGV5IGFwcGVhciB0byBhbHdh
eXMgYmUgMC4NCiAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCiAgICAgICAgICAgICAg
ICAgICAgICAgICBpaW9fcHVzaF90b19idWZmZXJzKGluZGlvX2Rldiwgc3QtPnJ4ICsgaSAq
IDMgKiAyKTsNCiAgICAgICAgICAgICAgICAgfQ0KICAgICAgICAgfQ0KDQoNCkknbSBub3Qg
c3VyZSB3aGF0IHRoZSBsb2dpYyBzaG91bGQgYmUgdG8gZml4IHRoaXMsIHNvIEknbSByZXBv
cnRpbmcgdGhpcyANCmFzIGFuIGlzc3VlLg0KDQpSZWdhcmRzLA0KDQpDb2xpbg0K
--------------Z0aa8MZnotfM05nmdF5w36LD
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------Z0aa8MZnotfM05nmdF5w36LD--

--------------w7yRDwyjIUz80UzG1pilIPEX--

--------------jhIJhb7EBF6X68fmun5I0Chg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmhk9UcFAwAAAAAACgkQaMKH38aoAiZ6
ZRAApe8p6aQJ3gWjXj+zWCrq7SIZ39hDDhwg3TE6nCy0zpqKmn6e9xUFhxDOqxkoLIDrf/wSfQ4l
FZQB6xWtMt3ah3muGxzsHW7V21ipyZob/cElOonuPW7XEC3wdCle6OAVo6Hggg08lzKSgfdG47Qo
CP81z9BKwTrBbo1NVBCZ/T+6mltb8MtO1quJusfD7UWr8glfLByEoocg16POYFyHC4xDdE3yoXU3
6Zz6Lzj2UJoq1gIH8iJd8y0FWeW4dPunagLvk1oewbij1DK2FQFpa5vATae20fD3SbL307wJhkVZ
Ir1ZBszmYncdIMv4XYSVSM2fFoNI2+6AqJhU8h2Fc5aOZwPlCS4ewcbhc8+XKYEZfwmEi6nnHas3
KPjJqzMNHr0tje8SP6BD38HMNAv/qENdUhTYzFWuBhDZz2BnstOma27kah0y0o9CVpGPD3QMExF2
QVQi3Y31NNFhsXQYUR71xFvryvELiovJdeXFcevhc8y6tWOf5ZLyX83etfnyVFkzX3c9C2SrtbeN
7jgMCx1/E4MbRdHTfFgYpVOEFhcQUwto2U+0gEe+P/XUC7QWyEUQ58c9AJWdAQXHeNXSolIvzQol
bh+3iz0rB/R0hyz0dsPm6FIqfl6OGN/4GiAwBKjr3rK8+SdW0Dh8bVtLbe+keoqIuaCLxf55VRtD
Oao=
=SjrN
-----END PGP SIGNATURE-----

--------------jhIJhb7EBF6X68fmun5I0Chg--

