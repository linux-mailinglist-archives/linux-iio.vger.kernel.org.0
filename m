Return-Path: <linux-iio+bounces-704-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C04EC80844C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 10:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9AF61C21F78
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 09:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE39A33094;
	Thu,  7 Dec 2023 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBYK/yFC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF96510F0
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 01:21:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54d0ae6cf20so1015834a12.0
        for <linux-iio@vger.kernel.org>; Thu, 07 Dec 2023 01:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701940898; x=1702545698; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nRo0BngxYN+yz2OaMxWaLLebS2/YX6MynAJN1NRRNq4=;
        b=nBYK/yFCPhG1ShVybhminz9GhnSJRZZd6oMXe5JnyAol06ZepaSa33Phc9whS0RJXI
         hWrJtYBasw2bsA5SMpYQQNyDEUttTCOlCNK/Y6fpuauHYmuxbWMcuye00Rr/HUvOHtS4
         cIsTiEy4naIXMKsVOuBqkeScCrxxcU247ONM7bCHNJotWN/5asEwCuZ0oePUXvVEw12n
         8A/I/vdEOg1GTA1wfnaBVIpdiNackMiOInWMwZzOo9NYj7676oFcrt0Ek2mhHxf22oPC
         6gLwIP6TNpnK2dGi5h/PJstxC/h/p15nU0kd5obhBKCMNXJal8Be8fk0irwvGkS6imEm
         dDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940898; x=1702545698;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nRo0BngxYN+yz2OaMxWaLLebS2/YX6MynAJN1NRRNq4=;
        b=ODHptOx0wA2VGKCNTzxeEQF4TVX3qAkHCjlPYrvzU+R7iHUvBSG8agghGfGj9/0Hlq
         hXk5pULHR3sQh18OxU0tMOrp6ijZqCJyAxABU3eRo15jBglWQx9CRKh8jNETJRG8w7Sm
         qjb223kbwK7X5FvMVDjYl79CAUeGOQ5waYMzkOqt+0LHXhqe3UV2+Z4xWtkXMJ3bLn67
         XURz1YaT7iiOV9xWoG26wlcxW1uvh1uvMXqADTbx8ThUcv5nwVMhXSHRWxBkIMpgEVMT
         c0UdRmUw24BqMQZNeVAg3CwS6ZatzcUB08nBgQizjQJomg+aLDvRFiRrUA5ys/RnIuwm
         4OVw==
X-Gm-Message-State: AOJu0YwL56yHG5uC03UkmvLpN1XtUQQwdBJzd3hhtbbOD264XtiltA/P
	xssg7dh+R/Pt5t40cS4gsx4=
X-Google-Smtp-Source: AGHT+IEuKA+/dwsIEDN0GJ73pOpvYFROYMEFIy0/uOmyVOw4VQTXprJHSaE5tcY1A6hx73YKmtmpbQ==
X-Received: by 2002:a17:906:71d2:b0:a19:a1ba:da37 with SMTP id i18-20020a17090671d200b00a19a1bada37mr1453935ejk.94.1701940898043;
        Thu, 07 Dec 2023 01:21:38 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id u21-20020a1709060b1500b00a1937153bddsm564287ejg.20.2023.12.07.01.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 01:21:37 -0800 (PST)
