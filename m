Return-Path: <linux-iio+bounces-705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1B2808513
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 11:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDE21C2141A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 10:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4814A35287;
	Thu,  7 Dec 2023 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAU0QzPh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51FA8
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 02:02:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c236624edso8122545e9.1
        for <linux-iio@vger.kernel.org>; Thu, 07 Dec 2023 02:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701943358; x=1702548158; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3al6Z8c0JFiZxCl52br81mQxhmyQA1wGCy8L+YI5LW0=;
        b=eAU0QzPhynuz3CTwFyswLj6C/Oy+sLCg8/yUV3711dc//t3+1ckf/3ZYo8laU2GSoM
         0/3U1xfJDErkgK+u20mjoLeZrsgGAn9SB+D4Vse0TQbot1e5aZAvWlrVgpOc9qQgRzFG
         9/vcPhwSnDrYU0WY3O7utVfnKU7RONFElD/y+s3zmHVKKlCzCMPWY/1FpUpji6z1hSq1
         M0/Kc9r1H/ih4oBnsuxl5VPTvaxZR54NmTAZD39dmgXwVFV6NTAtH4CPPtLDn3zPpQk5
         qG0MHA4jJeSSjs5xV1QqNNqyecXo4LaFJyeaUJMEw5164G7U6qFfOmp7cVtJezLA1vz0
         D1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701943358; x=1702548158;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3al6Z8c0JFiZxCl52br81mQxhmyQA1wGCy8L+YI5LW0=;
        b=uCFU64Wx8Qw08SwOY+LnAsbxQZCC/rubSVv9dqj+4ovUdd4XcFjbVD9RtMGdMUvVxQ
         XrwGhu9Ez2T9Wxw79SEihE8eiFtUxLPFbhtIe9e2G9ZvOySqp7r9HwQX2OcTavjgi4Vx
         KlXcUdzMacIcjxz0vxByJwy67e41PGAzbEKMN9FYArMw3hzqG1IikwjQqrN8p11nAWvV
         zCzcQxvoOsC5kpCV+remsNOE9tHjIbXRm6juaBUPymsVjvVARZX0XAPZHDR+8t5iM5rM
         116YhBXhMne8aeo0eJvbcfMioNVu69/VTQVnPm8uCgIqBijPmAEWEosY7D46IbCndJXi
         fcog==
X-Gm-Message-State: AOJu0Yx59dSHRKjJFCaRizYWVjEZBi/7xRfnkOuZle2Wacl6KQ4LsJYP
	m8x66sBvnX1W8yj0+vqQuKvn7oVXIl0mVMVI
X-Google-Smtp-Source: AGHT+IHhGRhc1nbSRS4Ni/ZA0d9fbHBHXaM8CWeF0+b6rmt53pVEHeutD+oT6wrulxBhYfoA/d+8bA==
X-Received: by 2002:a05:600c:4f82:b0:40b:5e21:cc29 with SMTP id n2-20020a05600c4f8200b0040b5e21cc29mr1424261wmq.84.1701943357574;
        Thu, 07 Dec 2023 02:02:37 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b0040b4b66110csm1362808wmo.22.2023.12.07.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:02:37 -0800 (PST)
Message-ID: <5a157ef34eb4c713f66ee49f088747135d4d1cd9.camel@gmail.com>
Subject: Re: [PATCH 4/8] iio: adc: ad9467: fix scale setting
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 07 Dec 2023 11:02:36 +0100
In-Reply-To: <CAMknhBF84oWxgGpyj=6S013qCrqHXRFk6Apub94FN6SUcWSmsA@mail.gmail.com>
References: <20231205-iio-backend-prep-v1-0-7c9bc18d612b@analog.com>
	 <20231205-iio-backend-prep-v1-4-7c9bc18d612b@analog.com>
	 <CAMknhBF84oWxgGpyj=6S013qCrqHXRFk6Apub94FN6SUcWSmsA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDIzLTEyLTA2IGF0IDE3OjAxIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOgo+
