Return-Path: <linux-iio+bounces-19228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12864AAD81D
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 09:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69573AA74F
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 07:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2702153D0;
	Wed,  7 May 2025 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCNCYdR7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81D433AC;
	Wed,  7 May 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602871; cv=none; b=hqaP8Rg3oVIqQJtK3ZuqLzoPMHg9JzmIfK/2woNJ5p6IQg3oD7OBjHcuTh5vetR8o0l8ywk4ciM+ME820gRsoTgAuB5Y7weuCG82Fh7U2XgYTQC5lurvtosEG31Tj3VlOdLWPBrNOhldFwu0SQd3mZx7IZebwN88X4JPZkSu/bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602871; c=relaxed/simple;
	bh=Zt4lyMWlCZvfxvpYPOWhlNYq6Oo260i86wLpnf82PRo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uEz3O2e7L3CcZUB1iuyrkF3G6hoCdS1/LhJX25biBwg4xfNsD5mYz2fNYOFdLC2eK9mtdftAheHTNilaVJxN78ciqbo55HDPjdKzmA+AFtGzFJcRy4LsLj7wFKBfVpJTqJwj+BXOpJsRvm21c1LUcQud3/3hunQpBcNR4NwHvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCNCYdR7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-39c266c1389so4842061f8f.1;
        Wed, 07 May 2025 00:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746602868; x=1747207668; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zt4lyMWlCZvfxvpYPOWhlNYq6Oo260i86wLpnf82PRo=;
        b=SCNCYdR7AASwLQDidSpUbbuXjFwoDXp4pDiDjegs5dJRwbaZe7Vqelslt0h+UXP4rC
         Fb0bbL4oqj/quck0oK8YtjT6YwqjPsHqPnfNq4GWfFvyXwnU6SM8yKcpIeWLov/0fe5N
         65oP/npe/l28gAQ4HEjTg75MJRCVwGfWhzenBUsNNguC/jxpkn9kiHSnUrIwvnVWch5s
         lX1/UCuWS31Gn8mlIchjNmtZtQfPpGTDibG0ljYdn1WY08xsKfI6l3sQ043pndPwMk2E
         o+YqhYyCb5ieQ+FP8DHfX4ak9YgEPWW02ckfPC/FmXu3s60QbIh8bTw6xh3V9lVRMi10
         ncPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746602868; x=1747207668;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zt4lyMWlCZvfxvpYPOWhlNYq6Oo260i86wLpnf82PRo=;
        b=JwX+S9xI0Ykw2GdJfQKqD59IO57rxJwQWqPLKoww7thmGBA2LSLpljkchCzuoDYdTh
         y4kEXLzkS1OHfZBjgbj/kUapwCz49k3/m7DMaZy+e9SYN+y7XHWFnSTAbwI87ij1Lz/H
         iOUfALLma3EB/Urb81p8jHo1nPuQ/9IdG7WHuz9zBmUAbnE+0E1b6UwZufBC7SqlqUh/
         7/UrSMmQ+86aF9kta7eLq49ncU+Y2GS292+d622P0KkwsCNmnE91PYJQFgn8TcM2k9Qs
         Tn0/nzLjgfI4RDeHCfOa4j1HEMxObSC20pOvpzr/27LcQW8a+jxjZkIhLBRtoqHdE352
         /Zqg==
X-Forwarded-Encrypted: i=1; AJvYcCV+0UIBzLb18ezysDxPCZlJX4gdysO15lVqau19KLkHHI59iPuTD/U6EnkQHXTa2JlVXT9JGwnVXWIqCSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7N8u9epHnbAXt7WkFY6fVt6viXle+iPOsKNS8j6daA66d9m+
	gdCtHXZRCej6jVgNwGdYyGIeMu+IbrGih9+/HZSe74F6QmhHpBWY