Message-ID: <26f57ceec3f2cd15bf1643ea6accd99b88936da2.camel@gmail.com>
Subject: Re: [PATCH 4/8] iio: adc: ad9467: fix scale setting
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 07 Dec 2023 10:21:37 +0100
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
Cj4gCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gSUlPX0FWQUlMX0xJ
U1Q7Cj4gPiArwqDCoMKgwqDCoMKgIGRlZmF1bHQ6Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPiA+ICvCoMKgwqDCoMKgwqAgfQo+ID4gK30KPiA+ICsK
PiA+IMKgc3RhdGljIGludCBhZDk0Njdfb3V0cHV0bW9kZV9zZXQoc3RydWN0IHNwaV9kZXZpY2Ug
KnNwaSwgdW5zaWduZWQgaW50IG1vZGUpCj4gPiDCoHsKPiA+IMKgwqDCoMKgwqDCoMKgIGludCBy
ZXQ7Cj4gPiBAQCAtMzgyLDYgKzQwNCwyNiBAQCBzdGF0aWMgaW50IGFkOTQ2N19vdXRwdXRtb2Rl
X3NldChzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpLAo+ID4gdW5zaWduZWQgaW50IG1vZGUpCj4gPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBBTjg3N19BRENfVFJBTlNGRVJfU1lOQyk7Cj4gPiDCoH0KPiA+IAo+ID4gK3N0YXRpYyBp
bnQgYWQ5NDY3X3NjYWxlX2ZpbGwoc3RydWN0IGFkaV9heGlfYWRjX2NvbnYgKmNvbnYpCj4gPiAr
ewo+ID4gK8KgwqDCoMKgwqDCoCBjb25zdCBzdHJ1Y3QgYWRpX2F4aV9hZGNfY2hpcF9pbmZvICpp
bmZvID0gY29udi0+Y2hpcF9pbmZvOwo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgYWQ5NDY3X3N0
YXRlICpzdCA9IGFkaV9heGlfYWRjX2NvbnZfcHJpdihjb252KTsKPiA+ICvCoMKgwqDCoMKgwqAg
dW5zaWduZWQgaW50IGksIHZhbDEsIHZhbDI7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgIHN0LT5z
Y2FsZXMgPSBkZXZtX2tjYWxsb2MoJnN0LT5zcGktPmRldiwgQVJSQVlfU0laRSgqc3QtPnNjYWxl
cyksCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpbmZvLT5udW1fc2NhbGVzLCBHRlBfS0VSTkVMKTsKPiAKPiBJZiBJ
J20gcmVhZGluZyB0aGlzIGNvcnJlY3RseSwgaXQgc2F5cyB0byBhbGxvY2F0ZSBhbiBhcnJheSB3
aXRoIG49Mgo+IGVsZW1lbnRzIChBUlJBWV9TSVpFKCpzdC0+c2NhbGVzKSA9PSAyKSBhbmQgdGhl
IGVsZW1lbnRzIGhhdmUKPiBzaXplPWluZm8tPm51bV9zY2FsZXMgYnl0ZXMuCj4gCgpIbW0sIHlv
dSdyZSBjb21wbGV0ZWx5IHJpZ2h0ISBJJ20gcHJldHR5IHN1cmUgSSB0ZXN0ZWQgdGhpcyBzbyBJ
J20gd29uZGVyaW5nIGhvdyBpdAp3b3JrZWQuIE1heWJlIEkgZGlkIGEgbGFzdCBtaW51dGUgKHN0
dXBpZCkgY2hhbmdlLgogCj4gSXQgc2VlbXMgbGlrZSB0aGlzIHNob3VsZCBiZToKPiAKPiDCoMKg
wqDCoMKgwqDCoCBzdC0+c2NhbGVzID0gZGV2bV9rbWFsbG9jX2FycmF5KCZzdC0+c3BpLT5kZXYs
IGluZm8tPm51bV9zY2FsZXMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVvZigqc3QtPnNj
YWxlcyksIEdGUF9LRVJORUwpOwo+IAo+IFdoaWNoIGFsbG9jYXRlcyBuPWluZm8tPm51bV9zY2Fs
ZXMgZWxlbWVudHMgYW5kIHRoZSBlbGVtZW50cyBoYXZlCj4gc2l6ZT04IGJ5dGVzIChzaXplb2Yo
KnN0LT5zY2FsZXMpID09IDgpLgo+IAo+IChhbHNvIGNoYW5nZWQgdG8gZGV2bV9rbWFsbG9jX2Fy
cmF5KCkgc2luY2UgaXQgZG9lc24ndCBsb29rIGxpa2UgaXQKPiBuZWVkcyB0byBiZSB6ZXJvZWQg
c2luY2UgYWxsIHZhbHVlcyBhcmUgYXNzaWduZWQgYmVsb3cpCj4gCj4gPiArwqDCoMKgwqDCoMKg
IGlmICghc3QtPnNjYWxlcykKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biAtRU5PTUVNOwo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgaW5mby0+
bnVtX3NjYWxlcyAqIDI7IGkrKykgewo+IAo+IElzIGAqIDJgIGNvcnJlY3QgaGVyZT8gQXNzdW1p
bmcgb25seSBpbmZvLT5udW1fc2NhbGVzIGVsZW1lbnRzIHdlcmUgYWxsb2NhdGVkLgoKTm8sIGRv
bid0IHRoaW5rIHNvLi4uIFRoaXMgc2hvdWxkIGFjdHVhbGx5IGxlYWQgdG8gYW4gb3V0IG9mIGJv
dW5kcyBhY2Nlc3MuCgotIE51bm8gU8OhCj4gCg==