IE9uIFR1ZSwgRGVjIDUsIDIwMjMgYXQgMTE6MDbigK9BTSBOdW5vIFNhIHZpYSBCNCBSZWxheQo+
IDxkZXZudWxsK251bm8uc2EuYW5hbG9nLmNvbUBrZXJuZWwub3JnPiB3cm90ZToKPiA+IAo+ID4g
RnJvbTogTnVubyBTYSA8bnVuby5zYUBhbmFsb2cuY29tPgo+ID4gCj4gPiBXaGVuIHJlYWRpbmcg
aW5fdm9sdGFnZV9zY2FsZSB3ZSBjYW4gZ2V0IHNvbWV0aGluZyBsaWtlOgo+ID4gCj4gPiByb290
QGFuYWxvZzovc3lzL2J1cy9paW8vZGV2aWNlcy9paW86ZGV2aWNlMiMgY2F0IGluX3ZvbHRhZ2Vf
c2NhbGUKPiA+IDAuMDM4MTQ2Cj4gPiAKPiA+IEhvd2V2ZXIsIHdoZW4gcmVhZGluZyB0aGUgYXZh
aWxhYmxlIG9wdGlvbnM6Cj4gPiAKPiA+IHJvb3RAYW5hbG9nOi9zeXMvYnVzL2lpby9kZXZpY2Vz
L2lpbzpkZXZpY2UyIyBjYXQKPiA+IGluX3ZvbHRhZ2Vfc2NhbGVfYXZhaWxhYmxlCj4gPiAyMDAw
LjAwMDAwMCAyMTAwLjAwMDAwNiAyMjAwLjAwMDAwNyAyMzAwLjAwMDAwOCAyNDAwLjAwMDAwOSAy
NTAwLjAwMDAxMAo+ID4gCj4gPiB3aGljaCBkb2VzIG5vdCBtYWtlIHNlbnNlLiBNb3Jlb3Zlciwg
d2hlbiB0cnlpbmcgdG8gc2V0IGEgbmV3IHNjYWxlIHdlCj4gPiBnZXQgYW4gZXJyb3IgYmVjYXVz
ZSB0aGVyZSdzIG5vIGNhbGwgdG8gX19hZDk0NjdfZ2V0X3NjYWxlKCkgdG8gZ2l2ZSB1cwo+ID4g
dmFsdWVzIGFzIGdpdmVuIHdoZW4gcmVhZGluZyBpbl92b2x0YWdlX3NjYWxlLiBGaXggaXQgYnkg
Y29tcHV0aW5nIHRoZQo+ID4gYXZhaWxhYmxlIHNjYWxlcyBkdXJpbmcgcHJvYmUgYW5kIHByb3Bl
cmx5IHBhc3MgdGhlIGxpc3Qgd2hlbgo+ID4gLnJlYWRfYXZhaWxhYmxlKCkgaXMgY2FsbGVkLgo+
ID4gCj4gPiBXaGlsZSBhdCBpdCwgY2hhbmdlIHRvIHVzZSAucmVhZF9hdmFpbGFibGUoKSBmcm9t
IGlpb19pbmZvLiBBbHNvIG5vdGUKPiA+IHRoYXQgdG8gcHJvcGVybHkgZml4IHRoaXMsIGFkaS1h
eGktYWRjLmMgaGFzIHRvIGJlIGNoYW5nZWQgYWNjb3JkaW5nbHkuCj4gPiAKPiA+IEZpeGVzOiBh
ZDY3OTcxMjAyMzggKCJpaW86IGFkYzogYWQ5NDY3OiBhZGQgc3VwcG9ydCBBRDk0NjcgQURDIikK
PiA+IFNpZ25lZC1vZmYtYnk6IE51bm8gU2EgPG51bm8uc2FAYW5hbG9nLmNvbT4KPiA+IC0tLQo+
ID4gwqBkcml2ZXJzL2lpby9hZGMvYWQ5NDY3LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNDcg
KysrKysrKysrKysrKysrKysrKysrKysKPiA+IMKgZHJpdmVycy9paW8vYWRjL2FkaS1heGktYWRj
LmPCoMKgwqDCoMKgwqAgfCA3NCArKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gPiDCoGluY2x1ZGUvbGludXgvaWlvL2FkYy9hZGktYXhpLWFkYy5oIHzCoCA0ICsrCj4gPiDC
oDMgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKSwgNTkgZGVsZXRpb25zKC0pCj4gPiAK
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYWQ5NDY3LmMgYi9kcml2ZXJzL2lpby9h
ZGMvYWQ5NDY3LmMKPiA+IGluZGV4IGJhZGJlZjJjZTlmOC4uM2M4YmQ2YzgyMWE0IDEwMDY0NAo+
ID4gLS0tIGEvZHJpdmVycy9paW8vYWRjL2FkOTQ2Ny5jCj4gPiArKysgYi9kcml2ZXJzL2lpby9h
ZGMvYWQ5NDY3LmMKPiA+IEBAIC0xMjAsNiArMTIwLDcgQEAgc3RydWN0IGFkOTQ2N19zdGF0ZSB7
Cj4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qgc3BpX2RldmljZcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKnNwaTsKPiA+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBjbGvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKmNsazsKPiA+IMKgwqDCoMKgwqDCoMKgIHVu
c2lnbmVkIGludMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG91dHB1dF9t
b2RlOwo+ID4gK8KgwqDCoMKgwqDCoCB1bnNpZ25lZCBpbnTCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAoKnNjYWxlcylbMl07Cj4gPiAKPiA+IMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBncGlvX2Rlc2PCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnB3cmRvd25fZ3Bp
bzsKPiA+IMKgwqDCoMKgwqDCoMKgIC8qIGVuc3VyZSBjb25zaXN0ZW50IHN0YXRlIG9idGFpbmVk
IG9uIG11bHRpcGxlIHJlbGF0ZWQgYWNjZXNzZXMgKi8KPiA+IEBAIC0yMTYsNiArMjE3LDcgQEAg
c3RhdGljIHZvaWQgX19hZDk0NjdfZ2V0X3NjYWxlKHN0cnVjdCBhZGlfYXhpX2FkY19jb252ICpj
b252LAo+ID4gaW50IGluZGV4LAo+ID4gwqDCoMKgwqDCoMKgwqAgLmNoYW5uZWwgPSBfY2hhbizC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiDCoMKgwqDCoMKgwqDCoCAu
aW5mb19tYXNrX3NoYXJlZF9ieV90eXBlID0gQklUKElJT19DSEFOX0lORk9fU0NBTEUpIHzCoMKg
wqDCoMKgwqDCoMKgwqAgXAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEJJVChJ
SU9fQ0hBTl9JTkZPX1NBTVBfRlJFUSkswqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgIC5pbmZvX21hc2tfc2hhcmVk
X2J5X3R5cGVfYXZhaWxhYmxlID0gQklUKElJT19DSEFOX0lORk9fU0NBTEUpLCBcCj4gPiDCoMKg
wqDCoMKgwqDCoCAuc2Nhbl9pbmRleCA9IF9zaSzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXAo+ID4gwqDCoMKgwqDCoMKgwqAgLnNjYW5fdHlwZSA9IHvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgLnNpZ24gPSBfc2lnbizCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+IEBAIC0z
NzAsNiArMzcyLDI2IEBAIHN0YXRpYyBpbnQgYWQ5NDY3X3dyaXRlX3JhdyhzdHJ1Y3QgYWRpX2F4
aV9hZGNfY29udiAqY29udiwKPiA+IMKgwqDCoMKgwqDCoMKgIH0KPiA+IMKgfQo+ID4gCj4gPiAr
c3RhdGljIGludCBhZDk0NjdfcmVhZF9hdmFpbChzdHJ1Y3QgYWRpX2F4aV9hZGNfY29udiAqY29u
diwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RydWN0IGlpb19jaGFuX3NwZWMgY29uc3QgKmNoYW4sCj4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IGludCAqKnZh
bHMsIGludCAqdHlwZSwgaW50ICpsZW5ndGgsCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGxvbmcgbWFzaykKPiA+ICt7Cj4gPiArwqDC
oMKgwqDCoMKgIGNvbnN0IHN0cnVjdCBhZGlfYXhpX2FkY19jaGlwX2luZm8gKmluZm8gPSBjb252
LT5jaGlwX2luZm87Cj4gPiArwqDCoMKgwqDCoMKgIHN0cnVjdCBhZDk0Njdfc3RhdGUgKnN0ID0g
YWRpX2F4aV9hZGNfY29udl9wcml2KGNvbnYpOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBzd2l0
Y2ggKG1hc2spIHsKPiA+ICvCoMKgwqDCoMKgwqAgY2FzZSBJSU9fQ0hBTl9JTkZPX1NDQUxFOgo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnZhbHMgPSAoY29uc3QgaW50ICopc3Qt
PnNjYWxlczsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICp0eXBlID0gSUlPX1ZB
TF9JTlRfUExVU19NSUNSTzsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIFZh
bHVlcyBhcmUgc3RvcmVkIGluIGEgMkQgbWF0cml4ICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqbGVuZ3RoID0gaW5mby0+bnVtX3NjYWxlcyAqIDI7Cj4gCj4gTWF5YmUgdXNl
IEFSUkFZX1NJWkUoKmluZm8tPnNjYWxlcykgaGVyZSBpbnN0ZWFkIG9mIGhhcmQtY29kaW5nIDI/
CgpOb3QgdG8ga2VlbiBvbiB0aGF0IGFzIHRoZSBjb21tZW50IHNob3VsZCBhbHJlYWR5IHNheSBl
dmVyeXRoaW5nIGFib3V0IHRoZSBoYXJkY29kZWQKMi4KCi0gTnVubyBTw6EKCgo=