X-Gm-Gg: ASbGncsB0fpP5Ysn47ZJJvfi1tkxr3FZP2BfrxY6KhtKmJcX/LkyGatuGVph1Qhm7IE
	AKZB+cXhq/GLmFbao/si6oHiol6oEHGmo0hy9i7a8IYibF4/cLkg9z9GVbqLJi5J5flY601pHaa
	/jx7OEkzrkc0gokCt9ClXwASGDzcMCFFVYJ2RYzvPd8NWcNu2OCQWIsdz79l5QdB69pwt+El3vo
	vx7gOlRlhGLjJtNhhkSsIQmBu/TyQenlv0IpvBR61wesV+L6z9DjrW2vOGZI/6rLF4lA7tk+8ng
	jOdAwFtOnWj3sSIWF7E3fiz9i1vBYW00RLcF9hrMl69/SjPLDSKr3ExbuVzSaCxzj2mplEbx62V
	EHiBLVB/JTqK6dGw=
X-Google-Smtp-Source: AGHT+IHsyfUCqeQE65FIXjr5nnb+qaLtdMQz0T+sGnB0udi/PuCsCIBRxM92n/0nRon016TTE8LIyQ==
X-Received: by 2002:a05:6000:186d:b0:3a0:b392:c2f with SMTP id ffacd0b85a97d-3a0b4a191a4mr1609739f8f.44.1746602868044;
        Wed, 07 May 2025 00:27:48 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae7bb3sm16183337f8f.51.2025.05.07.00.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 00:27:47 -0700 (PDT)
Message-ID: <4678d4f0c5634f8709f84745054ae16484617b8d.camel@gmail.com>
Subject: Re: [PATCH 00/14] iio: remove bits_per_word = 8 assignments
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Esteban Blanc
 <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
 <andy@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 kernel@pengutronix.de, Song Qiang <songqiang1304521@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 07 May 2025 07:28:12 +0100
In-Reply-To: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
References: 
	<20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI1LTA1LTA1IGF0IDE0OjIwIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IFdoaWxlIGdyZXBwaW5nIHRoZSBJSU8gc3Vic3lzdGVtIGZvciBkcml2ZXJzIHRoYXQgc2V0IGJp
dHNfcGVyX3dvcmQgdG8KPiB1bnVzdWFsIHZhbHVlcyB0byBjaGVjayBmb3IgcG90ZW50aWFsIGJ1
Z3MsIEkgZm91bmQgaXQgdG8gYmUgYSBiaXQgb2YgYQo+IG51aXNhbmNlIHRoYXQgMi8zcyBvZiB0
aGUgbWF0Y2hlcyB3ZXJlIHNldHRpbmcgaXQgdG8gdGhlIGRlZmF1bHQgdmFsdWUKPiBvZiA4LiBT
byBoZXJlIGlzIGEgc2VyaWVzIHJlbW92aW5nIHRoZSB1bm5lY2Vzc2FyeSBhc3NpZ25tZW50cy4K
PiAKPiAtLS0KCkxHVE0sCgpSZXZpZXdlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNv
bT4KCj4gRGF2aWQgTGVjaG5lciAoMTQpOgo+IMKgwqDCoMKgwqAgaWlvOiBhZGM6IGFkNDAzMDog
cmVtb3ZlIGJpdHNfcGVyX3dvcmQgPSA4Cj4gwqDCoMKgwqDCoCBpaW86IGFkYzogdGktdHNjMjA0
NjogcmVtb3ZlIGJpdHNfcGVyX3dvcmQgPSA4Cj4gwqDCoMKgwqDCoCBpaW86IGNoZW1pY2FsOiBi
bWU2ODBfc3BpOiByZW1vdmUgYml0c19wZXJfd29yZCA9IDgKPiDCoMKgwqDCoMKgIGlpbzogZGFj
OiBhZDU3NjE6IHJlbW92ZSBiaXRzX3Blcl93b3JkID0gOAo+IMKgwqDCoMKgwqAgaWlvOiBkYWM6
IGFkNTc2NjogcmVtb3ZlIGJpdHNfcGVyX3dvcmQgPSA4Cj4gwqDCoMKgwqDCoCBpaW86IGRhYzog
YWQ1NzkxOiByZW1vdmUgYml0c19wZXJfd29yZCA9IDgKPiDCoMKgwqDCoMKgIGlpbzogZGFjOiBs
dGMyNjg4OiByZW1vdmUgYml0c19wZXJfd29yZCA9IDgKPiDCoMKgwqDCoMKgIGlpbzogZ3lybzog
YWR4cnM0NTA6IHJlbW92ZSBiaXRzX3Blcl93b3JkID0gOAo+IMKgwqDCoMKgwqAgaWlvOiBpbXU6
IGFkaXM6IHJlbW92ZSBiaXRzX3Blcl93b3JkID0gOAo+IMKgwqDCoMKgwqAgaWlvOiBtYWduZXRv
bWV0ZXI6IGhtYzU4NDNfc3BpOiByZW1vdmUgYml0c19wZXJfd29yZCA9IDgKPiDCoMKgwqDCoMKg
IGlpbzogbWFnbmV0b21ldGVyOiBybTMxMDAtc3BpOiByZW1vdmUgYml0c19wZXJfd29yZCA9IDgK
PiDCoMKgwqDCoMKgIGlpbzogcHJlc3N1cmU6IGJtcDI4MC1zcGk6IHJlbW92ZSBiaXRzX3Blcl93
b3JkID0gOAo+IMKgwqDCoMKgwqAgaWlvOiBwcmVzc3VyZTogbXM1NjExX3NwaTogcmVtb3ZlIGJp
dHNfcGVyX3dvcmQgPSA4Cj4gwqDCoMKgwqDCoCBpaW86IHByZXNzdXJlOiB6cGEyMzI2X3NwaTog
cmVtb3ZlIGJpdHNfcGVyX3dvcmQgPSA4Cj4gCj4gwqBkcml2ZXJzL2lpby9hZGMvYWQ0MDMwLmPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNCAtLS0tCj4gwqBkcml2ZXJzL2lpby9hZGMv
dGktdHNjMjA0Ni5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxIC0KPiDCoGRyaXZlcnMvaWlvL2No
ZW1pY2FsL2JtZTY4MF9zcGkuY8KgwqDCoMKgwqAgfCA4IC0tLS0tLS0tCj4gwqBkcml2ZXJzL2lp
by9kYWMvYWQ1NzYxLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMiAtLQo+IMKgZHJp
dmVycy9paW8vZGFjL2FkNTc2Ni5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIgLS0K
PiDCoGRyaXZlcnMvaWlvL2RhYy9hZDU3OTEuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCAyIC0tCj4gwqBkcml2ZXJzL2lpby9kYWMvbHRjMjY4OC5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyIC0tCj4gwqBkcml2ZXJzL2lpby9neXJvL2FkeHJzNDUwLmPCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHwgNSAtLS0tLQo+IMKgZHJpdmVycy9paW8vaW11L2FkaXMuY8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgOSAtLS0tLS0tLS0KPiDCoGRyaXZlcnMvaWlvL2ltdS9h
ZGlzX2J1ZmZlci5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMyAtLS0KPiDCoGRyaXZlcnMvaWlvL21h
Z25ldG9tZXRlci9obWM1ODQzX3NwaS5jIHwgMSAtCj4gwqBkcml2ZXJzL2lpby9tYWduZXRvbWV0
ZXIvcm0zMTAwLXNwaS5jwqAgfCAxIC0KPiDCoGRyaXZlcnMvaWlvL3ByZXNzdXJlL2JtcDI4MC1z
cGkuY8KgwqDCoMKgwqAgfCA4IC0tLS0tLS0tCj4gwqBkcml2ZXJzL2lpby9wcmVzc3VyZS9tczU2
MTFfc3BpLmPCoMKgwqDCoMKgIHwgMSAtCj4gwqBkcml2ZXJzL2lpby9wcmVzc3VyZS96cGEyMzI2
X3NwaS5jwqDCoMKgwqAgfCAxIC0KPiDCoDE1IGZpbGVzIGNoYW5nZWQsIDUwIGRlbGV0aW9ucygt
KQo+IC0tLQo+IGJhc2UtY29tbWl0OiA3ZTlhODJhYjViODYxZDNjMzNjOTlhMjJjMTI0NWE1YjI2
MmVlNTAyCj4gY2hhbmdlLWlkOiAyMDI1MDUwNS1paW8tcmVtb3ZlLWJpdHNfcGVyX3dvcmQtOC1k
YjgwNjU0YjFjMTcKPiAKPiBCZXN0IHJlZ2FyZHMsCgo=


